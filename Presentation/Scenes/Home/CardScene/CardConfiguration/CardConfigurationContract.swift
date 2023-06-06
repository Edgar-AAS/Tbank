import Foundation
import Domain

public protocol CardConfigurationRouterLogic {
    func goToCardSuccessScreen(userCardModel: UserCard)
}

public protocol ViewToCardConfigurationPresenter {
    func createDigitalCardWith(request: CardConfigurationRequest)
}

