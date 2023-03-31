import UIKit
import Domain

private enum HomeCellsType: Int {
    case balanceCell
    case cardCell
    case serviceCell
    case resourcesCell
}

public final class HomeController: UITableViewController {
    public lazy var refreshControlIndicator: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    public var presenter: ViewToPresenterHomeProtocol?
    public var header: PersonHeader?
    public var balanceViewModel: BalanceViewModel?
    public var cardsViewModel: CardsViewViewModel?
    public var mainServices = [MainService]()
    public var appResources = [Resource]()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupHeader()
        tableView.addSubview(refreshControlIndicator)
        presenter?.fetchData()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControlIndicator.endRefreshing()
        }
    }
    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? PersonHeader else { return }
        header.scrollViewDidScroll(scrollView: tableView)
    }
    
//MARK: - Setup Header and TableView
    private func setupHeader() {
        header = PersonHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 100))
        header?.delegate = self
        tableView.tableHeaderView = header
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .purple
        navigationController?.navigationBar.isHidden = true
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.reuseIdentifier)
        tableView.register(BalanceCell.self, forCellReuseIdentifier: BalanceCell.reuseIdentifier)
        tableView.register(ServicesCell.self, forCellReuseIdentifier: ServicesCell.reuseIdentifier)
        tableView.register(ResourcesGridCell.self, forCellReuseIdentifier: ResourcesGridCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
    }
}

//MARK: - TableView DataSource
extension HomeController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.estimatedRowHeight
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = HomeCellsType(rawValue: indexPath.row)
        switch type {
        case .balanceCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: BalanceCell.reuseIdentifier, for: indexPath) as? BalanceCell
            cell?.setupCell(with: balanceViewModel)
            return cell ?? UITableViewCell()
        case .cardCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell
            cell?.setupCell(with: cardsViewModel)
            return cell ?? UITableViewCell()
        case .serviceCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as? ServicesCell
            cell?.setupCell(services: mainServices)
            return cell ?? UITableViewCell()
        case .resourcesCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: ResourcesGridCell.reuseIdentifier, for: indexPath) as? ResourcesGridCell
            cell?.setupCell(resources: appResources)
            return cell ?? UITableViewCell()
        default: return UITableViewCell()
        }
    }
}

//MARK: - PersonHeader Delegate
extension HomeController: PersonHeaderDelegateProtocol {
    public func profileButtonDidTapped() {
        presenter?.routeToProfile()
    }
}

//MARK: - Views
extension HomeController: ProfileView {
    public func updateProfileView(viewModel: ProfileViewModel) {
        header?.updateHeaderDisplay(viewModel: viewModel)
    }
}

extension HomeController: BalanceView {
    public func updateBalanceView(viewModel: BalanceViewModel) {
        balanceViewModel = viewModel
    }
}

extension HomeController: CardsView {
    public func updateCardsView(viewModel: CardsViewViewModel) {
        cardsViewModel = viewModel
    }
}

extension HomeController: ServicesView {
    public func updateServicesView(services: [MainService]) {
        mainServices = services
    }
}

extension HomeController: ResourcesView {
    public func updateResourcesView(resources: [Resource]) {
        appResources = resources
    }
}

extension HomeController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
