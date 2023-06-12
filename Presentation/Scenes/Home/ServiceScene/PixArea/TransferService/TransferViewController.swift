import UIKit

final class TransferViewController: UIViewController {
    
    private lazy var transferView = {
        return TransferScreen()
    }()
    
    override func loadView() {
        super.loadView()
        view = transferView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transferView.transactionAmountField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            //recovery sized keyboard
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}


