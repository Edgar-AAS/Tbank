import XCTest
import Domain
import Data
import Presentation

class HomePresenterTests: XCTestCase {
    //profileView
    func test_fetchData_should_call_profileView_with_correct_values() {
        let fetchUserDataSpy = FetchUserDataSpy()
        let profileViewSpy = ProfileViewSpy()
        let sut = makeSut(fetchUserDataSpy: fetchUserDataSpy, profileViewSpy: profileViewSpy)
        let exp = expectation(description: "waiting")
        profileViewSpy.observe { (receivedViewModel) in
            XCTAssertEqual(receivedViewModel, PersonHeaderViewModel(userImageUrl: "any_url.com", username: "Edgar Arlindo", isNotifying: false))
            exp.fulfill()
        }
        sut.fetchData()
        fetchUserDataSpy.completeWithSuccess(makeUserDataReponse())
        wait(for: [exp], timeout: 1)
    }
    
    //balanceView
    func test_fetchData_should_call_balanceView_with_correct_values() {
        let fetchUserDataSpy = FetchUserDataSpy()
        let balanceViewSpy = BalanceViewSpy()
        let sut = makeSut(fetchUserDataSpy: fetchUserDataSpy, balanceViewSpy: balanceViewSpy)
        let exp = expectation(description: "waiting")
        balanceViewSpy.observe { (receivedViewModel) in
            XCTAssertEqual(receivedViewModel, BalanceViewModel(totalBalance: "R$ 42.569,60", balanceIsHidden: true))
            exp.fulfill()
        }
        sut.fetchData()
        fetchUserDataSpy.completeWithSuccess(makeUserDataReponse())
        wait(for: [exp], timeout: 1)
    }
    
    //CardsView
    func test_fetchCards_should_call_cardsView_with_correct_values() {
        let fetchCardsSpy = FetchUserCardsSpy()
        let cardsViewSpy = CardsViewSpy()
        let sut = makeSut(fetchUserCardsSpy: fetchCardsSpy, cardsViewSpy: cardsViewSpy)
        let cardViewModel = makeCardViewModel()
        let exp = expectation(description: "waiting")
        cardsViewSpy.observe { (receivedViewModel) in
            XCTAssertEqual(receivedViewModel, cardViewModel)
            exp.fulfill()
        }
        sut.fechCards()
        fetchCardsSpy.completeWithSuccess(makeUserCardsResponse())
        wait(for: [exp], timeout: 1)
    }

    //ServiceView
    func test_fetchData_should_call_serviceView_with_correct_values() {
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
        fetchUserDataSpy.completeWithSuccess(makeUserDataReponse())
        wait(for: [exp], timeout: 1)
    }

    //ResourceView
    func test_fetchData_should_call_resourceView_with_correct_values() {
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
        fetchUserDataSpy.completeWithSuccess(makeUserDataReponse())
        wait(for: [exp], timeout: 1)
    }
    
    //AlertView
    func test_alertView_should_show_error_message_if_fetchData_completes_with_unexpected_error() {
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
    
    func test_alertView_should_show_error_message_if_fetchCards_completes_with_unexpected_error() {
        let fetchCardsSpy = FetchUserCardsSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(fetchUserCardsSpy: fetchCardsSpy, alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { (receivedViewModel) in
            XCTAssertEqual(receivedViewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em instantes."))
            exp.fulfill()
        }
        sut.fechCards()
        fetchCardsSpy.completeWithFailure(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_routeToProfile_calls_profile() {
        let homeRouterSpy = HomeRouterSpy()
        let sut = makeSut(homeRouterSpy: homeRouterSpy)
        sut.routeToProfile()
        XCTAssertEqual(homeRouterSpy.profileIsCalled, true)
    }
    
    func test_routeToCards_calls_cardsController() {
        let homeRouterSpy = HomeRouterSpy()
        let sut = makeSut(homeRouterSpy: homeRouterSpy)
        sut.routeToCards()
        XCTAssertEqual(homeRouterSpy.cardsControllerIsCalled, true)
    }
}

extension HomePresenterTests {
    func makeSut(fetchUserDataSpy: FetchUserDataSpy = FetchUserDataSpy(),
                 fetchUserCardsSpy: FetchUserCardsSpy = FetchUserCardsSpy(),
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
                                fetchUserCards: fetchUserCardsSpy,
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
    private(set) var cardsControllerIsCalled = false
    private(set) var profileIsCalled = false
    
    func goToCardsController() {
        cardsControllerIsCalled = true
    }
    
    func goToProfile() {
        profileIsCalled = true
    }
}

