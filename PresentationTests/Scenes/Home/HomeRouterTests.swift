import XCTest
@testable import Presentation

class HomeRouterTests: XCTestCase {
    func test_router_should_be_initialized_with_correct_controller() {
        let homeViewController = HomeController()
        let sut = makeSut(viewController: homeViewController)
        XCTAssertEqual(sut.viewController, homeViewController)
    }
    
    func test_router_should_implements_presenterToRouterHomeProtocol() {
        let sut = makeSut()
        XCTAssertTrue(sut is PresenterToRouterHomeProtocol)
    }
}

extension HomeRouterTests {
    func makeSut(viewController: UIViewController = HomeController(), file: StaticString = #filePath, line: UInt = #line) -> HomeRouter {
        let sut = HomeRouter(viewController: viewController, destinationController: ProfileController(style: .grouped), cardsViewController: CardsViewController())
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
