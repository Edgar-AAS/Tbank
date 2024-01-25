import UIKit
import Domain

protocol CardsViewProtocol where Self: UIViewController {
    var isNeedUpdate: Bool { get set }
}

public class CardsViewController: UIViewController, CardsViewProtocol {
    var isNeedUpdate: Bool = false
    public var cardView: CardsScreenView?
    public var presenter: ViewToPresenterCardsProtocol?
    
    private var virtualCards = [Card]()
    private var physicalCards = [Card]()
    
    public override func loadView() {
        super.loadView()
        cardView = CardsScreenView()
        cardView?.setupTableViewProtocols(delegate: self, dataSource: self)
        view = cardView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        showNavigationBar()
        removeBackButtonTitle()
        presenter?.fetchCardsList()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isNeedUpdate {
            presenter?.fetchCardsList()
            isNeedUpdate = false
        }
    }
}

extension CardsViewController: UpdateCardListCells {
    public func updateCardsList(cardListSource: CardListSource) {
        self.virtualCards = cardListSource.virtualCards
        self.physicalCards = cardListSource.physicalCards
        cardView?.myCardsTableView.reloadData()
    }
}

extension CardsViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == .zero {
            return virtualCards.count + 1
        } else {
            return physicalCards.count
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == .zero {
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
}

extension CardsViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let lastRow = IndexPath(row: virtualCards.count, section: 0)
        if indexPath == lastRow {
            presenter?.routeToCardCreationFlow()
        } else {
            presenter?.routeToCardInformationViewWith(section: indexPath.section, row: indexPath.row)
        }
    }
}
