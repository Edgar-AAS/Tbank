import Foundation
import Data
import Infra
import Domain

func makeRemoteFetchAccountBalance(httpClient: HttpGetClient) -> FetchBalance {
    let url = URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/user")!
    let fetchAccountBalance = RemoteFetchAccountBalance(httpClient: httpClient, url: url)
    return MainQueueDispatchDecorator(fetchAccountBalance)
}
