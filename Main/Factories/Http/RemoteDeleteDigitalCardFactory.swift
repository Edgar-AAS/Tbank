import Foundation
import Data
import Domain

func makeRemoteDeleteDigitalCard(httpClient: HttpDeleteClient) -> DeleteDigitalCard {
    let remoteDeleteCard = RemoteDeleteDigitalCard(httpClient: httpClient)
    return MainQueueDispatchDecorator(remoteDeleteCard)
}
