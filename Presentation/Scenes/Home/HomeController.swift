import UIKit
import Domain

protocol HomeControllerProtocol where Self: UIViewController {
    var isNeedUpdateCard: Bool { get set }
    var isNeedUpdateProfile: Bool { get set }
    var isNeedUpdateWithoutAnimation: Bool { get set }
    var isOpenFromHome: Bool { get set }
}

public final class HomeController: UITableViewController, HomeControllerProtocol {
    public lazy var refreshControlIndicator: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    var isNeedUpdateCard: Bool = false
    var isNeedUpdateProfile: Bool = false
    var isNeedUpdateWithoutAnimation: Bool = false
    var isOpenFromHome: Bool = false
    
    private var goToLastItem: (() -> (Void))?
    public var presenter: ViewToPresenterHomeProtocol?
    private var homeListDataSource: [HomeListCellType] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        removeBackButtonTitle()
        registerTableViewCells()
        setupTableviewProperties()
        disableInteractivePopGesture()
        presenter?.fetchUserData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        updateViewIfNeeded()
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
    
    private func updateViewIfNeeded() {
        switch true {
        case isNeedUpdateCard:
            presenter?.fetchUserData()
            scrollToLastItem()
            isNeedUpdateCard = false
        case isNeedUpdateWithoutAnimation:
            presenter?.fetchUserData()
            isNeedUpdateWithoutAnimation = false
        case isNeedUpdateProfile:
            reloadHeaderCell()
            isNeedUpdateProfile = false
        default: return
        }
    }
        
    private func registerTableViewCells() {
        tableView.register(PersonHeaderCell.self, forCellReuseIdentifier: PersonHeaderCell.reuseIdentifier)
        tableView.register(CardCell.self, forCellReuseIdentifier: CardCell.reuseIdentifier)
        tableView.register(BalanceCell.self, forCellReuseIdentifier: BalanceCell.reuseIdentifier)
        tableView.register(ServicesCell.self, forCellReuseIdentifier: ServicesCell.reuseIdentifier)
        tableView.register(ResourcesGridCell.self, forCellReuseIdentifier: ResourcesGridCell.reuseIdentifier)
    }
    
    private func setupTableviewProperties() {
        view.backgroundColor = Colors.primaryColor
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.addSubview(refreshControlIndicator)
    }
    
    private func reloadHeaderCell() {
        tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
    }
}

//MARK: - TableView DataSource
extension HomeController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeListDataSource.count
    }
        
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let cellType = homeListDataSource[indexPath.row]
            
        switch cellType {
            case .userHeaderCell(let personViewModel):
                cell = getPersonHeaderCell(with: personViewModel, indexPath: indexPath)
            case .balanceCell(let balanceViewModel):
                cell = getBalanceCell(with: balanceViewModel, indexPath: indexPath)
            case .cardsCell(let cardsModel):
                cell = getCardCell(with: cardsModel, indexPath: indexPath)
            case .servicesCell(let serviceViewModels):
                cell = getServicesCell(with: serviceViewModels, indexPath: indexPath)
            case .resourcesCell(let resourceViewModels):
                cell = getResourcesCell(with: resourceViewModels, indexPath: indexPath)
        }
        return cell
    }
}


//MARK: - Cells Creation
extension HomeController {
    func getPersonHeaderCell(with viewModel: PersonHeaderViewModel, indexPath: IndexPath) -> UITableViewCell {
        let personCell = tableView.dequeueReusableCell(withIdentifier: PersonHeaderCell.reuseIdentifier, for: indexPath) as? PersonHeaderCell
        personCell?.profileImageView.loadImageWith(path: FileManagerPaths.getPathFor(pathType: .userImage))
        personCell?.configureCell(with: viewModel)
        personCell?.delegate = self
        return personCell ?? UITableViewCell()
    }
    
    func getBalanceCell(with viewModel: BalanceViewModel, indexPath: IndexPath) -> UITableViewCell {
        let balanceCell = tableView.dequeueReusableCell(withIdentifier: BalanceCell.reuseIdentifier, for: indexPath) as? BalanceCell
        balanceCell?.configureCell(with: viewModel)
        return balanceCell ?? UITableViewCell()
    }
    
    func getCardCell(with viewModel: [Card], indexPath: IndexPath) -> UITableViewCell {
        let cardCell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell
        cardCell?.configureCell(with: viewModel)
        goToLastItem = cardCell?.goToLastItem
        cardCell?.delegate = self
        return cardCell ?? UITableViewCell()
    }
    
    func getServicesCell(with viewModel: [ServiceViewModel], indexPath: IndexPath) -> UITableViewCell {
        let serviceCell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as? ServicesCell
        serviceCell?.configureCell(with: viewModel)
        serviceCell?.delegate = self
        return serviceCell ?? UITableViewCell()
    }
    
    func getResourcesCell(with viewModel: [ResourceViewModel], indexPath: IndexPath) -> UITableViewCell {
        let serviceCell = tableView.dequeueReusableCell(withIdentifier: ResourcesGridCell.reuseIdentifier, for: indexPath) as? ResourcesGridCell
        serviceCell?.configureCell(with: viewModel)
        return serviceCell ?? UITableViewCell()
    }
}

//MARK: - PresenterToView
extension HomeController: UpdateHomeListCellsProtocol {
    public func updateHomeCellsWith(homeList: [HomeListCellType]) {
        self.homeListDataSource = homeList
        tableView.reloadData()
    }
}

extension HomeController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        showAlertController(title: viewModel.title, message: viewModel.message)
    }
}

//MARK: - Delegate actions
extension HomeController: PersonHeaderDelegateProtocol {
    public func profileImageViewDidTapped() {
        presenter?.routeToProfile()
    }
}

extension HomeController: ServicesCellDelegateProtocol {
    public func cardServiceDidTapped(serviceTag: Int) {
        presenter?.routeToServiceWith(tag: serviceTag)
    }
}

extension HomeController: CardCellDelegateProtocol {
    public func cardDidTapped(cardSelected: Card) {
        isOpenFromHome = true
        presenter?.routeToCardInformationScreen(with: cardSelected)
    }
    
    public func addCardButtonDidTapped() {
        presenter?.routeToCardList()
    }
}
