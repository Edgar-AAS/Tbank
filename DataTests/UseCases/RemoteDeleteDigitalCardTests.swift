import XCTest
import Domain
import Data

class RemoteDeleteDigitalCardTests: XCTestCase {
    func test_fetch_should_call_httpGetClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpGetClientSpy) = makeSut()
        sut.deleteCardWith(url: url, completion: {_ in })
        XCTAssertEqual(httpGetClientSpy.urls, [url])
    }
    
    func test_delete_should_completes_with_unexpected_if_httpDeleteClient_completes_with_noConnectvity() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithError(.noConnectivity)
        }
    }
    
    func test_delete_should_completes_with_success_if_httpDeleteClient_completes_with_success() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .success(true), when: {
            httpClientSpy.completeWithSuccess()
        })
    }
    
    func test_delete_should_complete_with_error_if_httpDeleteClient_completes_with_noConnectivity() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithError(.noConnectivity)
        }
    }
    
    func test_delete_should_not_complete_if_sut_has_been_deallocated() {
        let httpDeleteClientSpy = HttpDeleteClientSpy()
        var sut: RemoteDeleteDigitalCard? = RemoteDeleteDigitalCard(httpClient: httpDeleteClientSpy)
        var result: DeleteDigitalCard.Result?
        sut?.deleteCardWith(url: makeUrl(), completion: { result = $0 } )
        sut = nil
        httpDeleteClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
    }
    
    func makeSut(url: URL = URL(string: "any_url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteDeleteDigitalCard, httpClientSpy: HttpDeleteClientSpy) {
        let httpClientSpy = HttpDeleteClientSpy()
        let sut = RemoteDeleteDigitalCard(httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteDeleteDigitalCard, completeWith expectedResult: RemoteDeleteDigitalCard.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        let url = makeUrl()
        sut.deleteCardWith(url: url, completion: { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedAccount), .success(let receivedAccount)): XCTAssertEqual(expectedAccount, receivedAccount, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) receive \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        })
        action()
        wait(for: [exp], timeout: 1)
    }
}
