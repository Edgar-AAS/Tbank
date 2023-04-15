import Foundation
import Domain

final class CardSuccessBuilder {
    static func build(digitalCardModel: DigitalCardModel) -> CardSuccessViewController {
        let controller = CardSuccessViewController()
        let router = CardSuccessRouter(viewController: controller)
        let presenter = CardSuccessPresenter(router: router, digitalCardModel: digitalCardModel)
        controller.presenter = presenter
        return controller
    }
}
