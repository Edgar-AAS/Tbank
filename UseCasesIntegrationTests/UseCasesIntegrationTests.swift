import XCTest
import Data
import Infra
import Domain

class UseCasesIntegrationTests: XCTestCase {
    func test_add_account() {
        let networkPostService = NetworkPostService()
        let sut = RemoteAddAccount(url: URL(string: "https://63e255d8109336b6cb054df8.mockapi.io/api/v1/users")!, httpClient: networkPostService)
        let addAccountModel = AddAccountModel(name: "Pocoio", email: "edgar_bananao@gmail.com", password: "123123", passwordConfirmation: "123123")
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
    }
}
