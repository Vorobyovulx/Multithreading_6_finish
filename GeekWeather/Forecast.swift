//
//  Forecast.swift
//  GeekWeather
//
//  Created by Mad Brains on 06.07.2020.
//  Copyright © 2020 GeekTest. All rights reserved.
//

import Foundation
import UIKit

struct ForecastViewModel {
    
    var weekday: String?
    var temperature: String?
    var weatherCondition: String?
    var iconUrl: String?
    let date: Double?
    
    init(model: WeatherInformationDTO) {
        self.weekday = ForecastViewModel.getDayOfWeek(from: model.date ?? 0.0)
        self.date = model.date
        self.weatherCondition = model.weatherCondition?[0].conditionName
        self.temperature = "\(ConversionWorker.convertToCelsius(model.atmosphericInformation?.temperatureKelvin ?? 0.0)) \(Constants.Values.TemperatureUnit.kCelsius)"
        guard let iconName = model.weatherCondition?[0].icon else {
            return
        }
        
        self.iconUrl = "https://api.openweathermap.org/img/w/\(iconName).png"
    }
    
    static func getDayOfWeek(from fromDate: Double) -> String {
        let date = Date(timeIntervalSince1970: fromDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd,yyyy"//"EEEE"
        
        let dayOfWeekString = dateFormatter.string(from: date)
        
        return dayOfWeekString
    }
    
}
