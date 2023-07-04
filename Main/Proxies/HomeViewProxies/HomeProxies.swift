import Foundation
import Presentation
import Domain

extension WeakVarProxy: AlertView where T: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        instance?.showMessage(viewModel: viewModel)
    }
}

extension WeakVarProxy: LoadingView where T: LoadingView {
    func isLoading(viewModel: LoadingViewModel) {
        instance?.isLoading(viewModel: viewModel)
    }
}

extension WeakVarProxy: BalanceView where T: BalanceView {
    func updateBalanceView(viewModel: BalanceViewModel) {
        instance?.updateBalanceView(viewModel: viewModel)
    }
}

extension WeakVarProxy: UpdateCardListCells where T: UpdateCardListCells {
    func updateCardsList(cardListSource: CardListSource) {
        instance?.updateCardsList(cardListSource: cardListSource)
    }
}

extension WeakVarProxy: ServicesView where T: ServicesView {
    func updateServicesView(services: [Service]) {
        instance?.updateServicesView(services: services)
    }
}

extension WeakVarProxy: ResourcesView where T: ResourcesView {
    func updateResourcesView(resources: [Resource]) {
        instance?.updateResourcesView(resources: resources)
    }
}

extension WeakVarProxy: UpdateCardView where T: UpdateCardView {
    func update(userCardModel: Card) {
        instance?.update(userCardModel: userCardModel)
    }
}

extension WeakVarProxy: CardInformationDelegate where T: CardInformationDelegate {
    func digitalCardDidRemoved(isNeedUpdateView: Bool) {
        instance?.digitalCardDidRemoved(isNeedUpdateView: isNeedUpdateView)
    }
}

extension WeakVarProxy: UpdateBalanceView where T: UpdateBalanceView {
    func update(balance: String) {
        instance?.update(balance: balance)
    }
}

extension WeakVarProxy: ContactListDataSource where T: ContactListDataSource {
    func updateList(list: [ContactModel]) {
        instance?.updateList(list: list)
    }
}

extension WeakVarProxy: UpdateHomeListCellsProtocol where T: UpdateHomeListCellsProtocol {
    func updateHomeCellsWith(homeList: [HomeListCellType]) {
        instance?.updateHomeCellsWith(homeList: homeList)
    }
}
