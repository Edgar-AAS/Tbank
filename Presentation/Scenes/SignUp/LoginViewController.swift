import Foundation
import UIKit

public final class LoginViewController: UIViewController {
    public var login: ((LoginRequest) -> (Void))?
    
    lazy var loginScreen: LoginView? = {
        return LoginView()
    }()
    
    public override func loadView() {
        super.loadView()
        view = loginScreen
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        hideKeyboardOnTap()
    }
    
    private func hideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func configureViews() {
        loginScreen?.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        loginScreen?.emailTextField.becomeFirstResponder()
        loginScreen?.setupDelegateTextFields(delegate: self)
    }
    
    @objc private func loginButtonTapped() {
        let loginRequest = LoginRequest(
            email: loginScreen?.emailTextField.text,
            password: loginScreen?.passwordTextField.text
        )
        login?(loginRequest)
    }
    
    private func isAllFieldsFilled() -> Bool {
        if let screen = loginScreen {
            let fields = [screen.emailTextField, screen.passwordTextField]
            if fields.allSatisfy({ ($0.text?.isEmpty) == false }) {
                print("passei aqui po")
                return true
            }
        }
        return false
    }
}

extension LoginViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = view.viewWithTag(textField.tag + 1) as? CustomTextField {
            if isAllFieldsFilled() {
                loginButtonTapped()
            } else {
                nextField.becomeFirstResponder()
            }
        } else {
            textField.resignFirstResponder()
            loginButtonTapped()
        }
        return true
    }
}

extension LoginViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

extension LoginViewController: LoadingView {
    public func isLoading(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            disableScreen()
        } else {
            enableScreen()
        }
    }
    
    private func disableScreen() {
        view.isUserInteractionEnabled = false
        loginScreen?.loadingIndicator.startAnimating()
        navigationController?.navigationBar.alpha = 0.5
        loginScreen?.loginButton.alpha = 0.5
        view.alpha = 0.5
    }
    
    private func enableScreen() {
        view.isUserInteractionEnabled = true
        loginScreen?.loadingIndicator.stopAnimating()
        navigationController?.navigationBar.alpha = 1
        loginScreen?.loginButton.alpha = 1
        view.alpha = 1
    }
}
