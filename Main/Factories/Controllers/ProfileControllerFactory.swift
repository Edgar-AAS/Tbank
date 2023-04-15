import Foundation
import Domain
import Data
import Presentation
import Infra

func makeProfileController(fetchUserData: FetchUserDataResources) -> ProfileController {
    let controller = ProfileController()
    let presenter = ProfilePresenter(fetchUserData: fetchUserData, updatePersonTableView: WeakVarProxy(controller), alertView: WeakVarProxy(controller))
    controller.presenter = presenter
    return controller
}

