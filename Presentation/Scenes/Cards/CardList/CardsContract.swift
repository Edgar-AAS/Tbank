import Foundation
import Domain

public protocol ViewToPresenterCardsProtocol {
    func routeToCardCreationFlow()
    func routeToCardInformationViewWith(section: Int, row: Int)
    func fetchCardsList()
}

public protocol CardRoutingLogic {
    func goToCardCreationNavigation()
    func goToCardInformationScreenWith(userCard: Card)
}
