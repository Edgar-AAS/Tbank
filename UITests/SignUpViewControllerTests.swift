import XCTest
import Presentation
@testable import UI

class SignUpViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().loadingIndicator.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_saveButton_should_call_signUp_on_tap() {
        var signUpRequest: SignUpRequest?
        let sut = makeSut(signUpSpy: { signUpRequest = $0})
        sut.saveButton.simulateTap()
        let name = sut.nameTextField.text
        let email = sut.emailTextField.text
        let password = sut.passwordTextField.text
        let passwordConfirmation = sut.passwordConfirmationTextField.text
        XCTAssertEqual(signUpRequest, SignUpRequest(name: name, email: email, password: password, passwordConfirmation: passwordConfirmation))
    }
}

extension SignUpViewControllerTests {
    func makeSut(signUpSpy: ((SignUpRequest) -> Void)? = nil) -> SignUpViewController {
        let sut = SignUpViewController()
        sut.signUp = signUpSpy
        sut.loadViewIfNeeded()
        return sut
    }
}
