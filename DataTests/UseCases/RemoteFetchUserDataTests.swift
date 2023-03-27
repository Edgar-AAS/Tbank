import XCTest
import Domain
import Data

class RemoteFetchUserDataTests: XCTestCase {
    func test_fetch_should_call_httpGetClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpGetClientSpy) = makeSut()
        sut.fetch(completion: { _ in })
        XCTAssertEqual(httpGetClientSpy.urls, [url])
    }
    
    func test_fetch_should_completes_with_unexpected_if_httpGetClient_completes_with_noConnectvity() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithError(.noConnectivity)
        }
    }
    
    func test_fetch_should_completes_with_data_if_httpGetClient_completes_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let userModel = makeUserModel()
        expect(sut, completeWith: .success(userModel), when: {
            let data = try! JSONEncoder().encode(userModel)
            httpClientSpy.completeWithData(data)
        })
    }
    
    func test_fetch_should_complete_with_error_if_httpGetClient_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithData(makeInvalidData())
        }
    }
    
    func test_fetch_should_not_complete_if_sut_has_been_deallocated() {
        let httpClientSpy = HttpGetClientSpy()
        var sut: RemoteFetchUserData? = RemoteFetchUserData(url: makeUrl(), httpGetClient: httpClientSpy)
        var result: FetchUserDataResources.Result?
        sut?.fetch(completion: { result = $0 })
        sut = nil
        httpClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
    }
    
    func test_fetch_should_call_httpClient_with_correct_cacheKey() {
        let objectCacheKey = makeObjectCacheKey()
        let (sut, httpClientSpy) = makeSut(objectCacheKey: objectCacheKey)
        sut.fetch() { _ in }
        XCTAssertEqual(httpClientSpy.objectCacheKeyReceived, objectCacheKey)
    }
    
    func makeSut(url: URL = URL(string: "any_url.com")!, objectCacheKey: String? = nil, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteFetchUserData, httpClientSpy: HttpGetClientSpy) {
        let url = makeUrl()
        let objectCacheKey = makeObjectCacheKey()
        let httpClientSpy = HttpGetClientSpy()
        let sut = RemoteFetchUserData(url: url, httpGetClient: httpClientSpy, objectCacheKey: objectCacheKey)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line) //http client retendo
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteFetchUserData, completeWith expectedResult: RemoteFetchUserData.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.fetch() { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) receive \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
