import Foundation
import Data
import Infra
import Domain

//botar esse cara dentro de um Decorator quando for preciso
func makeRemoteFetchPersonDataFactory(httpGetClient: HttpGetClient) -> FetchPersonDataResources {
    let remoteFetchPersonData = RemoteFetchPersonData(url: URL(string: "https://any.url.com")!, httpGetClient: httpGetClient)
    return remoteFetchPersonData
}
