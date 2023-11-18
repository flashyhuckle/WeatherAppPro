import UIKit

class ForecastViewController: UIViewController {
    
    //MARK: Properties
    private let viewModel: ForecastViewModel
    
    //MARK: Views
    private let temperatureLabel1: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel2: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel3: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel4: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let temperatureLabel5: UILabel = {
        let label = UILabel()
        label.text = ""
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
            self?.title = weather[0].cityName
            self?.temperatureLabel1.text = weather[0].temperatureString
            self?.temperatureLabel2.text = weather[1].temperatureString
            self?.temperatureLabel3.text = weather[2].temperatureString
            self?.temperatureLabel4.text = weather[3].temperatureString
            self?.temperatureLabel5.text = weather[4].temperatureString
        }
        viewModel.viewDidLoad()
    }
    
    private func setUpViews() {
        view.backgroundColor = .white
        
        view.addSubview(temperatureLabel1)
        view.addSubview(temperatureLabel2)
        view.addSubview(temperatureLabel3)
        view.addSubview(temperatureLabel4)
        view.addSubview(temperatureLabel5)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            temperatureLabel1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            temperatureLabel1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            
            temperatureLabel2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            temperatureLabel2.topAnchor.constraint(equalTo: temperatureLabel1.bottomAnchor, constant: 10),
            
            temperatureLabel3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            temperatureLabel3.topAnchor.constraint(equalTo: temperatureLabel2.bottomAnchor, constant: 10),
            
            temperatureLabel4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            temperatureLabel4.topAnchor.constraint(equalTo: temperatureLabel3.bottomAnchor, constant: 10),
            
            temperatureLabel5.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            temperatureLabel5.topAnchor.constraint(equalTo: temperatureLabel4.bottomAnchor, constant: 10),
        ])
    }
}
