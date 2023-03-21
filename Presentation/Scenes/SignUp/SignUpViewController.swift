import Foundation
import UIKit

public final class SignUpViewController: UIViewController {
    public var signUp: ((SignUpRequest) -> (Void))? //dependencia injetada pela viewModel
    
    lazy var signUpScreen: SignUpView? = {
        return view as? SignUpView
    }()
    
    public override func loadView() {
        super.loadView()
        view = SignUpView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTap()
        configureViews()
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
        if let nextField = view.viewWithTag(textField.tag + 1) as? FormTextField {
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
                print("passei aqui po")
                return true
            }
        }
        return false
    }
}

//DispatchQueue conhcece meu controller e meu controller conhece o DispatchQueue
//Duas referencias fortes = retain cycle
//Design Pattern Decorator para nao precisar usar dispatch main em tudo <-

extension SignUpViewController: LoadingView {
    public func isLoading(viewModel: LoadingViewModel) {
        //manipulando a interface de usuario em background//
        //problema de fazer isso na UI é que todo código que for callBack precisaria de DispatchQueue.main.async
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
        let alert = UIAlertController(title: viewModel.title, message: viewModel.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

