import UIKit

protocol CardsViewProtocol where Self: UIViewController {
    var isNeedUpdate: Bool { get set }
}

public class CardsViewController: UIViewController, CardsViewProtocol {
    var isNeedUpdate: Bool = false
    
    public var cardView: CardsScreenView?
    public var presenter: ViewToPresenterCardsProtocol?
    
    private var virtualCards = [CardModel]()
    private var physicalCards = [CardModel]()
        
    public override func loadView() {
        super.loadView()
        cardView = CardsScreenView(delegate: self)
        cardView?.setupTableViewProtocols(delegate: self, dataSource: self)
        view = cardView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchCards()
        navigationController?.navigationBar.isHidden = false
        navigationItem.backButtonTitle = ""
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNeedUpdate {
            presenter?.fetchCards()
            isNeedUpdate = false
        }
    }
}

extension CardsViewController: CardsView {
    public func updateCardsView(viewModel: CardsViewViewModel) {
        virtualCards = viewModel.cards.filter({ $0.isVirtual == true })
        physicalCards = viewModel.cards.filter({ $0.isVirtual == false })
        cardView?.myCardsTableView.reloadData()
    }
}

extension CardsViewController: CardsScreenViewDelegateProtocol {
    func closeButtonDidTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CardsViewController: UITableViewDataSource {
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
        if indexPath.section == 0 {
            if indexPath.row <= virtualCards.count - 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: CardListCell.reuseIdentifier, for: indexPath) as? CardListCell
                cell?.textLabel?.text = virtualCards[indexPath.row].name
                cell?.detailTextLabel?.text = virtualCards[indexPath.row].cardNumber.toSafeCardNumber()
                return cell ?? UITableViewCell()
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddVirtualCardCell.reuseIdentifier, for: indexPath) as? AddVirtualCardCell
                cell?.backgroundColor = Colors.primaryColor
                return cell ?? UITableViewCell()
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CardListCell.reuseIdentifier, for: indexPath) as? CardListCell
            cell?.textLabel?.text = physicalCards[indexPath.row].name
            cell?.detailTextLabel?.text = physicalCards[indexPath.row].cardNumber.toSafeCardNumber()
            return cell  ?? UITableViewCell()
        }
    }
    
    public func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.textColor = Colors.offWhiteColor
            header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        }
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var titleHeader: String?
        if section == 0 {
            titleHeader = "Cartões digitais"
        } else {
            titleHeader = "Cartões físicos"
        }
        return titleHeader
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 1 {
            return nil
        } else {
            let view = UIView()
            view.backgroundColor = Colors.secundaryColor
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

extension CardsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let index = IndexPath(row: virtualCards.count, section: 0)
        
        if indexPath == index {
            presenter?.routeToCardCreationFlow()
        } else {
            presenter?.routeToCardInformationViewWith(indexPath: indexPath)
        }
    }
}
