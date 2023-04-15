import Foundation

protocol ViewToPresenterCardInformationViewProtocol {
    func updateCardInformationView()
    func popToCardController() 
}

public protocol CardInformationRoutingLogic {
    func popToCardController()
}
