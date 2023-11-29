import UIKit

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
