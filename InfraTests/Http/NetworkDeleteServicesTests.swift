import XCTest
import Infra
import Data

class NetworkDeleteServicesTests: XCTestCase {
    func test_delete_should_make_request_with_valid_url_and_method() {
        let url = makeUrl()
        testRequestFor(url: url) { (request) in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("DELETE", request.httpMethod)
        }
    }
    
    //error cases
    func test_delete_should_completes_with_error_when_request_completes_with_non_200() {
        expectResult(.failure(.badRequest), when: (response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.badRequest), when: (response: makeHttpResponse(statusCode: 450), error: nil))
        expectResult(.failure(.badRequest), when: (response: makeHttpResponse(statusCode: 499), error: nil))
        expectResult(.failure(.serverError), when: (response: makeHttpResponse(statusCode: 500), error: nil))
        expectResult(.failure(.serverError), when: (response: makeHttpResponse(statusCode: 550), error: nil))
        expectResult(.failure(.serverError), when: (response: makeHttpResponse(statusCode: 599), error: nil))
        expectResult(.failure(.noConnectivity), when: (response: makeHttpResponse(statusCode: 600), error: nil))
        expectResult(.failure(.noConnectivity), when: (response: makeHttpResponse(statusCode: 650), error: nil))
        expectResult(.failure(.noConnectivity), when: (response: makeHttpResponse(statusCode: 700), error: nil))
        expectResult(.failure(.unauthorized), when: (response: makeHttpResponse(statusCode: 401), error: nil))
        expectResult(.failure(.forbidden), when: (response: makeHttpResponse(statusCode: 403), error: nil))
    }
    
    //success case
    func test_delete_should_completes_with_success_when_request_completes_with_200() {
        expectResult(.success(true), when: (response: makeHttpResponse(statusCode: 200), error: nil))
    }
}

extension NetworkDeleteServicesTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> RemoteDeleteService {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = RemoteDeleteService(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor(url: URL = makeUrl(), action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "waiting")
        sut.delete(with: url, completion: { _ in exp.fulfill() })
        var request: URLRequest?
        UrlProtocolStub.observerRequest { request = $0 }
        wait(for: [exp], timeout: 1)
        action(request!)
    }
    
    func expectResult(url: URL = makeUrl(), _ expectedResult: Result<Bool, HttpError>, when stub: (response: HTTPURLResponse?, error: Error?), file: StaticString = #filePath, line: UInt = #line) {
        let sut = makeSut()
        UrlProtocolStub.simulate(data: nil, response: stub.response, error: stub.error)
        let exp = expectation(description: "waiting")
        sut.delete(with: url) { receivedResult in
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
