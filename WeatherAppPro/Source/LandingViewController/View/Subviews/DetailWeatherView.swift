//
//  DetailWeatherView.swift
//  WeatherAppPro
//
//  Created by Marcin Głodzik on 21/11/2023.
//

import UIKit

class DetailWeatherView: UIView {
    
    private let maxTemperatureView = DetailWeatherSubview()
    private let minTemperatureView = DetailWeatherSubview()
    private let windSpeedView = DetailWeatherSubview()
    private let pressureView = DetailWeatherSubview()
    private let sunriseView = DetailWeatherSubview()
    private let sunsetView = DetailWeatherSubview()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        if Constants.showingViewBorders {
            layer.borderWidth = 1
            layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(maxTemperatureView)
        addSubview(minTemperatureView)
        addSubview(windSpeedView)
        addSubview(pressureView)
        addSubview(sunriseView)
        addSubview(sunsetView)
        
        NSLayoutConstraint.activate([
            maxTemperatureView.leadingAnchor.constraint(equalTo: leadingAnchor),
            maxTemperatureView.topAnchor.constraint(equalTo: topAnchor),
            maxTemperatureView.heightAnchor.constraint(equalToConstant: 85),
            maxTemperatureView.widthAnchor.constraint(equalToConstant: 125),
            
            minTemperatureView.leadingAnchor.constraint(equalTo: leadingAnchor),
            minTemperatureView.topAnchor.constraint(equalTo: maxTemperatureView.bottomAnchor),
            minTemperatureView.heightAnchor.constraint(equalToConstant: 85),
            minTemperatureView.widthAnchor.constraint(equalToConstant: 125),
            
            windSpeedView.leadingAnchor.constraint(equalTo: maxTemperatureView.trailingAnchor),
            windSpeedView.topAnchor.constraint(equalTo: topAnchor),
            windSpeedView.heightAnchor.constraint(equalToConstant: 85),
            windSpeedView.widthAnchor.constraint(equalToConstant: 125),
            
            pressureView.leadingAnchor.constraint(equalTo: maxTemperatureView.trailingAnchor),
            pressureView.topAnchor.constraint(equalTo: windSpeedView.bottomAnchor),
            pressureView.heightAnchor.constraint(equalToConstant: 85),
            pressureView.widthAnchor.constraint(equalToConstant: 125),
            
            sunriseView.leadingAnchor.constraint(equalTo: windSpeedView.trailingAnchor),
            sunriseView.topAnchor.constraint(equalTo: topAnchor),
            sunriseView.heightAnchor.constraint(equalToConstant: 85),
            sunriseView.widthAnchor.constraint(equalToConstant: 125),
            
            sunsetView.leadingAnchor.constraint(equalTo: windSpeedView.trailingAnchor),
            sunsetView.topAnchor.constraint(equalTo: maxTemperatureView.bottomAnchor),
            sunsetView.heightAnchor.constraint(equalToConstant: 85),
            sunsetView.widthAnchor.constraint(equalToConstant: 125)
            
        ])
    }
    
    func setData(maxTemp: String, minTemp: String, windSpeed: String, pressure: String, sunrise: String, sunset: String) {
        maxTemperatureView.setUpData(title: "Max", data: maxTemp)
        minTemperatureView.setUpData(title: "Min", data: minTemp)
        windSpeedView.setUpData(title: "Wind", data: windSpeed)
        pressureView.setUpData(title: "Pressure", data: pressure)
        sunriseView.setUpData(title: "Sunrise", data: sunrise)
        sunsetView.setUpData(title: "Sunset", data: sunset)
    }
}

class DetailWeatherSubview: UIView {
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "25°C"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Light", size: 30.0)
        label.textColor = Constants.fontColor
        if Constants.showingViewBorders {
            label.layer.borderWidth = 1
            label.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Max"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Light", size: 20.0)
        label.textColor = Constants.fontColor
        if Constants.showingViewBorders {
            label.layer.borderWidth = 1
            label.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViews() {
        if Constants.showingViewBorders {
            layer.borderWidth = 1
            layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mainLabel)
        addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            mainLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            mainLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            mainLabel.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setUpData(title: String, data: String) {
        titleLabel.text = title
        mainLabel.text = data
    }
}
