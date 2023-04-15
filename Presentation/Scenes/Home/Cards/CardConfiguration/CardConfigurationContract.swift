import Foundation
import Domain

public protocol CardConfigurationRouterLogic {
    func goToCardSuccessScreen(digitalCardModel: DigitalCardModel)
}

public protocol ViewToCardConfigurationPresenter {
    func createDigitalCardWith(request: CardConfigurationRequest)
}

