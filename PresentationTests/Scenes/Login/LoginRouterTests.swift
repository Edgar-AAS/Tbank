import XCTest
@testable import Presentation

class LoginRouterTests: XCTestCase {
    func test_router_should_implements_presenterToRouterHomeProtocol() {
        let (sut, _) = makeSut()
        XCTAssertTrue(sut is PresenterToRouterLoginProtocol)
    }
    
    func test_sut_should_call_correct_controller() {
        let (sut, navigation) = makeSut()
        sut.goToHome()
        XCTAssertEqual(navigation.viewControllers.count, 1)
        XCTAssertTrue(navigation.viewControllers[0] is HomeController)
    }
    
    func test_sut_is_initizalized_with_the_correct_controller() {
        let destinationVC = HomeController()
        let (sut, _) = makeSut(with: destinationVC)
        XCTAssertEqual(sut.destinationController, destinationVC)
    }
}

extension LoginRouterTests {
    func makeSut(with destinationVC: UIViewController = HomeController()) -> (sut: LoginRouter, nav: NavigationController) {
        let nav = NavigationController()
        let sut = LoginRouter(navigationController: nav, destinationController: destinationVC)
        checkMemoryLeak(for: sut)
        return (sut, nav)
    }
}
