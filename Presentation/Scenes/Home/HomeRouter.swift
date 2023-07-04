import UIKit
import Domain

public class HomeRouter {
    public weak var viewController: UIViewController?
    private var cardsControllerFactory: () -> CardsViewController
    private var profileControllerFactory: (ProfileInfoModel) -> ProfileController
    private var cardInformationFactory: (Card) -> CardInformationViewController
    private var pixAreaControllerFactory: () -> PixAreaViewController
    
    public init(viewController: UIViewController,
                profileControllerFactory: @escaping (ProfileInfoModel) -> ProfileController,
                cardsControllerFactory: @escaping () -> CardsViewController,
                cardInformationFactory: @escaping (Card) -> CardInformationViewController,
                pixAreaControllerFactory: @escaping () -> PixAreaViewController)
    {
        self.viewController = viewController
        self.cardsControllerFactory = cardsControllerFactory
        self.profileControllerFactory = profileControllerFactory
        self.cardInformationFactory = cardInformationFactory
        self.pixAreaControllerFactory = pixAreaControllerFactory
    }
}

extension HomeRouter: PresenterToRouterHomeProtocol {
    public func goToCardServiceWith(tag: Int) {
        switch tag {
        case 0:
            viewController?.navigationController?.pushViewController(pixAreaControllerFactory(), animated: true)
        default: return
        }
    }
    
    public func goToInformationControllerWith(selectedCard: Card) {
        viewController?.navigationController?.pushViewController(cardInformationFactory(selectedCard), animated: true)
    }
    
    public func goToProfileWith(personalUserInfo: ProfileInfoModel) {
        viewController?.navigationController?.pushViewController(profileControllerFactory(personalUserInfo), animated: true)
    }
    
    public func goToCardsController() {
        viewController?.navigationController?.pushViewController(cardsControllerFactory(), animated: true)
    }
}
