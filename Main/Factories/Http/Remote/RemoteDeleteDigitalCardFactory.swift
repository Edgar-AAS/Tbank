import Foundation
import Data

func makeRemoteDeleteDigitalCard(httpClient: HttpDeleteClient) -> RemoteDeleteDigitalCard {
    let remoteDeleteCard = RemoteDeleteDigitalCard(httpClient: httpClient)
    return remoteDeleteCard
}
