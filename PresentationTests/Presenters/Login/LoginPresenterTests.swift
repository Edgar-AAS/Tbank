import XCTest
import Domain
import Presentation

//presenter agora tem um router que nao foi testado <<-----
//criar um mock do router aqui <--
class LoginPresenterTests: XCTestCase {
    func test_login_should_call_validations_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy)
        let loginRequest = makeLoginRequest()
        sut.login(loginRequest: loginRequest)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: loginRequest.toJson()!))
    }
    
    func test_login_should_show_error_message_if_validation_fails() {
        let validationSpy = ValidationSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, validationSpy: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
            exp.fulfill()
        }
        validationSpy.simulateError()
        sut.login(loginRequest: makeLoginRequest())
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_call_authentication_with_correct_values() {
        let authenticationSpy = AuthenticationSpy()
        let sut = makeSut(authenticationSpy: authenticationSpy)
        let loginRequest = makeLoginRequest()
        sut.login(loginRequest: loginRequest)
        XCTAssertEqual(authenticationSpy.authenticationModel, loginRequest.toAuthenticationModel())
    }
    
    func test_login_should_show_generic_error_message_if_authentication_fails() {
        let authenticationSpy = AuthenticationSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, authenticationSpy: authenticationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em instantes."))
            exp.fulfill()
        }
        sut.login(loginRequest: makeLoginRequest())
        authenticationSpy.completeWithFailure(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_should_show_expired_session_error_message_if_authentication_completes_with_expired_session() {
        let authenticationSpy = AuthenticationSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, authenticationSpy: authenticationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Email e/ou senha invalído(s)."))
            exp.fulfill()
        }
        sut.login(loginRequest: makeLoginRequest())
        authenticationSpy.completeWithFailure(.sessionExpired)
        wait(for: [exp], timeout: 1)
    }
    
//    func test_singUp_should_show_success_message_if_authentication_succeeds() {
//        let authenticationSpy = AuthenticationSpy()
//        let alertViewSpy = AlertViewSpy()
//        let sut = makeSut(alertViewSpy: alertViewSpy, authenticationSpy: authenticationSpy)
//        let exp = expectation(description: "waiting")
//        alertViewSpy.observe { (viewModel) in
//            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Login feito com sucesso"))
//            exp.fulfill()
//        }
//        sut.login(loginRequest: makeLoginRequest())
//        authenticationSpy.completeWithSuccess(makeAccountModel())
//        wait(for: [exp], timeout: 1)
//    }
    
    func test_login_should_show_loading_before_and_after_authentication() {
        let authenticationSpy = AuthenticationSpy()
        let loadingViewSpy = LoadingViewSpy()
        let sut = makeSut(authenticationSpy: authenticationSpy, loadingViewSpy: loadingViewSpy)
        let exp = expectation(description: "waiting")
        
        loadingViewSpy.observe { (loadingViewModel) in
            XCTAssertEqual(loadingViewModel.isLoading, true)
            exp.fulfill()
        }
        
        sut.login(loginRequest: makeLoginRequest())
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { (loadingViewModel) in
            XCTAssertEqual(loadingViewModel.isLoading, false)
            exp2.fulfill()
        }
        authenticationSpy.completeWithFailure(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
}


extension LoginPresenterTests {
    func makeSut(alertViewSpy: AlertViewSpy = AlertViewSpy(), authenticationSpy: AuthenticationSpy = AuthenticationSpy(), validationSpy: ValidationSpy = ValidationSpy(), loadingViewSpy: LoadingViewSpy = LoadingViewSpy(), router: LoginRouter = LoginRouter(viewController: nil, destinationController: UIViewController()), file: StaticString = #filePath, line: UInt = #line) -> LoginPresenter {
        let sut = LoginPresenter(validation: validationSpy, alertView: alertViewSpy, authentication: authenticationSpy, loadingView: loadingViewSpy, router: router)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
