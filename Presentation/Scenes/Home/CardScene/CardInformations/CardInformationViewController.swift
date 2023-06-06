import UIKit
import Domain

public final class CardInformationViewController: UIViewController {
    private lazy var cardInformationView: CardInformationView? = {
        return view as? CardInformationView
    }()
    
    public var userCardModel: UserCard?
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
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configurateView() {
        let backButton = UIBarButtonItem(title: "Voltar", style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = backButton
        cardInformationView?.deleteCardButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func backButtonTapped() {
        if let homeController = navigationController?.viewControllers.last(where: { $0 is HomeControllerProtocol }) {
            if let state = (homeController as? HomeController)?.isOpenFromHome {
                if state {
                    (homeController as? HomeController)?.isOpenFromHome = false
                    presenter?.popToHomeController()
                } else {
                    presenter?.popToCardController()
                }
            }
        }
    }
    
    @objc private func deleteButtonTapped() {
        guard let card = userCardModel else { return }
        presenter?.removeCard(at: card.id)
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
                    presenter?.popToCardController()
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
    public func update(userCardModel: UserCard) {
        cardInformationView?.updateUI(userCardModel: userCardModel)
        self.userCardModel = userCardModel
    }
}
