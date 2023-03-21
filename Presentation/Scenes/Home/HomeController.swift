import UIKit

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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupHeader()
        tableView.addSubview(refreshControlIndicator)
        testParse(stringDate: "2016-02-29 12:24:26")
    }

    //vai receber a data em utc
    //eu recebo um UTC converto para a linguagem do device
    
    //definir qual formato voce rebeceu
    //definir qual formato vou quer setar
    
    func testParse(stringDate: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let setFormatter = DateFormatter()
        setFormatter.dateFormat = "MM/yy" //<- o idioma do aplicativo deve ser levado em consideração
        
        if let date = dateFormatter.date(from: stringDate) {
            print(setFormatter.string(from: date))
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        presenter?.fetchData()
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
        let header = PersonHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 100))
        header.delegate = self
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
            return cell ?? UITableViewCell()
        case .cardCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell
            return cell ?? UITableViewCell()
        case .serviceCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as? ServicesCell
            return cell ?? UITableViewCell()
        case .resourcesCell:
            let cell = tableView.dequeueReusableCell(withIdentifier: ResourcesGridCell.reuseIdentifier, for: indexPath) as? ResourcesGridCell
            return cell ?? UITableViewCell()
        default: return UITableViewCell()
        }
    }
}

//MARK: - PersonHeader Delegates
extension HomeController: PersonHeaderDelegateProtocol {
    public func profileButtonDidTapped() {
        presenter?.routeToProfile()
    }
}

//MARK: Presenter -> View
extension HomeController: RefreshUserDataDisplay {
    public func update(viewModel: UserDataViewModel) {
        
    }
}

