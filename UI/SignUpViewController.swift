import Foundation
import UIKit
import Presentation

final class SignUpViewController: UIViewController {
    
    var loadingIndicator: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.hidesWhenStopped = true
        loadingView.style = .large
        loadingView.tintColor = .white
        return loadingView
    }()
    
    var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    var nameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var passwordConfirmationTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var signUp: ((SignUpRequest) -> (Void))?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loadingIndicator)
        view.addSubview(saveButton)
        loadingIndicator.center = view.center
        configure()
    }
    
    private func configure() {
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        hideKeyboardOnTap()
    }
    
    @objc private func saveButtonTapped() {
        let viewModel = SignUpRequest(name: nameTextField.text, email: emailTextField.text, password: passwordTextField.text, passwordConfirmation: passwordConfirmationTextField.text)
        signUp?(viewModel)
    }
}

extension SignUpViewController: LoadingView {
    func isLoading(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            view.isUserInteractionEnabled = false
            loadingIndicator.startAnimating()
        } else {
            view.isUserInteractionEnabled = true
            loadingIndicator.stopAnimating()
        }
    }
}

extension SignUpViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        
    }
}
