import UIKit

final class TransferViewController: UIViewController {
    private var buttonYCoordinate: CGFloat?
    
    private lazy var transferView = {
        return TransferScreen()
    }()
    
    override func loadView() {
        super.loadView()
        view = transferView
    }
    
    private lazy var forwardButton: CircularButton = {
        return CircularButton(size: CircularButtonSize.medium,
                              image: Icons.arrow_foward,
                              backgroundColor: Colors.secundaryColor,
                              tintColor: .white)
    }()
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupForwardButtonFrame()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(forwardButton)
        transferView.transactionAmountField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
        
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if let amountString = textField.text?.currencyInputFormatting() {
            textField.text = amountString
        }
    }
    
    private func setupForwardButtonFrame() {
        let padding = CircularButtonSize.medium + 10
        let safeHeight = view.frame.height * 0.7
        forwardButton.frame.origin.y = buttonYCoordinate ?? safeHeight
        forwardButton.frame.origin.x = view.frame.maxX - padding
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let buttonHeight: CGFloat = CircularButtonSize.medium
            let padding = buttonHeight + 10
            let keyboardHeight = keyboardFrame.size.height
            buttonYCoordinate = view.frame.height - keyboardHeight - padding
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
}

