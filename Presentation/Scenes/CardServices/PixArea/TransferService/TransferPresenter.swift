import Foundation
import Domain

public final class TransferPresenter {
    private let validatePixTransferService: ValidateBalance
    private let alertView: AlertView
    private let updateBalance: UpdateBalance
    private let updateBalanceView: UpdateBalanceView
    private let router: TransferRouterLogic
    
    public init(validatePixTransferService: ValidateBalance,
                alertView: AlertView,
                updateBalance: UpdateBalance,
                updateBalanceView: UpdateBalanceView,
                router: TransferRouterLogic
    ) {
        self.validatePixTransferService = validatePixTransferService
        self.updateBalance = updateBalance
        self.alertView = alertView
        self.updateBalanceView = updateBalanceView
        self.router = router
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
                    self?.router.routeToContactListViewWith(currencyValue: enteredValueRaw)
                case .unauthorized:
                    message = "Saldo da conta indisponivel para transferencia"
                case .zero:
                    message = "Digite o valor que deseja transferir"
            }
            self?.alertView.showMessage(viewModel: AlertViewModel(title: "", message: message))
        }
    }
}
