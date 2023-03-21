import Foundation
import Infra
import Data

func makeNetworkGetClient() -> RemoteGetService {
    return RemoteGetService(cacheManager: FetchUserDataInCache(cacheManager: CacheManager()))
}
