//
//  WeatherCell.swift
//  GeekWeather
//
//  Created by Mad Brains on 02.07.2020.
//  Copyright © 2020 GeekTest. All rights reserved.
//

import UIKit
import Kingfisher
class WeatherCell: UITableViewCell {
    
    @IBOutlet weak var weatherImageView: UIImageView! {
        didSet {
            weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var dayLabel: UILabel! {
        didSet {
            dayLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var maxTemp: UILabel! {
        didSet {
            maxTemp.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    @IBOutlet weak var condition: UILabel! {
        didSet {
            condition.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    var insetets: CGFloat = 10
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setWeatherLabelFrame()
        setTimeLableFrame()
        setImageFrame()
    }
    
    private func calculateLabelSize(text: String, font: UIFont) -> CGSize {
        let maxWidth = bounds.width - insetets * 2
        
        let textBlockSize = CGSize(
            width: maxWidth,
            height: CGFloat.greatestFiniteMagnitude
        )
        
        let curText = text as NSString
        
        let rect = curText.getBoundingRect(textBlock: textBlockSize, font: font)
        
        
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        
        let size = CGSize(width: ceil(width), height: ceil(height))
    
        return size
    }

    func setWeatherLabelFrame() {
        let weatherLabelSize = calculateLabelSize(text: maxTemp.text ?? "", font: .systemFont(ofSize: 14))
        
        let weatherLabelxPos = ceil((bounds.width - weatherLabelSize.width) / 2)
        
        let weatherLabelOrigin = CGPoint(x: weatherLabelxPos, y: insetets)
        
        maxTemp.frame = CGRect(origin: weatherLabelOrigin, size: weatherLabelSize)
    }
    
    func setTimeLableFrame() {
        let timeLabelSize = calculateLabelSize(text: dayLabel.text ?? "", font: .systemFont(ofSize: 14))
        
        let x = ceil((bounds.width - timeLabelSize.width) / 2)
        
        let y = ceil(bounds.height - timeLabelSize.height - insetets)
        
        let origin = CGPoint(x: ceil(x), y: ceil(y))
        
        dayLabel.frame = CGRect(origin: origin, size: timeLabelSize)
    }
    
    func setImageFrame() {
        let imageSideLength: CGFloat = 100
        let imageSize = CGSize(width: imageSideLength, height: imageSideLength)
        
        let origin = CGPoint(
            x: bounds.midX - imageSideLength / 2,
            y: bounds.midY - imageSideLength / 2
        )
        
        weatherImageView.frame = CGRect(origin: origin, size: imageSize)
    }
    
    func configure(with forecast: ForecastViewModel, day: String) {
        weatherImageView.image = nil
        
        //dayLabel.text = day
        setDay(text: day)
        //maxTemp.text = forecast.temperature
        setWeather(text: forecast.temperature ?? "")
        
        condition.text = forecast.weatherCondition
        
        guard let urlString = forecast.iconUrl, let url = URL(string: urlString) else {
            return
        }
        
        weatherImageView.kf.setImage(with: url)
    }
    
    private func setWeather(text: String) {
        maxTemp.text = text
        setWeatherLabelFrame()
    }
    
    private func setDay(text: String) {
        dayLabel.text = text
        setTimeLableFrame()
    }
    
    
    
}
