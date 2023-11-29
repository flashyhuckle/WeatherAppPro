import UIKit

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

