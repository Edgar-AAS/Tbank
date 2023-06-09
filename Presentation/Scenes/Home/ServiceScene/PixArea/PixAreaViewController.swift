import UIKit
import Domain

final class PixAreaViewController: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableViewProperties()
        registerTableViewCells()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: PixAreaDescriptionCell.reuseIdentifier, for: indexPath) as? PixAreaDescriptionCell
            return cell ?? UITableViewCell()
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GenericTitleCell.reuseIdentifier, for: indexPath) as? GenericTitleCell
            cell?.setTitleForCell(text: "Enviar")
            return cell ?? UITableViewCell()
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as? ServicesCell
            cell?.setupCell(services: [Service(serviceIconURL: "dock.arrow.up.rectangle", serviceName: "Transferir", serviceTag: 1),
                                       Service(serviceIconURL: "calendar", serviceName: "Programar", serviceTag: 1),
                                       Service(serviceIconURL: "square.on.square", serviceName: "Pix Copia e Cola", serviceTag: 1),
                                       Service(serviceIconURL: "qrcode", serviceName: "Ler QR code", serviceTag: 1)])
            cell?.delegate = self
            return cell ?? UITableViewCell()
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: GenericTitleCell.reuseIdentifier, for: indexPath) as? GenericTitleCell
            cell?.setTitleForCell(text: "Receber")
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ServicesCell.reuseIdentifier, for: indexPath) as? ServicesCell
            cell?.setupCell(services: [Service(serviceIconURL: "dollarsign.square", serviceName: "Cobrar", serviceTag: 1),
                                       Service(serviceIconURL: "dock.arrow.down.rectangle", serviceName: "Depositar", serviceTag: 1)])
            return cell ?? UITableViewCell()
        }
    }
}

extension PixAreaViewController: ServicesCellDelegateProtocol {
    func cardServiceDidTapped(serviceTag: Int) {
        print("123123")
    }
}
