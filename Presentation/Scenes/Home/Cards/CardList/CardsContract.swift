import Foundation
import Domain

public protocol ViewToPresenterCardsProtocol {
    func routeToCardCreationFlow()
    func routeToCardInformationViewWith(indexPath: IndexPath)
    func fetchCards()
}

public protocol CardRoutingLogic {
    func goToCardCreationNavigation()
    func goToCardInformationScreenWith(userCard: UserCard)
}
