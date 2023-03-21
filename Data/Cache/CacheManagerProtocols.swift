import Foundation

public protocol CreateCachedObjectProtocol: AnyObject {
    func createCachedObject(_ object: AnyObject, forKey key: String)
}

public protocol GetCachedObjectProtocol: AnyObject {
    func getCachedObject(forKey key: String) -> AnyObject?
}

public protocol RemoveCachedObjectProtocol: AnyObject {
    func removeCachedObject(forKey key: String)
}

public protocol RemoveAllCachedObjectProtocol: AnyObject {
    func removeAllCachedObjects()
}
