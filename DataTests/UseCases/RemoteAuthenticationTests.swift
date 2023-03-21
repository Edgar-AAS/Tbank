import XCTest
import Data
import Domain

//falta o caso de dados invalidos
class RemoteAuthenticationTests: XCTestCase {
    func test_auth_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.auth(authenticationModel: makeAuthenticationModel(), completion: { _ in })
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    func test_auth_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let addAccountModel = makeAuthenticationModel()
        sut.auth(authenticationModel: addAccountModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
        
    //callbacks
    func test_auth_should_complete_with_error_if_httpClient_fails() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithError(.noConnectivity)
        }
    }
    
    func test_auth_should_complete_with_data_if_client_complete_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        let accountModel = makeAccountModel()
        expect(sut, completeWith: .success(accountModel), when: {
            let data = try! JSONEncoder().encode(accountModel)
            httpClientSpy.completeWithData(data)
        })
    }
    
    func test_auth_should_complete_with_error_if_httpClient_completes_with_invalid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected)) {
            httpClientSpy.completeWithData(makeInvalidData())
        }
    }
    
    func test_auth_should_complete_with_error_expired_session_if_httpClient_completes_with_unauthorized() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.sessionExpired)) {
            httpClientSpy.completeWithError(.unauthorized)
        }
    }
    
    func test_auth_should_not_complete_if_sut_has_been_deallocated() {
        let httpClientSpy = HttpPostClientSpy()
        var sut: RemoteAuthentication? = RemoteAuthentication(url: makeUrl(), httpClient: httpClientSpy)
        var result: Authentication.Result?
        sut?.auth(authenticationModel: makeAuthenticationModel()) { result = $0 }
        sut = nil
        httpClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
    }
}

extension RemoteAuthenticationTests {
    func makeSut(url: URL = URL(string: "any_url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAuthentication, httpClientSpy: HttpPostClientSpy) {
        let url = URL(string: "any_url.com")!
        let httpClientSpy = HttpPostClientSpy()
        let sut = RemoteAuthentication(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteAuthentication, completeWith expectedResult: Authentication.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.auth(authenticationModel: makeAuthenticationModel()) { receivedResult in
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
