import UIKit

public final class TransferViewController: UIViewController {
    private lazy var transferView = {
        return TransferScreen()
    }()
    
    private lazy var forwardButton: CircularButton = {
        return CircularButton(size: CircularButtonSize.medium,
                              image: Icons.arrow_foward,
                              backgroundColor: UIColor.darkGray,
                              tintColor: .white)
    }()
    
    public override func loadView() {
        super.loadView()
        view = transferView
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupForwardButtonFrame()
    }
    
    private var buttonYCoordinate: CGFloat?
    public var presenter: ViewToPresenterTransferProtocol?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(forwardButton)
        transferView.transactionAmountField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
        forwardButton.addTarget(self, action: #selector(forwardButtonTapped), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
        
    
    @objc private func forwardButtonTapped() {
        guard let enteredBalance = transferView.transactionAmountField.text else { return }
        presenter?.validateBalance(enteredBalance)
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
        NotificationCenter.default.removeObserver(self)
    }
}

extension TransferViewController: AlertView {
    public func showMessage(viewModel: AlertViewModel) {
        print(viewModel)
    }
}

