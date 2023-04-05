import Foundation
import UIKit

public final class LoginViewController: UIViewController {
    public var login: ((LoginRequest) -> (Void))?
    
    lazy var loginScreen: LoginView? = {
        return view as? LoginView
    }()
    
    public override func loadView() {
        super.loadView()
        view = LoginView()
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
    
    @objc func dismissKeyboard() {
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
            self.view.isUserInteractionEnabled = false
            self.loginScreen?.loadingIndicator.startAnimating()
            self.loginScreen?.loginButton.alpha = 0.5
            self.view.alpha = 0.5
        } else {
            self.view.isUserInteractionEnabled = true
            self.loginScreen?.loadingIndicator.stopAnimating()
            self.loginScreen?.loginButton.alpha = 1
            self.view.alpha = 1
        }
    }
}
