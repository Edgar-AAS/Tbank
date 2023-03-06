import Foundation
import Data
import Domain

func makeRemoteAuthentication(httpClient: HttpGetClient) -> Authentication {
    let remoteAuthentication = RemoteAuthentication(url: URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/logins")!, httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAuthentication)
}
