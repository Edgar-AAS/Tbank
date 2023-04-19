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
        let profileFactory = ProfileControllerFactory()
        let cardsFactory = CardsControllerFactory()
        let sut = HomeRouter(viewController: viewController, profileControllerFactory: profileFactory.makeProfile, cardsControllerFactory: cardsFactory.makeCards)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}

extension HomeRouterTests {
    class ProfileControllerFactory {    
        func makeProfile() -> ProfileController {
            return ProfileController()
        }
    }
    
    class CardsControllerFactory {
        func makeCards() -> CardsViewController {
            return CardsViewController()
        }
    }
}
