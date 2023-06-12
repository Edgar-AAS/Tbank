import Foundation
import Presentation

func makePixAreaControllerFactory() -> PixAreaViewController {
    let pixAreaController = PixAreaViewController()
    let router = PixAreaRouter(viewController: pixAreaController)
    let presenter = PixAreaServicePresenter(router: router)
    pixAreaController.presenter = presenter
    return pixAreaController
}
