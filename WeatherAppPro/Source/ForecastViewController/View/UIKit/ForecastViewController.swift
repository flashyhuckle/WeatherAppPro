import UIKit

class ForecastViewController: UIViewController {
    
    //MARK: Properties
    private let viewModel: ForecastViewModel
    
    //MARK: Views
    
    private let detailForecastView1 = DetailForecastView()
    private let detailForecastView2 = DetailForecastView()
    private let detailForecastView3 = DetailForecastView()
    private let detailForecastView4 = DetailForecastView()
    private let detailForecastView5 = DetailForecastView()
    
    private lazy var detailForecastArray = [detailForecastView1, detailForecastView2, detailForecastView3, detailForecastView4, detailForecastView5]
    
    //MARK: Initialization
    
    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        setUpConstraints()
        
        viewModel.didReceiveData = { [ weak self ] weather in
            self?.title = weather[0].locationString
            for i in 0...4 {
                self?.detailForecastArray[i].setUpData(
                    maxTemp: weather[i].maxtemperatureString,
                    minTemp: weather[i].mintemperatureString,
                    pressure: weather[i].pressureString,
                    wind: weather[i].windSpeedString,
                    date: weather[i].shortDateString,
                    icon: weather[i].systemIcon
                    
                )
            }
        }
        viewModel.viewDidLoad()
        
        setGradientBackground(viewModel.currentWeather)
    }
    
    private func setUpViews() {
        view.addSubview(detailForecastView1)
        view.addSubview(detailForecastView2)
        view.addSubview(detailForecastView3)
        view.addSubview(detailForecastView4)
        view.addSubview(detailForecastView5)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            detailForecastView1.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailForecastView1.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            detailForecastView1.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailForecastView1.heightAnchor.constraint(equalToConstant: 140),
            
            detailForecastView2.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailForecastView2.topAnchor.constraint(equalTo: detailForecastView1.bottomAnchor, constant: 5),
            detailForecastView2.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailForecastView2.heightAnchor.constraint(equalToConstant: 140),
            
            detailForecastView3.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailForecastView3.topAnchor.constraint(equalTo: detailForecastView2.bottomAnchor, constant: 5),
            detailForecastView3.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailForecastView3.heightAnchor.constraint(equalToConstant: 140),
            
            detailForecastView4.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailForecastView4.topAnchor.constraint(equalTo: detailForecastView3.bottomAnchor, constant: 5),
            detailForecastView4.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailForecastView4.heightAnchor.constraint(equalToConstant: 140),
            
            detailForecastView5.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailForecastView5.topAnchor.constraint(equalTo: detailForecastView4.bottomAnchor, constant: 5),
            detailForecastView5.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailForecastView5.heightAnchor.constraint(equalToConstant: 140),
        ])
    }
    
    private func setGradientBackground(_ weather: WeatherModel) {
        var colorTop =  UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        var colorBottom = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        switch weather.weatherType {
        case .hot:
            colorTop = UIColor(red: 121.0/255.0, green: 4.0/255.0, blue: 4.0/255.0, alpha: 1.0).cgColor
            colorBottom = UIColor(red: 255.0/255.0, green: 91.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        case .warm:
            colorTop = UIColor(red: 121.0/255.0, green: 70.0/255.0, blue: 4.0/255.0, alpha: 1.0).cgColor
            colorBottom = UIColor(red: 255.0/255.0, green: 220.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        case .mild:
            colorTop = UIColor(red: 121.0/255.0, green: 105.0/255.0, blue: 4.0/255.0, alpha: 1.0).cgColor
            colorBottom = UIColor(red: 218.0/255.0, green: 217.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        case .cold:
            colorTop = UIColor(red: 4.0/255.0, green: 121.0/255.0, blue: 11.0/255.0, alpha: 1.0).cgColor
            colorBottom = UIColor(red: 0.0/255.0, green: 247.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        case .freezing:
            colorTop = UIColor(red: 4.0/255.0, green: 33.0/255.0, blue: 121.0/255.0, alpha: 1.0).cgColor
            colorBottom = UIColor(red: 0.0/255.0, green: 179.0/255.0, blue: 255.0/255.0, alpha: 1.0).cgColor
        }
    
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
