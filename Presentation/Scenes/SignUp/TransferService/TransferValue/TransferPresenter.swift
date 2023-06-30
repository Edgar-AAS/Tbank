import Foundation
import Domain

public final class TransferPresenter {
    private let validateBalance: ValidateBalance
    private let alertView: AlertView
    private let fetchAvaiableBalance: FetchBalance
    private let updateBalanceView: UpdateBalanceView
    private let router: TransferRouterLogic
    
    public init(validateBalance: ValidateBalance,
                alertView: AlertView,
                fetchAvaiableBalance: FetchBalance,
                updateBalanceView: UpdateBalanceView,
                router: TransferRouterLogic
    ) {
        self.validateBalance = validateBalance
        self.fetchAvaiableBalance = fetchAvaiableBalance
        self.alertView = alertView
        self.updateBalanceView = updateBalanceView
        self.router = router
    }
}

extension TransferPresenter: ViewToPresenterTransferProtocol {
    public func fetchBalance() {
        fetchAvaiableBalance.fetch() { [weak self] balance in
            guard self != nil else { return }
            self?.updateBalanceView.update(balance: balance.currencyWith(symbol: .brazilianReal))
        }
    }
    
    public func validateBalance(_ enteredValue: String) {
        if enteredValue == String().currencyInputFormatting() {
            alertView.showMessage(viewModel: AlertViewModel(title: "", message: "Digite o valor que deseja transferir"))
        } else {
            let balance = enteredValue.removeCurrencyInputFormatting()
            validateBalance.validate(enteredValue: balance) { [weak self] validationType in
                guard self != nil else { return }
                switch validationType {
                    case .authorized:
                        self?.router.routeToContactListViewWith(currencyValue: balance)
                    case .unauthorized:
                        self?.alertView.showMessage(viewModel: AlertViewModel(title: "", message: "Saldo da conta indisponivel para transferência"))
                }
            }
        }
    }
}
