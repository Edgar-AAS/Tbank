import Foundation
import Infra
import Data

func makeNetworkGetClient(cacheManager: CacheType?) -> RemoteGetService {
    return RemoteGetService(cacheManager: cacheManager)
}
