import XCTest
import Data
import Infra

//talvez precise ser assincrono
class CacheManagerTests: XCTestCase {
    func test_sut_implements_cacheType() {
        let sut = makeSut()
        XCTAssertNotNil(sut as CacheType)
    }
    
    func test_ensure_cacheManager_creates_correct_object() {
        let sut = makeSut()
        let testObject = TestObject(any: "Any")
        sut.createCachedObject(testObject, forKey: "anyObject")
        let receivedObject = sut.cache.object(forKey: "anyObject") as! TestObject
        XCTAssertEqual(testObject, receivedObject)
    }
    
    func test_cacheManager_creates_object_with_correct_key() {
        let sut = makeSut()
        let testObject = TestObject(any: "Any")
        sut.createCachedObject(testObject, forKey: "anyObject")
        let receivedObject = sut.cache.object(forKey: "wrongKey") as? TestObject
        XCTAssertNil(receivedObject)
    }
    
    func test_cacheManager_should_remove_objects() {
        let sut = makeSut()
        let obj1 = TestObject(any: "Any1")
        let obj2 = TestObject(any: "Any2")
        
        sut.createCachedObject(obj1, forKey: "anyObject1")
        sut.createCachedObject(obj2, forKey: "anyObject2")
        
        let receivedObject1 = sut.cache.object(forKey: "anyObject1") as? TestObject
        let receivedObject2 = sut.cache.object(forKey: "anyObject2") as? TestObject
        
        XCTAssertNotNil(receivedObject1)
        XCTAssertNotNil(receivedObject2)
        
        sut.removeCachedObject(forKey: "anyObject2")
    
        XCTAssertNotNil(sut.cache.object(forKey: "anyObject1"))
        XCTAssertNil(sut.cache.object(forKey: "anyObject2"))
    }
    
    func test_cacheManager_should_remove_all_cached_objects() {
        let sut = makeSut()
        let obj1 = TestObject(any: "Any1")
        let obj2 = TestObject(any: "Any2")
        let obj3 = TestObject(any: "Any3")
        
        sut.createCachedObject(obj1, forKey: "anyObject1")
        sut.createCachedObject(obj2, forKey: "anyObject2")
        sut.createCachedObject(obj3, forKey: "anyObject3")
    
        sut.removeAllCachedObjects()

        XCTAssertNil(sut.cache.object(forKey: "anyObject1"))
        XCTAssertNil(sut.cache.object(forKey: "anyObject2"))
        XCTAssertNil(sut.cache.object(forKey: "anyObject3"))
    }
    
    
    func test_cacheManager_should_remove_multiple_cached_objects() {
        let sut = makeSut()
        let obj1 = TestObject(any: "Any1")
        let obj2 = TestObject(any: "Any2")
        let obj3 = TestObject(any: "Any3")
        
        //create
        sut.createCachedObject(obj1, forKey: "anyObject1")
        sut.createCachedObject(obj2, forKey: "anyObject2")
        sut.createCachedObject(obj3, forKey: "anyObject3")
        
        //read
        XCTAssertNotNil(sut.cache.object(forKey: "anyObject1"))
        XCTAssertNotNil(sut.cache.object(forKey: "anyObject2"))
        XCTAssertNotNil(sut.cache.object(forKey: "anyObject3"))
        
        //remove
        sut.removeCachedObject(forKey: "anyObject1")
        sut.removeCachedObject(forKey: "anyObject2")
        sut.removeCachedObject(forKey: "anyObject3")
        
        XCTAssertNil(sut.cache.object(forKey: "anyObject1"))
        XCTAssertNil(sut.cache.object(forKey: "anyObject2"))
        XCTAssertNil(sut.cache.object(forKey: "anyObject3"))
    }
    
    //testanto limite em cache
    //testando se ao exceder o limite o objeto mais antigo é removido do cache
    func test_cacheManager_should_limit_cache_size() {
        let sut = makeSut()
        sut.cache.countLimit = 3
        
        let obj1 = TestObject(any: "Any1")
        let obj2 = TestObject(any: "Any2")
        let obj3 = TestObject(any: "Any3")
        
        sut.createCachedObject(obj1, forKey: "anyObject1")
        sut.createCachedObject(obj2, forKey: "anyObject2")
        sut.createCachedObject(obj3, forKey: "anyObject3")
        
        XCTAssertNotNil(sut.cache.object(forKey: "anyObject1"))
        XCTAssertNotNil(sut.cache.object(forKey: "anyObject2"))
        XCTAssertNotNil(sut.cache.object(forKey: "anyObject3"))
        
        let obj4 = TestObject(any: "Any4")
        sut.createCachedObject(obj4, forKey: "anyObject4")
        
        XCTAssertNil(sut.cache.object(forKey: "anyObject1"))
        XCTAssertNotNil(sut.cache.object(forKey: "anyObject2"))
        XCTAssertNotNil(sut.cache.object(forKey: "anyObject3"))
        XCTAssertNotNil(sut.cache.object(forKey: "anyObject4"))
    }
}

extension CacheManagerTests {
    func makeSut() -> CacheManager {
        let sut = CacheManager()
        return sut
    }
}

public class TestObject: Equatable {
    public let any: String
    
    public init(any: String) {
        self.any = any
    }
    
    public static func == (lhs: TestObject, rhs: TestObject) -> Bool {
        return lhs.any == rhs.any
    }
}

