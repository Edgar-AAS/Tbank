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

extension WeakVarProxy: ProfileView where T: ProfileView {
    func updateProfileView(viewModel: ProfileViewModel) {
        instance?.updateProfileView(viewModel: viewModel)
    }
}

extension WeakVarProxy: BalanceView where T: BalanceView {
    func updateBalanceView(viewModel: BalanceViewModel) {
        instance?.updateBalanceView(viewModel: viewModel)
    }
}

extension WeakVarProxy: CardsView where T: CardsView {
    func updateCardsView(viewModel: CardsViewViewModel) {
        instance?.updateCardsView(viewModel: viewModel)
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

extension WeakVarProxy: UpdateProfileView where T: UpdateProfileView {
    func updateWith(viewModel: UserDataViewModel) {
        instance?.updateWith(viewModel: viewModel)
    }
}

extension WeakVarProxy: UpdateCardView where T: UpdateCardView {
    func update(cardViewModel: CardModel) {
        instance?.update(cardViewModel: cardViewModel)
    }
}

extension WeakVarProxy: CardInformationDelegate where T: CardInformationDelegate {
    func digitalCardDidRemoved(isNeedUpdateView: Bool) {
        instance?.digitalCardDidRemoved(isNeedUpdateView: isNeedUpdateView)
    }
}
