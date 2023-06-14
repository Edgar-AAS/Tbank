import Foundation
import Data
import Infra
import Domain

func makeValidatePixTransfer(httpClient: HttpGetClient) -> ValidateBalance {
    let url = URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/user")!
    let validatePixTransfer = ValidatePixTransferService(httpClient: httpClient, url: url)
    return MainQueueDispatchDecorator(validatePixTransfer)
}
