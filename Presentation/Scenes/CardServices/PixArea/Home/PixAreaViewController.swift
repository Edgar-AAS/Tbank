import UIKit
import Domain

public final class PixAreaViewController: UITableViewController {
    
    public var presenter: ViewToPresenterPixAreaProtocol?
    public var pixAreaCellListDataSource: [PixAreaCellsType] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        removeBackButtonTitle()
        setupTableViewProperties()
        registerTableViewCells()
        presenter?.fetchPixServices()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }
    
    private func registerTableViewCells() {
        tableView.register(PixAreaDescriptionCell.self, forCellReuseIdentifier: PixAreaDescriptionCell.reuseIdentifier)
        tableView.register(GenericTitleCell.self, forCellReuseIdentifier: GenericTitleCell.reuseIdentifier)
        tableView.register(ServicesCell.self, forCellReuseIdentifier: ServicesCell.reuseIdentifier)
    }
    
    private func setupTableViewProperties() {
        view.backgroundColor = Colors.primaryColor
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pixAreaCellListDataSource.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        let cellType = pixAreaCellListDataSource[indexPath.row]
        
        switch cellType {
        case .pixAreaDescription:
            cell = getPixAreaDescriptionCell(indexPath: indexPath)
        case .sendTitle:
            cell = getSendTitleCell(indexPath: indexPath)
        case .sendServices(let sendViewModels):
            cell = getSendServicesCell(with: sendViewModels, indexPath: indexPath)
        case .receiveTitle:
            cell = getReceiveTitleCell(indexPath: indexPath)
        case .receiveServices(let receiveViewModels):
            cell = getReceiveServicesCell(with: receiveViewModels, indexPath: indexPath)
        }
        return cell
    }
}

//MARK: - Delegate actions
extension PixAreaViewController: ServicesCellDelegateProtocol {
    public func cardServiceDidTapped(serviceTag: Int) {
        presenter?.callPixServiceWith(tag: serviceTag)
    }
}

//MARK: - PresenterToView
extension PixAreaViewController: UpdatePixAreaListCellsProtocol {
    public func updatePixAreaCellsWith(dataSource: [PixAreaCellsType]) {
        self.pixAreaCellListDataSource = dataSource
    }
}

//MARK: - Cells Creation
extension PixAreaViewController {
    func getPixAreaDescriptionCell(indexPath: IndexPath) -> UITableViewCell {
        let pixAreaDescriptionCell = tableView.dequeueReusableCell(withIdentifier: PixAreaDescriptionCell.reuseIdentifier, for: indexPath) as? PixAreaDescriptionCell
        return pixAreaDescriptionCell ?? UITableViewCell()
    }
    
    func getSendTitleCell(indexPath: IndexPath) -> UITableViewCell {
        let sendTitleCell = tableView.dequeueReusableCell(withIdentifier: GenericTitleCell.reuseIdentifier, for: indexPath) as? GenericTitleCell
        sendTitleCell?.setTitleForCell(textType: .sending)
        return sendTitleCell ?? UITableViewCell()
    }
    
    func getSendServicesCell(with viewModel: [ServiceViewModel], indexPath: IndexPath) -> UITableViewCell {
        let sendServicesCell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as? ServicesCell
        sendServicesCell?.configureCell(with: viewModel)
        sendServicesCell?.delegate = self
        return sendServicesCell ?? UITableViewCell()
    }
    
    func getReceiveTitleCell(indexPath: IndexPath) -> UITableViewCell {
        let sendTitleCell = tableView.dequeueReusableCell(withIdentifier: GenericTitleCell.reuseIdentifier, for: indexPath) as? GenericTitleCell
        sendTitleCell?.setTitleForCell(textType: .receiving)
        return sendTitleCell ?? UITableViewCell()
    }
    
    func getReceiveServicesCell(with viewModel: [ServiceViewModel], indexPath: IndexPath) -> UITableViewCell {
        let receiveServicesCell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as? ServicesCell
        receiveServicesCell?.configureCell(with: viewModel)
        return receiveServicesCell ?? UITableViewCell()
    }
}
