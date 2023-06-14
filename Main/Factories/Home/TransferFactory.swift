import Foundation
import Presentation
import Infra

public let transferFactory: () -> TransferViewController = {
    let httpClient = makeNetworkGetClient()
    let validatePixTransferService = makeValidatePixTransfer(httpClient: httpClient)
    let updateBalance = makeRemoteFetchAccountBalance(httpClient: httpClient)
    let controller = makeTransferControllerFactory(validatePixTransferService: validatePixTransferService, updateBalance: updateBalance)
    return controller
}
