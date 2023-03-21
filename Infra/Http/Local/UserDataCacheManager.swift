import Foundation

class UserDataCacheManager {
    private let cache = NSCache<NSString, AnyObject>()
    
    private init() {
        cache.countLimit = 100 // limite de objetos em cache
    }
    
    func setObject(_ object: AnyObject, forKey key: String) {
        cache.setObject(object, forKey: key as NSString)
    }
    
    func object(forKey key: String) -> AnyObject? {
        return cache.object(forKey: key as NSString)
    }
    
    func removeObject(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func removeAllObjects() {
        cache.removeAllObjects()
    }
}
