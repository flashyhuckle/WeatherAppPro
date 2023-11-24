import UIKit
import CoreLocation


class LandingViewController: UIViewController {
    
    //MARK: Properties
    private let viewModel: LandingViewModel
    private let locationManager = CLLocationManager()
    
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
    
//    private let cityLabel: UILabel = {
//        let label = UILabel()
//        label.text = "CITY NAME"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Avenir-Light", size: 50.0)
//        label.textColor = .white
//        label.textAlignment = .right
//        label.layer.borderWidth = 1
//        label.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
//        return label
//    }()
    
//    private let dateLabel: UILabel = {
//        let label = UILabel()
//        label.text = "DATE"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Avenir-Light", size: 15.0)
//        label.textColor = .white
//        label.textAlignment = .right
//        label.layer.borderWidth = 1
//        label.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
//        return label
//    }()
    
//    private let temperatureLabel: UILabel = {
//        let label = UILabel()
//        label.text = "25oC"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = UIFont(name: "Avenir-Light", size: 100.0)
//        label.textColor = .white
//        label.textAlignment = .right
//        label.layer.borderWidth = 1
//        label.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
//        return label
//    }()
    
//    private let weatherImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "sun.max")
//        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(paletteColors: [.white])
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.contentMode = .scaleAspectFit
//        
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = .init(red: 1, green: 1, blue: 1, alpha: 1)
//        return imageView
//    }()
    
    private lazy var forecastButton: UIButton = {
        let button = UIButton()
        button.setTitle("5 day forecast", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(forecastButtonPressed), for: .touchUpInside)
        button.setTitleColor(Constants.fontColor, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
        return button
    }()
    
    private lazy var favoritesButton: UIButton = {
        let button = UIButton()
        button.setTitle("favorite cities", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoritesButtonPressed), for: .touchUpInside)
        button.setTitleColor(Constants.fontColor, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(red: 1, green: 1, blue: 1, alpha: 1)
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
        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        viewModel.didReceiveData = { [ weak self ] weather in
            self?.setGradientBackground(weather[0].weatherType)
            self?.locationManager.stopUpdatingLocation()
            
//            self?.cityLabel.text = weather[0].cityName + ", " + weather[0].country
//            self?.temperatureLabel.text = weather[0].temperatureString
//            self?.dateLabel.text = "\(weather[0].date.formatted(Date.FormatStyle().weekday(.wide).month(.wide).day(.twoDigits)))"
//            self?.weatherImageView.image = UIImage(systemName: "\(weather[0].systemIcon)")
            
            self?.dateAndLocationView.setDateAndLocation(
                date: "\(weather[0].date.formatted(Date.FormatStyle().weekday(.wide).month(.wide).day(.twoDigits)))",
                location: weather[0].cityName + ", " + weather[0].country
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
//        view.addSubview(cityLabel)
//        view.addSubview(dateLabel)
//        view.addSubview(temperatureLabel)
//        view.addSubview(weatherImageView)
        
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
            
//            temperatureLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            temperatureLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
//            temperatureLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 10),
//            temperatureLabel.heightAnchor.constraint(equalToConstant: 100),
            
//            cityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            cityLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
//            cityLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: 10),
//            cityLabel.heightAnchor.constraint(equalToConstant: 50),
//            
//            dateLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
//            dateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 10),
//            dateLabel.heightAnchor.constraint(equalToConstant: 50),
//            dateLabel.widthAnchor.constraint(equalToConstant: 200),
            
//            weatherImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            weatherImageView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 150),
//            weatherImageView.heightAnchor.constraint(equalToConstant: 150),
//            weatherImageView.widthAnchor.constraint(equalToConstant: 150),
            
            forecastButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            forecastButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 600),
            forecastButton.heightAnchor.constraint(equalToConstant: 50),
            forecastButton.widthAnchor.constraint(equalToConstant: 150),
            
            favoritesButton.leadingAnchor.constraint(equalTo: forecastButton.trailingAnchor, constant: 50),
            favoritesButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 600),
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
        locationManager.requestLocation()
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
        searchByCity(city: searchBar.text!)
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

//MARK: LocationManager delegate

extension LandingViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = Double(location.coordinate.latitude)
            let lon = Double(location.coordinate.longitude)
            viewModel.onTapLocationSearchButton(lat: lat, lon: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
