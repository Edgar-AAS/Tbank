import XCTest
import Domain
import Data
import Presentation

class HomePresenterTests: XCTestCase {
    func test_1() {
        let fetchUserDataSpy = FetchUserDataSpy()
        let profileViewSpy = ProfileViewSpy()
        let sut = makeSut(fetchUserDataSpy: fetchUserDataSpy, profileViewSpy: profileViewSpy)
        let exp = expectation(description: "waiting")
        profileViewSpy.observe { (receivedViewModel) in
            XCTAssertEqual(receivedViewModel, ProfileViewModel(userImageUrl: "https://anyUrl.com", username: "Edgar", isNotifying: false))
            exp.fulfill()
        }
        sut.fetchData()
        fetchUserDataSpy.completeWithSuccess(makeUserModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_2() {
        let fetchUserDataSpy = FetchUserDataSpy()
        let balanceViewSpy = BalanceViewSpy()
        let sut = makeSut(fetchUserDataSpy: fetchUserDataSpy, balanceViewSpy: balanceViewSpy)
        let exp = expectation(description: "waiting")
        balanceViewSpy.observe { (receivedViewModel) in
            XCTAssertEqual(receivedViewModel, BalanceViewModel(totalBalance: "R$ 3.530,45", balanceIsHidden: true))
            exp.fulfill()
        }
        sut.fetchData()
        fetchUserDataSpy.completeWithSuccess(makeUserModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_4() {
        let fetchUserDataSpy = FetchUserDataSpy()
        let cardsViewSpy = CardsViewSpy()
        let sut = makeSut(fetchUserDataSpy: fetchUserDataSpy, cardsViewSpy: cardsViewSpy)
        let cardViewModel = makeCardViewModel()
        let exp = expectation(description: "waiting")
        cardsViewSpy.observe { (receivedViewModel) in
            XCTAssertEqual(receivedViewModel.cards[0].balance, cardViewModel.cards[0].balance)
            XCTAssertEqual(receivedViewModel.cards[0].cardFlag, cardViewModel.cards[0].cardFlag)
            XCTAssertEqual(receivedViewModel.cards[0].cardBrandImageUrl, cardViewModel.cards[0].cardBrandImageUrl)
            XCTAssertEqual(receivedViewModel.cards[0].cardNumber, cardViewModel.cards[0].cardNumber)
            XCTAssertEqual(receivedViewModel.cards[0].cardTag, cardViewModel.cards[0].cardTag)
            XCTAssertEqual(receivedViewModel.cards[0].cvc, cardViewModel.cards[0].cvc)
            XCTAssertEqual(receivedViewModel.cards[0].isVirtual, cardViewModel.cards[0].isVirtual)
            exp.fulfill()
        }
        sut.fetchData()
        fetchUserDataSpy.completeWithSuccess(makeUserModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_5() {
        let fetchUserDataSpy = FetchUserDataSpy()
        let serviceViewSpy = ServiceViewSpy()
        let sut = makeSut(fetchUserDataSpy: fetchUserDataSpy, serviceViewSpy: serviceViewSpy)
        let services = makeServicesModel()
        let exp = expectation(description: "waiting")
        serviceViewSpy.observe { (receivedViewModel) in
            XCTAssertEqual(receivedViewModel, services)
            exp.fulfill()
        }
        sut.fetchData()
        fetchUserDataSpy.completeWithSuccess(makeUserModel())
        wait(for: [exp], timeout: 1)
    }

    func test_6() {
        let fetchUserDataSpy = FetchUserDataSpy()
        let resourceViewSpy = ResourcesViewSpy()
        let sut = makeSut(fetchUserDataSpy: fetchUserDataSpy, resourcesViewSpy: resourceViewSpy)
        let resources = makeResourcesModel()
        let exp = expectation(description: "waiting")
        resourceViewSpy.observe { (receivedViewModel) in
            XCTAssertEqual(receivedViewModel, resources)
            exp.fulfill()
        }
        sut.fetchData()
        fetchUserDataSpy.completeWithSuccess(makeUserModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_7() {
        let homeRouterSpy = HomeRouterSpy()
        let sut = makeSut(homeRouterSpy: homeRouterSpy)
        sut.routeToProfile()
        XCTAssertEqual(homeRouterSpy.callsCount, 1)
    }
    
    func test_8() {
        let fetchUserDataSpy = FetchUserDataSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(fetchUserDataSpy: fetchUserDataSpy, alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { (receivedViewModel) in
            XCTAssertEqual(receivedViewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em instantes."))
            exp.fulfill()
        }
        sut.fetchData()
        fetchUserDataSpy.completeWithFailure(.unexpected)
        wait(for: [exp], timeout: 1)
    }
}


extension HomePresenterTests {
    func makeSut(fetchUserDataSpy: FetchUserDataSpy = FetchUserDataSpy(),
                 homeRouterSpy: HomeRouterSpy = HomeRouterSpy(),
                 profileViewSpy: ProfileViewSpy = ProfileViewSpy(),
                 balanceViewSpy: BalanceViewSpy = BalanceViewSpy(),
                 cardsViewSpy: CardsViewSpy = CardsViewSpy(),
                 serviceViewSpy: ServiceViewSpy = ServiceViewSpy(),
                 resourcesViewSpy: ResourcesViewSpy = ResourcesViewSpy(),
                 alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> HomePresenter
    {
        let sut = HomePresenter(fetchUserData: fetchUserDataSpy,
                                router: homeRouterSpy,
                                profileView: profileViewSpy,
                                balanceView: balanceViewSpy,
                                cardsView: cardsViewSpy,
                                serviceView: serviceViewSpy,
                                resourcesView: resourcesViewSpy,
                                alertView: alertViewSpy
        )
        
        checkMemoryLeak(for: fetchUserDataSpy, file: file, line: line)
        checkMemoryLeak(for: homeRouterSpy, file: file, line: line)
        checkMemoryLeak(for: profileViewSpy, file: file, line: line)
        checkMemoryLeak(for: balanceViewSpy, file: file, line: line)
        checkMemoryLeak(for: serviceViewSpy, file: file, line: line)
        checkMemoryLeak(for: resourcesViewSpy, file: file, line: line)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}

class HomeRouterSpy: PresenterToRouterHomeProtocol {
    private(set) var callsCount = 0
    func goToProfile() {
        callsCount += 1
    }
}

