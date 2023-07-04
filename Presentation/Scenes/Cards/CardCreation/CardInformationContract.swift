import Foundation

public protocol ViewToPresenterCardInformationViewProtocol {
    func updateCardInformationView()
    func popToCardListController()
    func popToHomeController()
    func removeDigitalCard(at id: String)
}

public protocol CardInformationRoutingLogic {
    func popToCardController()
    func popToHome()
}
