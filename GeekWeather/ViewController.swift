//
//  ViewController.swift
//  GeekWeather
//
//  Created by Mad Brains on 29.06.2020.
//  Copyright © 2020 GeekTest. All rights reserved.
//

import UIKit
import JGProgressHUD
import PromiseKit
import RealmSwift
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let weatherService = WeatherDataService(networking: NetworkService())
    
    private let hud = JGProgressHUD(style: .dark)
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var weatherForecasts = [ForecastViewModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let dataFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH.mm"
        return df
    }()
    
    private var dateTextCache: [IndexPath: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hud.textLabel.text = "Loading"

        hud.show(in: view)
        configureTableView()
        weatherService.fetchFiveDayForecast(
            "Moscow",
            completion: { result in
                switch result {
                case let .success(forecast):
                    self.weatherForecasts = (forecast?.compactMap(ForecastViewModel.init)) ?? []
                    self.hud.dismiss(animated: true)
                    self.tableView.reloadData()
                case .failure(_):
                    self.hud.dismiss(animated: true)
                }
            }
        )
    }
    
    private func configureTableView() {
        tableView.register(
            UINib(nibName: "WeatherCell", bundle: nil),
            forCellReuseIdentifier: "WeatherCellID"
        )
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func locationAuthStatus() {
        let authStatus = CLLocationManager.authorizationStatus()
        
        while !(authStatus == .authorizedWhenInUse || authStatus == .authorizedAlways) {
            locationManager.requestWhenInUseAuthorization()
            sleep(5)
        }
        
        currentLocation = locationManager.location
        Location.shared.set(fromLocation: currentLocation)
    }
    
    func getDayOfWeek(from fromDate: Double) -> String {
        let date = Date(timeIntervalSince1970: fromDate)
        
        let dayOfWeekString = dataFormatter.string(from: date)
        
        return dayOfWeekString
    }
    
    private func getCellDateText(forIndexPath indexPath: IndexPath) -> String {
        if let stringDate = dateTextCache[indexPath] {
            return stringDate
        } else {
            let day = getDayOfWeek(from: weatherForecasts[indexPath.row].date ?? 0.0)
            dateTextCache[indexPath] = day
            return day
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         weatherForecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCellID", for: indexPath) as? WeatherCell
        
        print("ROW NUMBER: \(indexPath.row)")
        
        guard let uCell = cell else {
            print("There are some errors with reuse cell")
            return UITableViewCell()
        }
        
        let curDate = getCellDateText(forIndexPath: indexPath)
        uCell.configure(with: weatherForecasts[indexPath.row], day: curDate)
        
        return uCell
    }
    
}

