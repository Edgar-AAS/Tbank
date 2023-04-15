import Foundation
import Data
import Domain

func makeRemoteFetchCards(httpClient: HttpGetClient) -> FetchUserCards {
    let remoteFetchCards = RemoteFetchCards(url: URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/cards")!, httpGetClient: httpClient)
    return MainQueueDispatchDecorator(remoteFetchCards)
}
