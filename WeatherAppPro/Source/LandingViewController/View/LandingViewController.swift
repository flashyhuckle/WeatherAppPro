import UIKit
import CoreLocation

class LandingViewController: UIViewController {
    
    //MARK: Properties
    private let viewModel: LandingViewModel
    private let locationManager = CLLocationManager()
    
    //MARK: Views
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchBarStyle = UISearchBar.Style.default
        searchBar.placeholder = "Search city"
        searchBar.isTranslucent = false
        searchBar.sizeToFit()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private lazy var favoritesBarButton = UIBarButtonItem(
        image: UIImage(systemName: "star"),
        style: .plain,
        target: self,
        action: #selector(favoritesPressed)
    )
    
    private lazy var locationSearchButton = UIBarButtonItem(
        image: UIImage(systemName: "location"),
        style: .plain,
        target: self,
        action: #selector(locationSearchPressed)
    )
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "CITY NAME"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.text = "25oC"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weatherImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "sun.max")
        imageView.preferredSymbolConfiguration = UIImage.SymbolConfiguration(paletteColors: [.systemTeal])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var forecastButton: UIButton = {
        let button = UIButton()
        button.setTitle("5 day forecast", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(forecastButtonPressed), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
        return button
    }()
    
    private lazy var favoritesButton: UIButton = {
        let button = UIButton()
        button.setTitle("favorite cities", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(favoritesButtonPressed), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = .init(red: 0, green: 0, blue: 0, alpha: 1)
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
            self?.locationManager.stopUpdatingLocation()
            
            self?.cityLabel.text = weather[0].cityName
            self?.temperatureLabel.text = weather[0].temperatureString
            self?.weatherImageView.image = UIImage(systemName: "\(weather[0].systemIcon)")
        }
        
        viewModel.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
        favoriteButtonSetup()
    }
    
    private func setUpViews() {
        view.backgroundColor = .lightGray

        navigationItem.rightBarButtonItem = favoritesBarButton
        navigationItem.leftBarButtonItem = locationSearchButton
        
        favoriteButtonSetup()
        
        view.addSubview(searchBar)
        view.addSubview(cityLabel)
        view.addSubview(temperatureLabel)
        view.addSubview(weatherImageView)
        view.addSubview(forecastButton)
        view.addSubview(favoritesButton)
    }
    
    private func favoriteButtonSetup() {
        if viewModel.checkIfFavorite() {
            favoritesBarButton.image = UIImage(systemName: "star.fill")
        } else {
            favoritesBarButton.image = UIImage(systemName: "star")
        }
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 50),
            searchBar.widthAnchor.constraint(equalToConstant: 200),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            
            cityLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150),
            cityLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 150),
            cityLabel.heightAnchor.constraint(equalToConstant: 50),
            cityLabel.widthAnchor.constraint(equalToConstant: 150),
            
            temperatureLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            temperatureLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            temperatureLabel.heightAnchor.constraint(equalToConstant: 100),
            temperatureLabel.widthAnchor.constraint(equalToConstant: 100),
            
            weatherImageView.topAnchor.constraint(equalTo: cityLabel.bottomAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            weatherImageView.heightAnchor.constraint(equalToConstant: 150),
            weatherImageView.widthAnchor.constraint(equalToConstant: 150),
            
            forecastButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 150),
            forecastButton.heightAnchor.constraint(equalToConstant: 50),
            forecastButton.widthAnchor.constraint(equalToConstant: 150),
            forecastButton.bottomAnchor.constraint(equalTo: favoritesButton.topAnchor, constant: -50),
            
            favoritesButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 150),
            favoritesButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -150),
            favoritesButton.heightAnchor.constraint(equalToConstant: 50),
            favoritesButton.widthAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    private func searchByCity(city: String) {
        viewModel.searchByCity(city: city)
        favoriteButtonSetup()
    }
    
    @objc private func favoritesPressed() {
        viewModel.onTapFavoriteBarButton()
        favoriteButtonSetup()
    }
    
    @objc private func locationSearchPressed() {
        locationManager.requestLocation()
        favoriteButtonSetup()
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
