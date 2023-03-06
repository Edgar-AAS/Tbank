import XCTest
import Presentation
@testable import UI

class SignUpViewControllerTests: XCTestCase {
    func test_loading_is_hidden_on_start() {
        XCTAssertEqual(makeSut().signUpScreen?.loadingIndicator.isAnimating, false)
    }
    
    func test_sut_implements_loadingView() {
        XCTAssertNotNil(makeSut() as LoadingView)
    }
    
    func test_sut_implements_alertView() {
        XCTAssertNotNil(makeSut() as AlertView)
    }
    
    func test_sut_should_call_textFields_with_correct_tags() {
        let sut = makeSut()
        XCTAssertEqual(sut.signUpScreen?.nameTextField.tag, 1)
        XCTAssertEqual(sut.signUpScreen?.emailTextField.tag, 2)
        XCTAssertEqual(sut.signUpScreen?.passwordTextField.tag, 3)
        XCTAssertEqual(sut.signUpScreen?.passwordConfirmationTextField.tag, 4)
    }
    
    func test_saveButton_should_call_signUp_on_tap() {
        var signUpRequest: SignUpRequest?
        let sut = makeSut(signUpSpy: { signUpRequest = $0})
        sut.signUpScreen?.saveButton.simulateTap()
        let name = sut.signUpScreen?.nameTextField.text
        let email = sut.signUpScreen?.emailTextField.text
        let password = sut.signUpScreen?.passwordTextField.text
        let passwordConfirmation = sut.signUpScreen?.passwordConfirmationTextField.text
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
