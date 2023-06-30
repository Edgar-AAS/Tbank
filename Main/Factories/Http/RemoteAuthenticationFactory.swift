import Foundation
import Data
import Domain

func makeRemoteAuthentication(httpClient: HttpPostClient) -> Authentication {
    let remoteAuthentication = RemoteAuthentication(url: URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/login")!, httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAuthentication)
}
