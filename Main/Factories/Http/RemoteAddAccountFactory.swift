import Foundation
import Domain
import Data

func makeRemoteAddAccount(httpPostClient: HttpPostClient) -> AddAccount {
    let url = URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/users")!
    let remoteAddAccount = RemoteAddAccount(url: url, httpClient: httpPostClient)
    return MainQueueDispatchDecorator(remoteAddAccount)
}
