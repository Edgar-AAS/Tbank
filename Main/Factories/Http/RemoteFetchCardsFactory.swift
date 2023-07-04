import Domain
import Data
import Foundation
import Presentation

func makeRemoteFetchCard(httpClient: HttpGetClient) -> FetchCardList {
    let fetcCardList = RemoteFetchCards(url: URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/user/1/cards")!, httpGetClient: httpClient)
    return MainQueueDispatchDecorator(fetcCardList)
}
