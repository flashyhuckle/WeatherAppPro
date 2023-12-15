import UIKit

class DetailWeatherView: UIView {
    
    private let maxTemperatureView = DetailWeatherSubview(label: "Max", data: "25°")
    private let minTemperatureView = DetailWeatherSubview(label: "Min", data: "0°")
    private let windSpeedView = DetailWeatherSubview(label: "Wind", data: "5km/h")
    private let pressureView = DetailWeatherSubview(label: "Pressure", data: "1000hPa")
    private let sunriseView = DetailWeatherSubview(label: "Sunrise", data: "6:00")
    private let sunsetView = DetailWeatherSubview(label: "Sunset", data: "20:00")
    
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
            maxTemperatureView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            maxTemperatureView.topAnchor.constraint(equalTo: topAnchor),
            maxTemperatureView.heightAnchor.constraint(equalToConstant: 85),
            maxTemperatureView.widthAnchor.constraint(equalToConstant: 125),
            
            minTemperatureView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            minTemperatureView.topAnchor.constraint(equalTo: maxTemperatureView.bottomAnchor),
            minTemperatureView.heightAnchor.constraint(equalToConstant: 85),
            minTemperatureView.widthAnchor.constraint(equalToConstant: 125),
            
            windSpeedView.leadingAnchor.constraint(equalTo: maxTemperatureView.trailingAnchor, constant: 5),
            windSpeedView.topAnchor.constraint(equalTo: topAnchor),
            windSpeedView.heightAnchor.constraint(equalToConstant: 85),
            windSpeedView.widthAnchor.constraint(equalToConstant: 125),
            
            pressureView.leadingAnchor.constraint(equalTo: maxTemperatureView.trailingAnchor, constant: 5),
            pressureView.topAnchor.constraint(equalTo: windSpeedView.bottomAnchor),
            pressureView.heightAnchor.constraint(equalToConstant: 85),
            pressureView.widthAnchor.constraint(equalToConstant: 125),
            
            sunriseView.leadingAnchor.constraint(equalTo: windSpeedView.trailingAnchor, constant: 5),
            sunriseView.topAnchor.constraint(equalTo: topAnchor),
            sunriseView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            sunriseView.heightAnchor.constraint(equalToConstant: 85),
            sunriseView.widthAnchor.constraint(equalToConstant: 125),
            
            sunsetView.leadingAnchor.constraint(equalTo: windSpeedView.trailingAnchor, constant: 5),
            sunsetView.topAnchor.constraint(equalTo: maxTemperatureView.bottomAnchor),
            sunsetView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
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
        label.text = "25°"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Light", size: 30.0)
        label.textColor = Constants.fontColor
        label.textAlignment = .center
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
        label.textAlignment = .center
        if Constants.showingViewBorders {
            label.layer.borderWidth = 1
            label.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return label
    }()
    
    init(
        label: String,
        data: String
    ) {
        super.init(frame: .zero)
        setUpViews()
        setUpData(title: label, data: data)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    
    func setUpData(
        title: String,
        data: String
    ) {
        titleLabel.text = title
        mainLabel.text = data
    }
}
