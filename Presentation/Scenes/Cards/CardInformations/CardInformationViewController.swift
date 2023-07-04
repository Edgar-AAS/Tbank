import UIKit
import Domain

public final class CardInformationViewController: UIViewController {
    private lazy var cardInformationView: CardInformationView? = {
        return view as? CardInformationView
    }()
    
    public var userCardModel: Card?
    public var presenter: ViewToPresenterCardInformationViewProtocol?
    
    public override func loadView() {
        super.loadView()
        cardInformationView = CardInformationView()
        view = cardInformationView
        view.backgroundColor = Colors.primaryColor
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.updateCardInformationView()
        configurateView()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }
    
    private func configurateView() {
        navigationItem.leftBarButtonItem = NavigationBackButton(target: self, action: #selector(backButtonTapped))
        cardInformationView?.deleteCardButton.addTarget(self, action: #selector(deleteCardButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        if let homeController = navigationController?.viewControllers.last(where: { $0 is HomeControllerProtocol }) {
            if let isOpenFromHome = (homeController as? HomeController)?.isOpenFromHome {
                if isOpenFromHome {
                    (homeController as? HomeController)?.isOpenFromHome = false
                    presenter?.popToHomeController()
                } else {
                    presenter?.popToCardListController()
                }
            }
        }
    }
    
    @objc private func deleteCardButtonTapped() {
        guard let card = userCardModel else { return }
        presenter?.removeDigitalCard(at: card.id)
    }
}

extension CardInformationViewController: CardInformationDelegate {
    public func digitalCardDidRemoved(isNeedUpdateView: Bool) {
        if isNeedUpdateView {
            if let cardViewController = navigationController?.viewControllers.last(where: { $0 is CardsViewProtocol }) {
                (cardViewController as? CardsViewController)?.isNeedUpdate = true
                if let homeController = navigationController?.viewControllers.last(where: { $0 is HomeControllerProtocol }) {
                    (homeController as? HomeController)?.isNeedUpdateWithoutAnimation = true
                    (homeController as? HomeController)?.isNeedUpdateCard = false
                    presenter?.popToCardListController()
                }
            } else {
                if let homeController = navigationController?.viewControllers.last(where: { $0 is HomeControllerProtocol }) {
                    (homeController as? HomeController)?.isNeedUpdateWithoutAnimation = true
                    presenter?.popToHomeController()
                }
            }
        }
    }
}

extension CardInformationViewController: UpdateCardView {
    public func update(userCardModel: Card) {
        self.userCardModel = userCardModel
        cardInformationView?.configureUI(with: userCardModel)
    }
}
