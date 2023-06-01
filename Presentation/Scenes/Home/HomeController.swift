import UIKit
import Domain

private enum HomeCellsType: Int {
    case balanceCell
    case cardCell
    case serviceCell
    case resourcesCell
}

protocol HomeControllerProtocol where Self: UIViewController {
    var isNeedUpdateCard: Bool { get set }
    var isNeedUpdateProfile: Bool { get set }
    var isNeedUpdateWithoutAnimation: Bool { get set }
}

public final class HomeController: UITableViewController, HomeControllerProtocol {
    var isNeedUpdateCard: Bool = false
    var isNeedUpdateProfile: Bool = false
    var isNeedUpdateWithoutAnimation: Bool = false
    
    public lazy var refreshControlIndicator: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    public var presenter: ViewToPresenterHomeProtocol?
    public var header: PersonHeader?
    public var balanceViewModel: BalanceViewModel?
    public var cards: [CardModel]?
    public var mainServices = [Service]()
    public var appResources = [Resource]()

    private var goToLastItem: (() -> (Void))?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupTableviewProperties()
        setupHeader()
        tableView.addSubview(refreshControlIndicator)
        navigationItem.backButtonTitle = ""
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        presenter?.fetchData()
        presenter?.fechCards()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        updateIfNeeded()
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshControlIndicator.endRefreshing()
        }
    }

    private func scrollToLastItem() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) { [weak self] in
            self?.goToLastItem?()
        }
    }
    
    private func updateIfNeeded() {
        switch true {
            case isNeedUpdateCard:
                presenter?.fechCards()
                self.scrollToLastItem()
                self.isNeedUpdateCard = false
            case isNeedUpdateWithoutAnimation:
                presenter?.fechCards()
                isNeedUpdateWithoutAnimation = false
            case isNeedUpdateProfile:
                header?.profileImageView.loadImageWith(path: makeUserImagePath())
                self.isNeedUpdateProfile = false
        default: return
        }
    }
    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? PersonHeader else { return }
        header.scrollViewDidScroll(scrollView: tableView)
    }
    
    private func makeUserImagePath() -> String {
        let path = getDocumentsDirectory().appendingPathComponent(FileManagerPaths.userImage).path
        return path
    }
    
    //MARK: - Setup Header and TableView
    private func setupHeader() {
        header = PersonHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: HeaderHeights.small))
        let path = makeUserImagePath()
        header?.profileImageView.loadImageWith(path: path)
        header?.delegate = self
        tableView.tableHeaderView = header
    }
    
    private func registerCells() {
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.reuseIdentifier)
        tableView.register(BalanceCell.self, forCellReuseIdentifier: BalanceCell.reuseIdentifier)
        tableView.register(ServicesCell.self, forCellReuseIdentifier: ServicesCell.reuseIdentifier)
        tableView.register(ResourcesGridCell.self, forCellReuseIdentifier: ResourcesGridCell.reuseIdentifier)
    }
    
    private func setupTableviewProperties() {
        view.backgroundColor = Colors.primaryColor
        tableView.backgroundColor = Colors.primaryColor
        tableView.separatorStyle = .none
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
            cell?.setupCell(with: cards)
            goToLastItem = cell?.goToLastItem
            cell?.delegate = self
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

//MARK: - Delegate actions
extension HomeController: PersonHeaderDelegateProtocol {
    public func profileButtonDidTapped() {
        presenter?.routeToProfile()
    }
}

extension HomeController: AddCardButtonDelegateProtocol {
    func addCardButtonDidTapped() {
        presenter?.routeToCards()
    }
}

//MARK: - Views
extension HomeController: ProfileView {
    public func updateProfileView(viewModel: ProfileViewModel) {
        self.header?.updateHeaderDisplay(viewModel: viewModel)
        tableView.reloadData()
    }
}

extension HomeController: BalanceView {
    public func updateBalanceView(viewModel: BalanceViewModel) {
        self.balanceViewModel = viewModel
        tableView.reloadData()
    }
}

extension HomeController: CardsView {
    public func updateCardsView(viewModel: CardsViewViewModel) {
        self.cards = viewModel.cards
        tableView.reloadData()
    }
}

extension HomeController: ServicesView {
    public func updateServicesView(services: [Service]) {
        self.mainServices = services
        tableView.reloadData()
    }
}

extension HomeController: ResourcesView {
    public func updateResourcesView(resources: [Resource]) {
        appResources = resources
        tableView.reloadData()
    }
}

extension HomeController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
