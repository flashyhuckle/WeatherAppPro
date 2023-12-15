import UIKit
import SwiftUI


class LandingViewController: UIViewController {
    
    //MARK: Properties
    private let viewModel: LandingViewModel
    
    //MARK: Views
    private let dateAndLocationView = DateAndLocationView()
    private let mainWeatherView = MainWeatherView()
    private let detailWeatherView = DetailWeatherView()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.minimal
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.tintColor = Constants.fontColor
        searchBar.searchTextField.textColor = Constants.fontColor
        searchBar.searchTextField.leftView?.tintColor = Constants.fontColor
        
        let textField = searchBar.value(forKey: "searchField") as? UITextField
        textField?.attributedPlaceholder = NSAttributedString(string: "Search city", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white.withAlphaComponent(0.7)])
        return searchBar
    }()
    
    private lazy var favoritesBarButton = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(favoritesPressed)
        )
        button.tintColor = Constants.fontColor
        return button
    }()
    
    private lazy var locationSearchButton = {
        let button = UIBarButtonItem(
            image: UIImage(systemName: "location"),
            style: .plain,
            target: self,
            action: #selector(locationSearchPressed)
        )
        button.tintColor = Constants.fontColor
        return button
    }()
    
    private lazy var forecastButton: UIButton = {
        let button = LandingViewButton()
        button.title = "5 day forecast"
        button.addTarget(self, action: #selector(forecastButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var favoritesButton: UIButton = {
        let button = LandingViewButton()
        button.title = "favorite cities"
        button.addTarget(self, action: #selector(favoritesButtonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    //MARK: Initialization
    
    init(viewModel: LandingViewModel) {
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
        
        searchBar.delegate = self
        
        viewModel.didReceiveData = { [ weak self ] weather in
            self?.setGradientBackground(weather.weatherType)
            self?.dateAndLocationView.setDateAndLocation(
                date: weather.dateString,
                location: weather.locationString
            )
            
            self?.mainWeatherView.setMainWeatherView(
                icon: weather.systemIcon,
                temperature: weather.temperatureString,
                description: weather.descriptionString
            )
            
            self?.detailWeatherView.setData(
                maxTemp: weather.maxtemperatureString,
                minTemp: weather.mintemperatureString,
                windSpeed: weather.windSpeedString,
                pressure: weather.pressureString,
                sunrise: weather.sunriseString,
                sunset: weather.sunsetString
            )
        }
        
        viewModel.didChangeCity = { [ weak self ] newCityIsFavorite in
            self?.favoritesBarButton.image = UIImage(systemName: newCityIsFavorite ? "star.fill" : "star")
        }
        
        viewModel.viewDidLoad()
    }
    
    private func setUpViews() {
        setGradientBackground()

        navigationItem.rightBarButtonItem = favoritesBarButton
        navigationItem.leftBarButtonItem = locationSearchButton
        
        view.addSubview(searchBar)
        
        view.addSubview(dateAndLocationView)
        view.addSubview(mainWeatherView)
        view.addSubview(detailWeatherView)

        view.addSubview(forecastButton)
        view.addSubview(favoritesButton)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            dateAndLocationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dateAndLocationView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            dateAndLocationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            dateAndLocationView.heightAnchor.constraint(equalToConstant: 115),
            
            mainWeatherView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainWeatherView.topAnchor.constraint(equalTo: dateAndLocationView.bottomAnchor, constant: 10),
            mainWeatherView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainWeatherView.heightAnchor.constraint(equalToConstant: 160),

//            detailWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailWeatherView.topAnchor.constraint(equalTo: mainWeatherView.bottomAnchor, constant: 10),
//            detailWeatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailWeatherView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            detailWeatherView.heightAnchor.constraint(equalToConstant: 170),
            detailWeatherView.widthAnchor.constraint(equalToConstant: 395),
            
            forecastButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            forecastButton.topAnchor.constraint(equalTo: detailWeatherView.bottomAnchor, constant: 10),
            forecastButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            favoritesButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            favoritesButton.topAnchor.constraint(equalTo: forecastButton.bottomAnchor, constant: 10),
            favoritesButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
        ])
    }
    
    private func setGradientBackground(_ weatherType: WeatherType = .mild) {
        let gradientLayer = WeatherGradientMaker().createGradient(for: weatherType)
        gradientLayer.frame = view.bounds
        
        view.layer.sublayers?[0].removeFromSuperlayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func searchBarPressed(city: String) {
        viewModel.searchBy(cityName: city)
    }
    
    @objc private func favoritesPressed() {
        viewModel.onTapFavoriteBarButton()
    }
    
    @objc private func locationSearchPressed() {
        viewModel.onTapLocationButton()
    }
    
    @objc private func forecastButtonPressed() {
        viewModel.onTapForecastButton()
    }
    
    @objc private func favoritesButtonPressed() {
        viewModel.onTapFavoritesButton()
    }
}

//MARK: SearchBar delegate

extension LandingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarPressed(city: searchBar.text!)
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
