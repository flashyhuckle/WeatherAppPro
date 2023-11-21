//
//  DateAndLocationView.swift
//  WeatherAppPro
//
//  Created by Marcin Głodzik on 21/11/2023.
//

import UIKit

class DateAndLocationView: UIView {
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "CITY NAME"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Light", size: 50.0)
        label.textColor = .white
        if Constants.showingViewBorders {
            label.layer.borderWidth = 1
            label.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "DATE"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Light", size: 20.0)
        label.textColor = .white
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
        
        addSubview(cityLabel)
        addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            cityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            cityLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            cityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            cityLabel.heightAnchor.constraint(equalToConstant: 50),
            
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            dateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5),
            dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setDateAndLocation(date: String, location: String) {
        dateLabel.text = date
        cityLabel.text = location
    }
}
