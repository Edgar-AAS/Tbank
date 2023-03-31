import Foundation
import Data
import Infra
import Domain

//botar esse cara dentro de um Decorator quando for preciso
func makeRemoteFetchUserDataFactory(httpGetClient: HttpGetClient) -> FetchUserDataResources {
    let remoteFetchUserData = RemoteFetchUserData(url: URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/user")!, httpGetClient: httpGetClient)
    return MainQueueDispatchDecorator(remoteFetchUserData)
}
