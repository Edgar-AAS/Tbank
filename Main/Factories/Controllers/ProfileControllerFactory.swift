import Foundation
import Domain
import Data
import Presentation
import Infra

func makeProfileController(profileInfoModel: ProfileInfoModel) -> ProfileController {
    let controller = ProfileController(style: .grouped)
    let presenter = ProfilePresenter(profileInfoModel: profileInfoModel, updateProfileListCells: controller)
    controller.presenter = presenter
    return controller
}

