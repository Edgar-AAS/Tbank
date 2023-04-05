import UIKit

public class CardsViewController: UIViewController {
    public var cardView: CardsScreenView?
    public var presenter: ViewToPresenterCardsProtocol?
    
    var virtualCards = [CardModel]()
    var physicalCards = [CardModel]()
    
    public override func loadView() {
        super.loadView()
        cardView = CardsScreenView(delegate: self)
        cardView?.setupTableViewProtocols(delegate: self, dataSource: self)
        view = cardView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        presenter?.fetchCards()
    }
}

extension CardsViewController: CardsView {
    public func updateCardsView(viewModel: CardsViewViewModel) {
        virtualCards = viewModel.cards.filter({ $0.isVirtual == true })
        physicalCards = viewModel.cards.filter({ $0.isVirtual == false })
    }
}

extension CardsViewController: CardsScreenViewDelegateProtocol {
    func closeButtonDidTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CardsViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return virtualCards.count + 1
        } else {
            return physicalCards.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row <= virtualCards.count - 1 {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
                cell.textLabel?.text = virtualCards[indexPath.row].cardNumber
                cell.imageView?.image = UIImage(named: "card-front-icon")
                cell.accessoryType = .disclosureIndicator
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
                cell.textLabel?.text = physicalCards[indexPath.row].cardNumber
                cell.imageView?.image = UIImage(named: "card-front-icon")
                cell.accessoryType = .disclosureIndicator
                return cell
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddVirtualCardCell.reuseIdentifier, for: indexPath) as? AddVirtualCardCell
            return cell ?? UITableViewCell()
        }
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
                
        if indexPath.row == virtualCards.count {
            presenter?.routeToCardCreationFlow()
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Cartões virtuais"
        } else {
            return "Cartão físico"
        }
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            return nil
        } else {
            let view = UIView()
            view.backgroundColor = .lightGray
            return view
        }
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    } 
}
