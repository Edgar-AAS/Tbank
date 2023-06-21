import Foundation
import UIKit

public final class SignUpViewController: UIViewController {
    lazy var signUpScreen: SignUpView? = {
        return view as? SignUpView
    }()
    
    public var signUp: ((SignUpRequest) -> (Void))?
    
    public override func loadView() {
        super.loadView()
        view = SignUpView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        configureViews()
    }
    
    private func configureViews() {
        signUpScreen?.saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        signUpScreen?.nameTextField.becomeFirstResponder()
        signUpScreen?.setupDelegateTextFields(delegate: self)
    }
    
    @objc private func saveButtonTapped() {
        let viewModel = SignUpRequest(
            name: signUpScreen?.nameTextField.text,
            email: signUpScreen?.emailTextField.text,
            password: signUpScreen?.passwordTextField.text,
            passwordConfirmation: signUpScreen?.passwordConfirmationTextField.text
        )
        signUp?(viewModel)
    }
}

extension SignUpViewController: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = view.viewWithTag(textField.tag + 1) as? CustomTextField {
            if isAllFieldsFilled() {
                saveButtonTapped()
            } else {
                nextField.becomeFirstResponder()
            }
        } else {
            textField.resignFirstResponder()
            saveButtonTapped()
        }
        return true
    }

    private func isAllFieldsFilled() -> Bool {
        if let screen = signUpScreen {
            let fields = [screen.nameTextField, screen.emailTextField, screen.passwordTextField, screen.passwordConfirmationTextField]
            if fields.allSatisfy({ ($0.text?.isEmpty) == false }) {
                return true
            }
        }
        return false
    }
}

extension SignUpViewController: LoadingView {
    public func isLoading(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            self.view.isUserInteractionEnabled = false
            self.signUpScreen?.loadingIndicator.startAnimating()
            self.signUpScreen?.saveButton.alpha = 0.5
            self.view.alpha = 0.5
        } else {
            self.view.isUserInteractionEnabled = true
            self.signUpScreen?.loadingIndicator.stopAnimating()
            self.signUpScreen?.saveButton.alpha = 1
            self.view.alpha = 1
        }
    }
}

extension SignUpViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        showAlertController(title: viewModel.title, message: viewModel.message)
    }
}

