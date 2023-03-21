import Foundation
import Domain

public final class LoginPresenter {
    private let validation: Validation
    private let alertView: AlertView
    private let authentication: Authentication
    private let loadingView: LoadingView
    private let router: PresenterToRouterLoginProtocol
    
    public init(validation: Validation,
                alertView: AlertView,
                authentication: Authentication,
                loadingView: LoadingView,
                router: PresenterToRouterLoginProtocol)
                {
                self.validation = validation
                self.alertView = alertView
                self.authentication = authentication
                self.loadingView = loadingView
                self.router = router
    }
    
    public func login(loginRequest: LoginRequest) {
        if let message = validation.validate(data: loginRequest.toJson()) {
            alertView.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            loadingView.isLoading(viewModel: LoadingViewModel(isLoading: true))
            authentication.auth(authenticationModel: loginRequest.toAuthenticationModel(), completion: { [weak self] result in
                guard self != nil else { return }
                switch result {
                case .success:
                    self?.router.goToHome()
                case .failure(let error):
                    var errorMessage = String()
                    switch error {
                    case .sessionExpired:
                        errorMessage = "Email e/ou senha invalído(s)."
                    default:
                        errorMessage = "Algo inesperado aconteceu, tente novamente em instantes."
                    }
                    self?.alertView.showMessage(viewModel: AlertViewModel(title: "Erro", message: errorMessage))
                }
                self?.loadingView.isLoading(viewModel: LoadingViewModel(isLoading: false))
            })
        }
    }
}
