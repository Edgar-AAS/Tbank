import UIKit

public class CardConfigurationViewController: UIViewController {
    private lazy var cardConfigurationView: CardConfigurationView? = {
        return view as? CardConfigurationView
    }()
    
    public var createDigitalCard: ((CardConfigurationRequest) -> (Void))?
    
    public override func loadView() {
        super.loadView()
        cardConfigurationView = CardConfigurationView(self)
        cardConfigurationView?.setupCardNameTextFieldDelegateWith(self)
        view = cardConfigurationView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        removeBackButtonTitle()
        cardConfigurationView?.showKeyboard()
        hideKeyboardOnTap()
    }
}

extension CardConfigurationViewController: UITextFieldDelegate {
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        changeButtonState(from: textField)
    }
    
    private func changeButtonState(from textField: UITextField) {
        if let text = textField.text {
            if text.count == .zero {
                cardConfigurationView?.disableButton()
            } else if text.count == 1 {
                cardConfigurationView?.enableButton()
            } else {
                return
            }
        }
    }
}

extension CardConfigurationViewController: LoadingView {
    public func isLoading(viewModel: LoadingViewModel) {
        changeViewState(isEnable: !viewModel.isLoading)
    }
    
    private func changeViewState(isEnable: Bool) {
        let alpha: CGFloat = isEnable ? 1.0 : 0.5
        view.isUserInteractionEnabled = isEnable ? true : false
        self.navigationController?.navigationBar.isUserInteractionEnabled = isEnable ? true : false
        self.navigationController?.navigationBar.alpha = alpha
        self.view.alpha = alpha
        
        if isEnable {
            self.cardConfigurationView?.stopLoadingAnimate()
        } else {
            self.cardConfigurationView?.startLoadingAnimate()
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
        let cardName = cardConfigurationView?.getTexFieldWithoutWhiteSpace()
        let configurationRequest = CardConfigurationRequest(name: cardName)
        createDigitalCard?(configurationRequest)
    }
}
