import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: Properties
    let viewModel: FavoritesViewModel
    let didTapCell: ((String) -> Void)?
//    var weatherType: WeatherType?
    let currentWeather: WeatherModel
    
    //MARK: Views
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.keyboardDismissMode = .onDrag
        table.backgroundColor = .clear
        return table
    }()
    
    //MARK: Init
    init(viewModel: FavoritesViewModel,
         didTapCell: ((String) -> Void)?,
//         weatherType: WeatherType?,
         currentWeather: WeatherModel
    ) {
        self.viewModel = viewModel
        self.didTapCell = didTapCell
//        self.weatherType = weatherType
        self.currentWeather = currentWeather
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViews()
        setUpConstraints()
        setGradientBackground(currentWeather)
    }
    
    func setUpViews() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setUpConstraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
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

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favorites.count()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = viewModel.favorites.favoriteCity(indexPath.row)
            cell.textLabel?.textColor = .white
            cell.backgroundColor = .clear
            
            return cell
        }
        return UITableViewCell()
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
        didTapCell?(viewModel.favorites.favoriteCity(indexPath.row))
    }
}
