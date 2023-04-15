import UIKit

public class CardConfigurationViewController: UIViewController {
    public var cardConfigurationView: CardConfigurationView?
    public var createDigitalCard: ((CardConfigurationRequest) -> (Void))?
    
    public override func loadView() {
        super.loadView()
        cardConfigurationView = CardConfigurationView(self)
        cardConfigurationView?.setupCardNameTextFieldDelegateWith(self)
        view = cardConfigurationView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backButtonTitle = ""
        cardConfigurationView?.cardNameTextField.becomeFirstResponder()
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
}

extension CardConfigurationViewController: UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.count == 0 {
            cardConfigurationView?.disableButton()
        } else if textField.text?.count == 1 {
            if let text = textField.text {
                if text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                    cardConfigurationView?.disableButton()
                    cardConfigurationView?.cardNameTextField.layer.borderColor = UIColor.offWhiteColor.cgColor
                } else {
                    cardConfigurationView?.enableButton()
                    cardConfigurationView?.cardNameTextField.layer.borderColor = UIColor.secundaryColor.cgColor
                }
            }
        }
    }
}

extension CardConfigurationViewController: LoadingView {
    public func isLoading(viewModel: LoadingViewModel) {
        if viewModel.isLoading {
            self.view.isUserInteractionEnabled = false
            self.cardConfigurationView?.loadingIndicator.startAnimating()
            self.cardConfigurationView?.makeDigitalCardButton.alpha = 0.5
            self.view.alpha = 0.5
        } else {
            self.view.isUserInteractionEnabled = true
            self.cardConfigurationView?.loadingIndicator.stopAnimating()
            self.cardConfigurationView?.makeDigitalCardButton.alpha = 1
            self.view.alpha = 1
        }
    }
}

extension CardConfigurationViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        print(viewModel.message)
    }
}

extension CardConfigurationViewController: CardConfigurationViewDelegate {
    public func digitalCardButtonDidTapped() {
        let cardName = cardConfigurationView?.cardNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let configurationRequest = CardConfigurationRequest(name: cardName)
        createDigitalCard?(configurationRequest)
    }
}
