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

    private lazy var swiftUIButton: UIButton = {
        let button = LandingViewButton()
        button.title = "swiftUI"
        button.addTarget(self, action: #selector(swiftUIButtonPressed), for: .touchUpInside)
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
            self?.setGradientBackground(weather[0].weatherType)
            self?.dateAndLocationView.setDateAndLocation(
                date: weather[0].dateString,
                location: weather[0].locationString
            )
            
            self?.mainWeatherView.setMainWeatherView(
                icon: weather[0].systemIcon,
                temperature: weather[0].temperatureString,
                description: weather[0].description
            )
            
            self?.detailWeatherView.setData(
                maxTemp: weather[0].maxtemperatureString,
                minTemp: weather[0].mintemperatureString,
                windSpeed: weather[0].windSpeedString,
                pressure: weather[0].pressureString,
                sunrise: weather[0].sunriseString,
                sunset: weather[0].sunsetString
            )
        }
        
        viewModel.didChangeCity = { newCityIsFavorite in
            if newCityIsFavorite {
                self.favoritesBarButton.image = UIImage(systemName: "star.fill")
            } else {
                self.favoritesBarButton.image = UIImage(systemName: "star")
            }
        }
        
        viewModel.viewDidLoad()
    }
    
    private func setUpViews() {
        setGradientBackground()

        navigationItem.rightBarButtonItem = favoritesBarButton
        navigationItem.leftBarButtonItem = locationSearchButton
        
        view.addSubview(searchBar)
        view.addSubview(forecastButton)
        view.addSubview(favoritesButton)
        view.addSubview(swiftUIButton)
        
        view.addSubview(dateAndLocationView)
        view.addSubview(mainWeatherView)
        view.addSubview(detailWeatherView)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            searchBar.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
            forecastButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            forecastButton.topAnchor.constraint(equalTo: detailWeatherView.bottomAnchor, constant: 20),
            forecastButton.heightAnchor.constraint(equalToConstant: 50),
            forecastButton.widthAnchor.constraint(equalToConstant: 150),
            
            favoritesButton.leadingAnchor.constraint(equalTo: forecastButton.trailingAnchor, constant: 50),
            favoritesButton.topAnchor.constraint(equalTo: detailWeatherView.bottomAnchor, constant: 20),
            favoritesButton.heightAnchor.constraint(equalToConstant: 50),
            favoritesButton.widthAnchor.constraint(equalToConstant: 150),
            
            dateAndLocationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dateAndLocationView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
            dateAndLocationView.heightAnchor.constraint(equalToConstant: 115),
            dateAndLocationView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
            mainWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainWeatherView.topAnchor.constraint(equalTo: dateAndLocationView.bottomAnchor, constant: 10),
            mainWeatherView.heightAnchor.constraint(equalToConstant: 160),
            mainWeatherView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
            detailWeatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailWeatherView.topAnchor.constraint(equalTo: mainWeatherView.bottomAnchor, constant: 10),
            detailWeatherView.heightAnchor.constraint(equalToConstant: 170),
            detailWeatherView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            
            swiftUIButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            swiftUIButton.topAnchor.constraint(equalTo: forecastButton.bottomAnchor, constant: 10),
            swiftUIButton.heightAnchor.constraint(equalToConstant: 50),
            swiftUIButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func setGradientBackground(_ weatherType: WeatherType = .mild) {
        var colorTop =  UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        var colorBottom = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        
        switch weatherType {
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
        
        view.layer.sublayers?[0].removeFromSuperlayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    private func searchByCity(city: String) {
        viewModel.searchByCity(city: city)
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
    
    @objc private func swiftUIButtonPressed() {
        viewModel.swiftUIButtonPressed()
    }
}

//MARK: SearchBar delegate

extension LandingViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchByCity(city: searchBar.text!)
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}



