import UIKit
import Domain

protocol CardsViewProtocol where Self: UIViewController {
    var isNeedUpdate: Bool { get set }
}

public class CardsViewController: UIViewController, CardsViewProtocol {
    var isNeedUpdate: Bool = false
    
    public var cardView: CardsScreenView?
    public var presenter: ViewToPresenterCardsProtocol?
    
    private var virtualCards = [UserCard]()
    private var physicalCards = [UserCard]()
        
    public override func loadView() {
        super.loadView()
        cardView = CardsScreenView(delegate: self)
        cardView?.setupTableViewProtocols(delegate: self, dataSource: self)
        view = cardView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchCards()
        navigationItem.backButtonTitle = ""
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        super.viewWillAppear(animated)
        if isNeedUpdate {
            presenter?.fetchCards()
            isNeedUpdate = false
        }
    }
}

extension CardsViewController: CardsView {
    public func updateCardsView(cardsModel: UserCards) {
        virtualCards = cardsModel.filter({ $0.isVirtual == true })
        physicalCards = cardsModel.filter({ $0.isVirtual == false })
        cardView?.myCardsTableView.reloadData()
    }
}

extension CardsViewController: CardsScreenViewDelegateProtocol {
    func closeButtonDidTapped() {
        navigationController?.popViewController(animated: true)
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
                cell?.setupCell(userCard: virtualCards[indexPath.row])
                return cell ?? UITableViewCell()
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddVirtualCardCell.reuseIdentifier, for: indexPath) as? AddVirtualCardCell
                return cell ?? UITableViewCell()
            }
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: CardListCell.reuseIdentifier, for: indexPath) as? CardListCell
            cell?.setupCell(userCard: physicalCards[indexPath.row])
            return cell  ?? UITableViewCell()
        }
    }
}


//MARK: - Header and Footer
extension CardsViewController {
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
        let index = IndexPath(row: virtualCards.count, section: 0)
        if indexPath == index {
            presenter?.routeToCardCreationFlow()
        } else {
            presenter?.routeToCardInformationViewWith(indexPath: indexPath)
        }
    }
}
