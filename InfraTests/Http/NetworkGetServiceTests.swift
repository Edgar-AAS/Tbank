import XCTest
import Infra
import Data

class NetworkGetServiceTests: XCTestCase {
    //1) testar url
    func test_get_should_make_request_with_valid_url_and_method() {
        let url = makeUrl()
        testRequestFor(url: url) { (request) in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("GET", request.httpMethod)
        }
    }
    
    func test_get_should_completes_with_error_when_request_completes_with_error() {
        expectResult(.failure(.noConnectivity), when: (data: nil, response: nil, error: makeError()))
    }
    
    func test_get_should_completes_with_data_when_request_completes_with_non_200() {
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 450), error: nil))
        expectResult(.failure(.badRequest), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 499), error: nil))
        expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
        expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 550), error: nil))
        expectResult(.failure(.serverError), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 599), error: nil))
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 600), error: nil))
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 650), error: nil))
        expectResult(.failure(.noConnectivity), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 700), error: nil))
        expectResult(.failure(.unauthorized), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectResult(.failure(.forbidden), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
    }
    
    func test_get_should_completes_with_data_when_request_completes_with_200() {
        expectResult(.success(makeValidData()), when: (data: makeValidData(), response: makeHttpResponse(), error: nil))
    }
    
    func test_get_should_completes_with_no_data_when_request_completes_with_204() {
        expectResult(.success(nil), when: (data: nil, response: makeHttpResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeEmptyData(), response: makeHttpResponse(statusCode: 204), error: nil))
        expectResult(.success(nil), when: (data: makeValidData(), response: makeHttpResponse(statusCode: 204), error: nil))
    }
    
    //se minha request completar com sucessso e tiver uma chave para o cache deve ser criado um objeto em cache
    //caso contrario o cache e nulo
    //verificar se a chave forne
    
    func test_get_dont_creates_object_in_cache_if_objectCacheKey_is_nil() {
        let cacheSpy = CacheManagerSpy()
        let sut = makeSut(cacheManagerSpy: cacheSpy)
        UrlProtocolStub.simulate(data: makeValidData(), response: makeHttpResponse(), error: nil)
        let exp1 = expectation(description: "waiting")
        sut.get(to: makeUrl(), objectCacheKey: nil, completion: { result in
            switch result {
            case .success:
                XCTAssertEqual(cacheSpy.objectCreationKey, nil)
                XCTAssertTrue(cacheSpy.createdObjects.isEmpty)
                exp1.fulfill()
            case .failure: XCTFail()
            }
        })
        wait(for: [exp1], timeout: 1)
    }
    
    func test_get_creates_and_read_cache_object_with_same_key() {
        let cacheSpy = CacheManagerSpy()
        let sut = makeSut(cacheManagerSpy: cacheSpy)
        
        UrlProtocolStub.simulate(data: makeValidData(), response: makeHttpResponse(), error: nil)
        let exp1 = expectation(description: "waiting")
        sut.get(to: makeUrl(), objectCacheKey: "anyCacheKey", completion: { result in
            switch result {
            case .success:
                XCTAssertEqual(cacheSpy.objectCreationKey, "anyCacheKey")
                XCTAssertNotNil(cacheSpy.createdObjects)
                exp1.fulfill()
            case .failure: XCTFail()
            }
        })
        wait(for: [exp1], timeout: 1)
        
        UrlProtocolStub.simulate(data: makeValidData(), response: makeHttpResponse(), error: nil)
        let exp2 = expectation(description: "waiting")
        sut.get(to: makeUrl(), objectCacheKey: "anyCacheKey", completion: { result in
            switch result {
            case .success:
                XCTAssertEqual(cacheSpy.objectRescueKey, "anyCacheKey")
                exp2.fulfill()
            case .failure: XCTFail()
            }
        })
        wait(for: [exp2], timeout: 1)
    }

    //eu faco a requisicao, depois tento fazer dnv, porem, não deve completar a requisicao, pois ja tem objeto em cache.
    //testo quantos objetos foram criados em cache
    //se haver apenas um objeto signfica que nao chamou duas vezes
}

extension NetworkGetServiceTests {
    func makeSut(cacheManagerSpy: CacheType = CacheManagerSpy(), file: StaticString = #filePath, line: UInt = #line) -> RemoteGetService {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = RemoteGetService(session: session, cacheManager: cacheManagerSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: cacheManagerSpy, file: file, line: line)
        return sut
    }
    
    func testRequestFor(url: URL = makeUrl(), action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "waiting")
        sut.get(to: url, objectCacheKey: nil) { _ in exp.fulfill() }
        var request: URLRequest?
        UrlProtocolStub.observerRequest { request = $0 }
        wait(for: [exp], timeout: 1)
        action(request!)
    }
    
    func expectResult(_ expectedResult: Result<Data?, HttpError>, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #filePath, line: UInt = #line) {
        let sut = makeSut()
        UrlProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "waiting")
        sut.get(to: makeUrl(), objectCacheKey: nil) { (receivedResult) in
            switch (expectedResult, receivedResult) {
                case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
                case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
                default: XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
