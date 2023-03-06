import XCTest
import Presentation
@testable import UI

class LoginViewControllerTest: XCTestCase {
    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().loginScreen?.loadingIndicator.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_loginButton_should_call_login_on_tap() {
        var loginRequest: LoginRequest?
        let sut = makeSut(loginSpy: { loginRequest = $0 })
        sut.loginScreen?.loginButton.simulateTap()
        let email = sut.loginScreen?.emailTextField.text
        let password = sut.loginScreen?.passwordTextField.text
        XCTAssertEqual(loginRequest, LoginRequest(email: email, password: password))
    }
}

extension LoginViewControllerTest {
    func makeSut(loginSpy: ((LoginRequest) -> Void)? = nil) -> LoginViewController {
        let sut = LoginViewController()
        sut.login = loginSpy
        sut.loadViewIfNeeded()
        return sut
    }
}
