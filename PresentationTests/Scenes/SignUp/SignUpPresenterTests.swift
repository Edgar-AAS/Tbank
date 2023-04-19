import XCTest
import Domain
import Presentation

class SignUpPresenterTests: XCTestCase {
    func test_singUp_should_call_addAccount_with_correct_values() {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccountSpy: addAccountSpy)
        let viewModel = makeSignUpRequest()
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(addAccountSpy.addAccountModel, viewModel.toAddAccountModel())
    }
    
    func test_singUp_should_show_generic_error_message_if_addAccount_fails() {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em instantes."))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpRequest())
        addAccountSpy.completeWithFailure(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_singUp_should_show_email_in_use_error_message_if_addAccount_retuns_email_in_use_error() {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Esse e-mail já esta em uso."))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpRequest())
        addAccountSpy.completeWithFailure(.emailInUse)
        wait(for: [exp], timeout: 1)
    }
    
    func test_singUp_should_show_success_message_if_addAccount_succeeds() {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Sucesso", message: "Conta criada com sucesso"))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpRequest())
        addAccountSpy.completeWithSuccess(makeAccountModel())
        wait(for: [exp], timeout: 1)
    }
    
    func test_signUp_should_show_loading_before_and_after_addAccount() {
        let addAccountSpy = AddAccountSpy()
        let loadingViewSpy = LoadingViewSpy()
        let sut = makeSut(addAccountSpy: addAccountSpy, loadingViewSpy: loadingViewSpy)
        
        let exp = expectation(description: "waiting")
        loadingViewSpy.observe { (loadingViewModel) in
            XCTAssertEqual(loadingViewModel.isLoading, true)
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpRequest())
        wait(for: [exp], timeout: 1)
        
        let exp2 = expectation(description: "waiting")
        loadingViewSpy.observe { (loadingViewModel) in
            XCTAssertEqual(loadingViewModel.isLoading, false)
            exp2.fulfill()
        }
        addAccountSpy.completeWithFailure(.unexpected)
        wait(for: [exp2], timeout: 1)
    }
    
    func test_signUp_should_call_validations_with_correct_values() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy)
        let signUpRequest = makeSignUpRequest()
        sut.signUp(viewModel: signUpRequest)
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: signUpRequest.toJson()!))
    }
    
    func test_singUp_should_show_error_message_if_validation_fails() {
        let validationSpy = ValidationSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, validationSpy: validationSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { (viewModel) in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Erro"))
            exp.fulfill()
        }
        validationSpy.simulateError()
        sut.signUp(viewModel: makeSignUpRequest())
        wait(for: [exp], timeout: 1)
    }
}

extension SignUpPresenterTests {
    func makeSut(alertViewSpy: AlertViewSpy = AlertViewSpy(), addAccountSpy: AddAccountSpy = AddAccountSpy(), loadingViewSpy: LoadingViewSpy = LoadingViewSpy(), validationSpy: ValidationSpy = ValidationSpy(), file: StaticString = #filePath, line: UInt = #line) -> SignUpPresenter {
        let sut = SignUpPresenter(alertView: alertViewSpy, addAccount: addAccountSpy, loadingView: loadingViewSpy, validation: validationSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: alertViewSpy, file: file, line: line)
        return sut
    }
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(accessToken: "abc123")
    }
}
