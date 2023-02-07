import XCTest
import Domain
import Data

class RemoteAddAccountTests: XCTestCase {
    func test_add_should_call_httpClient_with_correct_url() {
        let url = URL(string: "any_url.com")!
        let httpClientSpy = HttpClientSpy()
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy) //url é um detalhe especifico da implementação
        sut.add(addAccountModel: AddAccountModel(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_passwordConfirmation"))
        XCTAssertEqual(httpClientSpy.urls, [url])
    }
    
    //preciso chamar meu add com dados validos
    func test_add_should_call_httpClient_with_valid_data() {
        let url = URL(string: "any_url.com")!
        let httpClientSpy = HttpClientSpy()
        let addAccountModel = AddAccountModel(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_passwordConfirmation")
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
    
    func test_add_should_call_httpClient_w2ith_valid_data() {
        let url = URL(string: "any_url.com")!
        let httpClientSpy = HttpClientSpy()
        let addAccountModel = AddAccountModel(name: "any_name", email: "any_email", password: "any_password", passwordConfirmation: "any_passwordConfirmation")
        let sut = RemoteAddAccount(url: url, httpClient: httpClientSpy)
        sut.add(addAccountModel: addAccountModel)
        XCTAssertEqual(httpClientSpy.data, addAccountModel.toData())
    }
}
