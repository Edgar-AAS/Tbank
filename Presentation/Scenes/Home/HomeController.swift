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
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        presenter?.fetchUserData()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
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
//            header?.profileImageView.loadImageWith(path: makeUserImagePath()) -> TALVEZ UMA DELEGATE DO HEADER PARA A CONTROLLE NOTIFICANDO O STATUS
            isNeedUpdateProfile = false
        default: return
        }
    }
    
    private func makeUserImagePath() -> String {
        let path = getDocumentsDirectory().appendingPathComponent(FileManagerPaths.userImage).path
        return path
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
            case .cardsCell(let cardViewModels):
                cell = getCardCell(with: cardViewModels, indexPath: indexPath)
            case .servicesCell(let serviceViewModels):
                cell = getServicesCell(with: serviceViewModels, indexPath: indexPath)
            case .resourcesCell(let resourceViewModels):
                cell = getResourcesCell(with: resourceViewModels, indexPath: indexPath)
        }
        return cell
    }
}

extension HomeController {
    func getPersonHeaderCell(with viewModel: PersonHeaderViewModel, indexPath: IndexPath) -> PersonHeaderCell {
        let personCell = tableView.dequeueReusableCell(withIdentifier: PersonHeaderCell.reuseIdentifier, for: indexPath) as! PersonHeaderCell
        personCell.profileImageView.loadImageWith(path: makeUserImagePath())
        personCell.configureCell(with: viewModel)
        return personCell
    }
    
    func getBalanceCell(with viewModel: BalanceViewModel, indexPath: IndexPath) -> BalanceCell {
        let balanceCell = tableView.dequeueReusableCell(withIdentifier: BalanceCell.reuseIdentifier, for: indexPath) as! BalanceCell
        balanceCell.configureCell(with: viewModel)
        return balanceCell
    }
    
    func getCardCell(with viewModel: [CardViewModel], indexPath: IndexPath) -> CardCell {
        let cardCell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseIdentifier, for: indexPath) as! CardCell
        cardCell.configureCell(with: viewModel)
        return cardCell
    }
    
    func getServicesCell(with viewModel: [ServiceViewModel], indexPath: IndexPath) -> ServicesCell {
        let serviceCell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as! ServicesCell
        serviceCell.configureCell(with: viewModel)
        return serviceCell
    }
    
    func getResourcesCell(with viewModel: [ResourceViewModel], indexPath: IndexPath) -> ResourcesGridCell {
        let serviceCell = tableView.dequeueReusableCell(withIdentifier: ResourcesGridCell.reuseIdentifier, for: indexPath) as! ResourcesGridCell
        serviceCell.configureCell(with: viewModel)
        return serviceCell
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
    public func profileButtonDidTapped() {
        presenter?.routeToProfile()
    }
}

extension HomeController: ServicesCellDelegateProtocol {
    public func cardServiceDidTapped(serviceTag: Int) {
        presenter?.routeToServiceWith(tag: serviceTag)
    }
}

extension HomeController: CardCellDelegateProtocol {
    public func cardDidTapped(userCard: Card) {
        isOpenFromHome = true
        presenter?.routeToCardInformationScreen(with: userCard)
    }
    
    public func addCardButtonDidTapped() {
        presenter?.routeToCards()
    }
}
