import Foundation
import Infra
import Data

func makeRemoteDeleteService() -> HttpDeleteClient {
    let remoteDeleteService = RemoteDeleteService()
    return remoteDeleteService
}
