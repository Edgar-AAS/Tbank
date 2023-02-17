import XCTest
import Domain
import Presentation

class SignUpViewModelTests: XCTestCase {
    func test_signUp_should_show_error_message_if_name_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe() { [weak self] viewModel in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(message: "O campo Nome é obrigatório"))
            exp.fulfill()
        }
        sut.signUp(viewModel: SignUpRequest(email: "any_email@gmail.com", password: "any_password", passwordConfirmation: "any_password"))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_email_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(message: "O campo Email é obrigatório"))
            exp.fulfill()
        }
        sut.signUp(viewModel: SignUpRequest(name: "any_name", password: "any_password", passwordConfirmation: "any_password"))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_password_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(message: "O campo Senha é obrigatório"))
            exp.fulfill()
        }
        sut.signUp(viewModel: SignUpRequest(name: "any_name", email: "any_email@gmail.com", passwordConfirmation: "any_password"))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_passwordConfirmation_is_not_provided() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(message: "O campo Confirmar Senha é obrigatório"))
            exp.fulfill()
        }
        sut.signUp(viewModel: SignUpRequest(name: "any_name", email: "any_email@gmail.com", password: "any_password"))
        wait(for: [exp], timeout: 1)
    }

    func test_singUp_should_show_error_message_if_passwordConfirmation_is_not_match() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(message: "O campo Confirmar Senha é inválido"))
            exp.fulfill()
        }
        sut.signUp(viewModel: SignUpRequest(name: "any_name", email: "any_email@gmail.com", password: "any_password", passwordConfirmation: "wrong_password"))
        wait(for: [exp], timeout: 1)
    }

    func test_signUp_should_show_error_message_if_invalid_email_is_provided() {
        let alertViewSpy = AlertViewSpy()
        let emailValidatorSpy = EmailValidatorSpy()
        emailValidatorSpy.isValid = false
        let sut = makeSut(alertViewSpy: alertViewSpy, emailValidatorSpy: emailValidatorSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            XCTAssertEqual(viewModel, self?.makeAlertViewModel(message: "Email inválido"))
            exp.fulfill()
        }
        sut.signUp(viewModel: SignUpRequest(name: "any_name", email: "invalid_email@gmail.com", password: "any_password", passwordConfirmation: "any_password"))
        wait(for: [exp], timeout: 1)
    }

    func test_singUp_should_call_emailValidator_with_correct_email() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy)
        let viewModel = SignUpRequest(name: "any_name", email: "valid_email@gmail.com", password: "any_password", passwordConfirmation: "any_password")
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(emailValidatorSpy.email, viewModel.email)
    }

    func test_singUp_should_call_addAccount_with_correct_values() {
        let addAccountSpy = AddAccountSpy()
        let sut = makeSut(addAccountSpy: addAccountSpy)
        let viewModel = makeSignUpRequest()
        sut.signUp(viewModel: viewModel)
        XCTAssertEqual(addAccountSpy.addAccountModel, SignUpMapper.toAddAccountModel(signUpRequest: viewModel))
    }
    
    func test_singUp_should_show_error_message_if_addAccount_fails() {
        let addAccountSpy = AddAccountSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy, addAccountSpy: addAccountSpy)
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { [weak self] (viewModel) in
            XCTAssertEqual(viewModel, self? .makeErrorAlertViewmodel(message: "Algo inesperado aconteceu, tente novamente em instantes."))
            exp.fulfill()
        }
        sut.signUp(viewModel: makeSignUpRequest())
        addAccountSpy.completeWithFailure(.unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_singUp_should_show_success_message_if_addAccount_succeds() {
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
}

extension SignUpViewModelTests {
    func makeAlertViewModel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Falha na validação", message: message)
    }
    
    func makeErrorAlertViewmodel(message: String) -> AlertViewModel {
        return AlertViewModel(title: "Erro", message: message)
    }
    
    func makeAccountModel() -> AccountModel {
        return AccountModel(accessToken: "abc123")
    }

    func makeSut(alertViewSpy: AlertViewSpy = AlertViewSpy(), emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(), addAccountSpy: AddAccountSpy = AddAccountSpy(), loadingViewSpy: LoadingViewSpy = LoadingViewSpy(), file: StaticString = #filePath, line: UInt = #line) -> SignUpViewModel {
        let sut = SignUpViewModel(alertView: alertViewSpy, emailValidator: emailValidatorSpy, addAccount: addAccountSpy, loadingView: loadingViewSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        checkMemoryLeak(for: alertViewSpy, file: file, line: line)
        return sut
    }
}
