import XCTest
@testable import Presentation

class WelcomeViewControllerTests: XCTestCase {
    func test_loginButton_calls_login_on_tap() {
        let (sut, buttonSpy) = makeSut()
        sut.customView?.loginButton.simulateTap()
        XCTAssertEqual(buttonSpy.count, 1)
    }
    
    func test_registerButton_calls_register_on_tap() {
        let (sut, buttonSpy) = makeSut()
        sut.customView?.registerButton.simulateTap()
        XCTAssertEqual(buttonSpy.count, 1)
    }
}

extension WelcomeViewControllerTests {
    func makeSut() -> (sut: WelcomeViewController, buttonSpy: ButtonSpy) {
        let buttonSpy = ButtonSpy()
        let sut = WelcomeViewController()
        sut.goToLoginScreen = buttonSpy.onClick
        sut.goTosignUpScreen = buttonSpy.onClick
        sut.loadViewIfNeeded()
        checkMemoryLeak(for: sut)
        return (sut, buttonSpy)
    }
    
    class ButtonSpy {
        var count = 0
        
        func onClick() {
            count += 1
        }
    }
}
