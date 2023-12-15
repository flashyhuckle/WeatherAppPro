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
        
        setGradientBackground(for: viewModel.currentWeather.weatherType)
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
    
    private func setGradientBackground(for weatherType: WeatherType) {
        let gradientLayer = WeatherGradientMaker().createGradient(for: weatherType)
        gradientLayer.frame = view.bounds
        
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
