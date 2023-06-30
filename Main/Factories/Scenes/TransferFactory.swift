import Foundation
import Presentation
import Infra

public let transferFactory: () -> TransferViewController = {
    let httpClient = makeNetworkGetClient()
    let validatePixTransferService = makeValidatePixTransfer(httpClient: httpClient)
    let fetchBalance = makeRemoteFetchAccountBalance(httpClient: httpClient)
    let controller = makeTransferControllerFactory(validatePixTransferService: validatePixTransferService, fetchBalance: fetchBalance)
    return controller
}
