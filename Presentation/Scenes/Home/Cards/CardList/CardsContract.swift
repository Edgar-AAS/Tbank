import Foundation

public protocol ViewToPresenterCardsProtocol {
    func routeToCardCreationFlow()
    func fetchCards()
}

public protocol CardRoutingLogic {
    func goToCardCreationNavigation()
}
