import Foundation
import Data
import Domain

func makeRemoteDeleteDigitalCard(httpClient: HttpDeleteClient) -> DeleteDigitalCard {
    let remoteDeleteCard = RemoteDeleteDigitalCard(url: URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/user/1/cards")!, httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteDeleteCard)
}
