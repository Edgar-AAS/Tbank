import UIKit
import Domain

public final class PixAreaViewController: UITableViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        removeBackButtonTitle()
        setupTableViewProperties()
        registerTableViewCells()
    }
    
    public var presenter: ViewToPresenterPixAreaProtocol?
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
        return presenter?.getNumberOfCells() ?? 0
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PixAreaDescriptionCell.reuseIdentifier, for: indexPath) as? PixAreaDescriptionCell
            return cell ?? UITableViewCell()
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GenericTitleCell.reuseIdentifier, for: indexPath) as? GenericTitleCell
            cell?.setTitleForCell(text: "Enviar")
            return cell ?? UITableViewCell()
        } else if indexPath.row == 2 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as? ServicesCell {
//                guard let service = presenter?.getServicesCell() else { return UITableViewCell() }
                cell.configureCell(with: [ServiceViewModel(iconURL: "", serviceName: "", serviceTag: 1)])
                cell.delegate = self
                return cell
            } else { return UITableViewCell() }
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GenericTitleCell.reuseIdentifier, for: indexPath) as? GenericTitleCell
            cell?.setTitleForCell(text: "Receber")
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as? ServicesCell
            cell?.configureCell(with: [ServiceViewModel(iconURL: Icons.Url.demand, serviceName: "Cobrar", serviceTag: 1),
                                       ServiceViewModel(iconURL: Icons.Url.deposit, serviceName: "Depositar", serviceTag: 1)])
            return cell ?? UITableViewCell()
        }
    }
}



extension PixAreaViewController: ServicesCellDelegateProtocol {
    public func cardServiceDidTapped(serviceTag: Int) {
        presenter?.callPixServiceWith(tag: serviceTag)
    }
}
