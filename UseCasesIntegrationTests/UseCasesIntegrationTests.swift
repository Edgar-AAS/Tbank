import XCTest
import Data
import Infra
import Domain

class UseCasesIntegrationTests: XCTestCase {
    func test_add_account() {
        let networkPostService = RemotePostService()
        let url = URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/users")!
        let sut = RemoteAddAccount(url: url, httpClient: networkPostService)
        let addAccountModel = AddAccountModel(name: "Pocoio", email: "\(UUID().uuidString)@gmail.com", password: "123123", passwordConfirmation: "123123")
        let exp = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .success(let account):
                XCTAssertNotNil(account.accessToken)
            case .failure: XCTFail("Expect success got \(result) instead")
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 5)
        
        let exp2 = expectation(description: "waiting")
        sut.add(addAccountModel: addAccountModel) { result in
            switch result {
            case .failure(let error) where error == .emailInUse:
                XCTAssertNotNil(error)
            default:
                XCTFail("Expect failure got \(result) instead")
            }
            exp2.fulfill()
        }
        wait(for: [exp2], timeout: 5)
    }
}
