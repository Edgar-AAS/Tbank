import Foundation
import Presentation

public let cardConfigurationFactory: () -> CardConfigurationViewController = {
    let httpPostClient = makeNetworkPostClient()
    let remoteAddDigitalCard = makeRemoteAddDigitalCard(httpClient: httpPostClient)
    let controller = makeCardConfigurationController(addCard: remoteAddDigitalCard)
    return controller
}
