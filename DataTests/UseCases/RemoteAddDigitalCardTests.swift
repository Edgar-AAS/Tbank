import XCTest
import Domain
import Data

class RemoteAddDigitalCardTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        let url = makeUrl()
        let (sut, httpClientSpy) = makeSut(url: url)
        sut.add(cardModel: makeDigitalCardModel()) { _ in }
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    //preciso chamar meu add com dados validos
    func test_add_should_call_httpClient_with_correct_data() {
        let (sut, httpClientSpy) = makeSut()
        let digitalCardModel = makeDigitalCardModel()
        sut.add(cardModel: digitalCardModel) { _ in }
        XCTAssertEqual(httpClientSpy.data, digitalCardModel.toData())
    }
    
    //callbacks
    func test_add_should_complete_with_error_if_client_fails() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .failure(.unexpected), when: {
            httpClientSpy.completeWithError(.noConnectivity)
        })
    }
    
    func test_add_should_complete_with_data_if_client_complete_with_valid_data() {
        let (sut, httpClientSpy) = makeSut()
        expect(sut, completeWith: .success(true), when: {
            httpClientSpy.completeWithData(makeValidData())
        })
    }
    
    func test_add_should_not_complete_if_sut_has_been_deallocated() {
        let httpClientSpy = HttpPostClientSpy()
        var sut: RemoteAddDigitalCard? = RemoteAddDigitalCard(url: makeUrl(), httpClient: httpClientSpy)
        var result: RemoteAddDigitalCard.Result?
        sut?.add(cardModel: makeDigitalCardModel()) { result = $0 }
        sut = nil
        httpClientSpy.completeWithError(.noConnectivity)
        XCTAssertNil(result)
    }
}

extension RemoteAddDigitalCardTests {
    func makeSut(url: URL = URL(string: "any_url.com")!, file: StaticString = #filePath, line: UInt = #line) -> (sut: RemoteAddDigitalCard, httpClientSpy: HttpPostClientSpy) {
        let url = URL(string: "any_url.com")!
        let httpClientSpy = HttpPostClientSpy()
        let sut = RemoteAddDigitalCard(url: url, httpClient: httpClientSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: httpClientSpy, file: file, line: line)
        return (sut, httpClientSpy)
    }
    
    func expect(_ sut: RemoteAddDigitalCard, completeWith expectedResult: AddCard.Result, when action: () -> Void, file: StaticString = #filePath, line: UInt = #line) {
        let exp = expectation(description: "waiting")
        sut.add(cardModel: makeDigitalCardModel()) { receivedResult in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)): XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedModel), .success(let receivedModel)): XCTAssertEqual(expectedModel, receivedModel, file: file, line: line)
            default: XCTFail("Expected \(expectedResult) receive \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        wait(for: [exp], timeout: 1)
    }
}
