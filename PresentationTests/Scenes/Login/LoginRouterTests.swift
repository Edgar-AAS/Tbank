import XCTest
@testable import Presentation

class LoginRouterTests: XCTestCase {
    func test_router_should_implements_presenterToRouterHomeProtocol() {
        let (sut, _) = makeSut()
        XCTAssertTrue(sut is PresenterToRouterLoginProtocol)
    }
    
    func test_gotToHome_should_call_correct_controller() {
        let (sut, navigation) = makeSut()
        sut.goToHome()
        XCTAssertEqual(navigation.viewControllers.count, 1)
        XCTAssertTrue(navigation.viewControllers[0] is HomeController)
    }
    
    func test_sut_is_initizalized_with_the_correct_controller() {
        let (sut, nav) = makeSut()
        sut.goToHome()
        XCTAssertEqual(nav.viewControllers.count, 1)
        XCTAssertTrue(nav.viewControllers[0] is HomeController)
    }
}

extension LoginRouterTests {
    func makeSut() -> (sut: LoginRouter, nav: NavigationController) {
        let navigation = NavigationController()
        let homeFactory = HomeControllerFactory()
        let sut = LoginRouter(navigationController: navigation, homeFactory: homeFactory.makeHome)
        checkMemoryLeak(for: sut)
        return (sut, navigation)
    }
}

extension LoginRouterTests {
    class HomeControllerFactory {
        func makeHome() -> HomeController {
            return HomeController()
        }
    }
}
