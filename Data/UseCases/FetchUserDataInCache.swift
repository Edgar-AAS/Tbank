import Foundation
import Domain

public typealias CacheType = CreateCachedObjectProtocol & GetCachedObjectProtocol & RemoveCachedObjectProtocol & RemoveAllCachedObjectProtocol

public final class FetchUserDataInCache: CacheType  {
    private let cacheManager: CacheType
    
    public init(cacheManager: CacheType) {
        self.cacheManager = cacheManager
    }
    
    public func createCachedObject(_ object: AnyObject, forKey key: String) {
        cacheManager.createCachedObject(object, forKey: key)
    }
    
    public func getCachedObject(forKey key: String) -> AnyObject? {
        cacheManager.getCachedObject(forKey: key)
    }
    
    public func removeCachedObject(forKey key: String) {
        cacheManager.removeCachedObject(forKey: key)
    }
    
    public func removeAllCachedObjects() {
        cacheManager.removeAllCachedObjects()
    }
}
