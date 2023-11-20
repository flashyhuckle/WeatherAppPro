import UIKit

class FavoritesViewController: UIViewController {
    
    //MARK: Properties
    let viewModel: FavoritesViewModel
    private let userDefaults: UserDefaults = .standard
    var favorites = [String]()
    let didTapCell: ((String) -> Void)?
    
    //MARK: Views
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.translatesAutoresizingMaskIntoConstraints = false
        table.keyboardDismissMode = .onDrag
        return table
    }()
    
    //MARK: Init
    init(viewModel: FavoritesViewModel,
         didTapCell: ((String) -> Void)?
    ) {
        self.viewModel = viewModel
        self.didTapCell = didTapCell
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
        
        getFavorites()
        
    }
    
    func setUpViews() {
        view.backgroundColor = .blue
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
    
    func getFavorites() {
        guard let favorite = userDefaults.array(forKey: "favorites") as? [String] else { return }
        favorites = favorite
        tableView.reloadData()
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") {
            cell.textLabel?.text = favorites[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
}

extension FavoritesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.popViewController(animated: true)
        didTapCell?(favorites[indexPath.row])
    }
}
