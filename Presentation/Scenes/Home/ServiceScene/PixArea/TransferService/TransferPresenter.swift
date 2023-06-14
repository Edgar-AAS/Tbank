import Foundation
import Domain

public final class TransferPresenter {
    private let validatePixTransferService: ValidateBalance
    private let alertView: AlertView
    
    public init(validatePixTransferService: ValidateBalance, alertView: AlertView) {
        self.validatePixTransferService = validatePixTransferService
        self.alertView = alertView
    }
}

extension TransferPresenter: ViewToPresenterTransferProtocol {
    public func validateBalance(_ enteredValue: String) {
        let enteredValueRaw = enteredValue.removeCurrencyInputFormatting()
        validatePixTransferService.validate(enteredValue: enteredValueRaw) { [weak self] validationType in
            guard self != nil else { return }
            var message = String()
            switch validationType {
                case .authorized:
                    message = ""
                case .unauthorized:
                    message = "Saldo da conta indisponivel para transferencia"
                case .zero:
                    message = "Digite o valor que deseja transferir"
            }
            self?.alertView.showMessage(viewModel: AlertViewModel(title: "", message: message))
        }
    }
}
