import UIKit
import Domain

public final class ContactListToTransferController: UITableViewController {
    private lazy var headerView: ContactListToTransferHeader = {
        let view = ContactListToTransferHeader()
        view.pixKeyTextField.delegate = self
        return view
    }()
    
    private var contactList = [ContactModel]()
    public var presenter: ViewToPresentContactList?
    private var balanceString: String?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        removeBackButtonTitle()
        setupTableViewProperties()
        hideKeyboardOnTap()
        presenter?.fetchListWith(text: "")
        presenter?.updateBalance()
    }
    
    private func setupTableViewProperties() {
        tableView.register(ContactListCell.self, forCellReuseIdentifier: ContactListCell.reuseIdentifier)
        tableView.showsVerticalScrollIndicator = false
        view.backgroundColor = Colors.primaryColor
    }
}

//MARK: - UITableViewDataSource
extension ContactListToTransferController {
    public override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }

    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactList.count
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ContactListCell.reuseIdentifier, for: indexPath) as? ContactListCell
        let contact = contactList[indexPath.row]
        cell?.setupCell(contact: contact)
        return cell ?? UITableViewCell()
    }
    
//MARK: - UITableViewDelegate
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contactList[indexPath.row]
        guard let balance = balanceString else { return }
        let contactModel = ContactToTransferModel(balanceToTransfer: balance, contactName: contact.name, cpf: contact.cpf)
        presenter?.goToPreTransferScreenWith(contactModel: contactModel)
    }
}

//MARK: - Views
extension ContactListToTransferController: UpdateBalanceView {
    public func update(balance: String) {
        balanceString = balance
        headerView.updateBalanceLabel(balanceString: balance)
    }
}

extension ContactListToTransferController: ContactListDataSource {
    public func updateList(list: [ContactModel]) {
        contactList = list
        tableView.reloadData()
    }
}

//MARK: - UITextFieldDelegate
extension ContactListToTransferController: UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let query = textField.text else { return }
        presenter?.fetchListWith(text: query)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}
