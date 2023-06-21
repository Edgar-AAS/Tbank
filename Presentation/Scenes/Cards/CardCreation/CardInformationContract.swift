import Foundation

public protocol ViewToPresenterCardInformationViewProtocol {
    func updateCardInformationView()
    func popToCardController()
    func popToHomeController()
    func removeCard(at id: String)
}

public protocol CardInformationRoutingLogic {
    func popToCardController()
    func popToHome()
}
