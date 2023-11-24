import UIKit

class DetailForecastView: UIView {
    
    let iconAndDateView = DetailForecastIconAndDateSubview()
    let detailView1 = DetailForecastSubview()
    let detailView2 = DetailForecastSubview()
    let detailView3 = DetailForecastSubview()
    let detailView4 = DetailForecastSubview()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        if Constants.showingViewBorders {
            layer.borderWidth = 1
            layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        }
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(iconAndDateView)
        addSubview(detailView1)
        addSubview(detailView2)
        addSubview(detailView3)
        addSubview(detailView4)
        
        backgroundColor = UIColor.black.withAlphaComponent(0.17)
        
        NSLayoutConstraint.activate([
            iconAndDateView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconAndDateView.topAnchor.constraint(equalTo: topAnchor),
            iconAndDateView.widthAnchor.constraint(equalToConstant: 200),
            iconAndDateView.heightAnchor.constraint(equalToConstant: 140),
            
            detailView1.leadingAnchor.constraint(equalTo: iconAndDateView.trailingAnchor),
            detailView1.topAnchor.constraint(equalTo: topAnchor),
            detailView1.heightAnchor.constraint(equalToConstant: 65),
            detailView1.widthAnchor.constraint(equalToConstant: 90),
            
            detailView2.leadingAnchor.constraint(equalTo: iconAndDateView.trailingAnchor),
            detailView2.topAnchor.constraint(equalTo: detailView1.bottomAnchor),
            detailView2.heightAnchor.constraint(equalToConstant: 65),
            detailView2.widthAnchor.constraint(equalToConstant: 90),
            
            detailView3.leadingAnchor.constraint(equalTo: detailView1.trailingAnchor),
            detailView3.topAnchor.constraint(equalTo: topAnchor),
            detailView3.heightAnchor.constraint(equalToConstant: 65),
            detailView3.widthAnchor.constraint(equalToConstant: 90),
            
            detailView4.leadingAnchor.constraint(equalTo: detailView1.trailingAnchor),
            detailView4.topAnchor.constraint(equalTo: detailView3.bottomAnchor),
            detailView4.heightAnchor.constraint(equalToConstant: 65),
            detailView4.widthAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    func setUpData(maxTemp: String, minTemp: String, pressure: String, wind: String, date: String, icon: String) {
        iconAndDateView.setUpData(icon: icon, date: date)
        detailView1.setUpData(title: "Max", data: maxTemp)
        detailView2.setUpData(title: "Min", data: minTemp)
        detailView3.setUpData(title: "Pressure", data: pressure)
        detailView4.setUpData(title: "Wind", data: wind)
    }
}

class DetailForecastSubview: UIView {
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "25°C"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Light", size: 20.0)
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
        label.font = UIFont(name: "Avenir-Light", size: 15.0)
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
            mainLabel.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            titleLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            titleLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setUpData(title: String, data: String) {
        titleLabel.text = title
        mainLabel.text = data
    }
}

class DetailForecastIconAndDateSubview: UIView {
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "24/11"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Light", size: 30.0)
        label.textColor = Constants.fontColor
        if Constants.showingViewBorders {
            label.layer.borderWidth = 1
            label.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
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
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(dateLabel)
        addSubview(weatherImageView)
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: topAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 30),
            
            weatherImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            weatherImageView.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
            weatherImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    func setUpData(icon: String, date: String) {
        dateLabel.text = date
        weatherImageView.image = UIImage(systemName: icon)
    }
}
