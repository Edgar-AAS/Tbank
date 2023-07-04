import Foundation
import Domain

public class PreTransferPresenter {
    private weak var updateTransferView: UpdatePreTransferView?
    private let contactModel: ContactToTransferModel
    private let router: PreTransferRoutingLogic
    
    public init(contactModel: ContactToTransferModel,
                updateTransferView: UpdatePreTransferView,
                router: PreTransferRoutingLogic)
    {
        self.contactModel = contactModel
        self.updateTransferView = updateTransferView
        self.router = router
    }
}

//MARK: -- ViewToPresenterPreTransfer
extension PreTransferPresenter: ViewToPresenterPreTransfer {
    public func callsPreTransferData() {
        let viewModel = PreTransferViewModel(balanceToTransfer: contactModel.balanceToTransfer,
                                                   contactName: contactModel.contactName,
                                                   cpf: contactModel.cpf.formatCPF())
        updateTransferView?.update(viewModel: viewModel)
    }
    
    public func goToTransferSuccessView() {
        router.routeToTransferSuccessView(contact: contactModel)
    }
}

