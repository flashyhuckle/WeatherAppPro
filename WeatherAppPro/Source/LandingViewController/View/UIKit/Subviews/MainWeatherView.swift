//
//  MainWeatherView.swift
//  WeatherAppPro
//
//  Created by Marcin Głodzik on 21/11/2023.
//

import UIKit

class MainWeatherView: UIView {
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "25°C"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Light", size: 100.0)
        label.textColor = .white
        label.textAlignment = .center
        if Constants.showingViewBorders {
            label.layer.borderWidth = 1
            label.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(paletteColors: [.white])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        if Constants.showingViewBorders {
            imageView.layer.borderWidth = 1
            imageView.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Mild rain"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Light", size: 30.0)
        label.textColor = .white
        label.textAlignment = .center
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
        
        addSubview(temperatureLabel)
        addSubview(weatherImageView)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            weatherImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            weatherImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            weatherImageView.heightAnchor.constraint(equalToConstant: 150),
            weatherImageView.widthAnchor.constraint(equalToConstant: 150),
            
            temperatureLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 5),
            temperatureLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            temperatureLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 115),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 5),
            descriptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setMainWeatherView(icon: String, temperature: String, description: String) {
        temperatureLabel.text = temperature
        weatherImageView.image = UIImage(systemName: icon)
        descriptionLabel.text = description
    }
}
