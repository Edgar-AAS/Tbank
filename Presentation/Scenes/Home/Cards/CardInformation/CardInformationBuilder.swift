import Foundation
import Domain

final class CardInformationBuilder {
    static func build(digitalCardModel: DigitalCardModel) -> CardInformationViewController {
        let controller = CardInformationViewController()
        let router = CardInformationRouter(viewController: controller)
        let presenter = CardInformationPresenter(digitalCardModel: digitalCardModel, updateCardView: controller, router: router)
        controller.presenter = presenter
        return controller
    }
}
