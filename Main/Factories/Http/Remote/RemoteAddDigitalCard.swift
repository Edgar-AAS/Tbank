import Foundation
import Data
import Domain

func makeRemoteAddDigitalCard(httpClient: HttpPostClient) -> AddCard {
    let url = URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/cards")!
    let remoteAddDigitalCard = RemoteAddDigitalCard(url: url, httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteAddDigitalCard)
}
