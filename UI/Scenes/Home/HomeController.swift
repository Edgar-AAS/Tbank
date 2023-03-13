import UIKit

private enum HomeCellsType: Int {
    case balanceCell
    case cardCell
    case serviceCell
    case resourcesCell
}

public final class HomeController: UITableViewController {
    public lazy var refreshC: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        return refreshControl
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupHeader()
        tableView.addSubview(refreshC)
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.refreshC.endRefreshing()
        }
    }
    
    public override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let header = tableView.tableHeaderView as? PersonHeader else { return }
        header.scrollViewDidScroll(scrollView: tableView)
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
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
    
    private func setupHeader() {
        let header = PersonHeader(frame: .init(x: 0, y: 0, width: view.frame.width, height: 100))
        tableView.tableHeaderView = header
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

