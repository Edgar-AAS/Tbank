import Foundation
import Domain

public final class TransferPresenter {
    private let validatePixTransferService: ValidateBalance
    private let alertView: AlertView
    private let updateBalance: UpdateBalance
    private let updateBalanceView: UpdateBalanceView
    
    public init(validatePixTransferService: ValidateBalance, alertView: AlertView, updateBalance: UpdateBalance, updateBalanceView: UpdateBalanceView) {
        self.validatePixTransferService = validatePixTransferService
        self.updateBalance = updateBalance
        self.alertView = alertView
        self.updateBalanceView = updateBalanceView
    }
}

extension TransferPresenter: ViewToPresenterTransferProtocol {
    public func fetchBalance() {
        updateBalance.fetchBalance() { [weak self] balance in
            guard self != nil else { return }
            self?.updateBalanceView.update(balance: balance.currencyWith(symbol: .brazilianReal))
        }
    }
    
    public func validateBalance(_ enteredValue: String) {
        let enteredValueRaw = enteredValue.removeCurrencyInputFormatting()
        validatePixTransferService.validate(enteredValue: enteredValueRaw) { [weak self] validationType in
            guard self != nil else { return }
            var message = String()
            switch validationType {
                case .authorized:
                    message = "Saldo autorizado"
                case .unauthorized:
                    message = "Saldo da conta indisponivel para transferencia"
                case .zero:
                    message = "Digite o valor que deseja transferir"
            }
            self?.alertView.showMessage(viewModel: AlertViewModel(title: "", message: message))
        }
    }
}
