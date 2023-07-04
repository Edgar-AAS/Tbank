import Foundation
import Domain
import Data

public protocol ViewToPresenterHomeProtocol: AnyObject {
    func routeToProfile()
    func routeToCardList()
    func routeToCardInformationScreen(with cardModel: Card)
    func routeToServiceWith(tag: Int)
    func fetchUserData()
}

public protocol PresenterToRouterHomeProtocol {
    func goToProfileWith(personalUserInfo: ProfileInfoModel)
    func goToCardsController()
    func goToInformationControllerWith(selectedCard: Card)
    func goToCardServiceWith(tag: Int)
}

public protocol UpdateHomeListCellsProtocol: AnyObject {
    func updateHomeCellsWith(homeList: [HomeListCellType])
}
