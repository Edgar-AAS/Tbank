import Foundation
import Domain

public protocol CardConfigurationRouterLogic {
    func goToCardSuccessScreen(userCardModel: Card)
}

public protocol ViewToCardConfigurationPresenter {
    func createDigitalCardWith(request: CardConfigurationRequest)
}

