import UIKit
import Domain

public final class PixAreaViewController: UITableViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
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
        return 5
    }
    
    private let services = [Service(iconUrl: Icons.Url.transfer, serviceName: "Transferir", serviceTag: 0),
                            Service(iconUrl: Icons.Url.calendar, serviceName: "Programar", serviceTag: 1),
                            Service(iconUrl: Icons.Url.copyPaste, serviceName: "Pix Copia e Cola", serviceTag: 2),
                            Service(iconUrl: Icons.Url.qrCode, serviceName: "Ler QR code", serviceTag: 3)]
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PixAreaDescriptionCell.reuseIdentifier, for: indexPath) as? PixAreaDescriptionCell
            return cell ?? UITableViewCell()
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GenericTitleCell.reuseIdentifier, for: indexPath) as? GenericTitleCell
            cell?.setTitleForCell(text: "Enviar")
            return cell ?? UITableViewCell()
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as? ServicesCell
            cell?.setupCell(with: services)
            cell?.delegate = self
            return cell ?? UITableViewCell()
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GenericTitleCell.reuseIdentifier, for: indexPath) as? GenericTitleCell
            cell?.setTitleForCell(text: "Receber")
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as? ServicesCell
            cell?.setupCell(with: [Service(iconUrl: Icons.Url.demand, serviceName: "Cobrar", serviceTag: 1),
                                   Service(iconUrl: Icons.Url.deposit, serviceName: "Depositar", serviceTag: 1)])
            return cell ?? UITableViewCell()
        }
    }
}

extension PixAreaViewController: ServicesCellDelegateProtocol {
    public func cardServiceDidTapped(serviceTag: Int) {
        presenter?.callPixServiceWith(tag: serviceTag)
    }
}
