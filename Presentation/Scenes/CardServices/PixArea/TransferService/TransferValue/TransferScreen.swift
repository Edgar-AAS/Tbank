import UIKit

public final class TransferScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var transferTitleLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.text = "Qual é o valor da transferência?"
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = Colors.offWhiteColor
        return label
    }()
    
    private lazy var descriptionBalanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Saldo disponivel em conta: "
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(hexString: "#cecece")
        return label
    }()
    
    private var balanceLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        label.textColor = UIColor(hexString: "#cecece")
        return label
    }()
    
    private lazy var horizontalStack = makeHorizontalStack(with: [descriptionBalanceLabel, balanceLabel, UIView()], spacing: 2)
    
    lazy var transactionAmountField: UITextField = {
        let textField = UITextField()
        textField.text = String().currencyInputFormatting()
        textField.font = UIFont.boldSystemFont(ofSize: 36)
        textField.tintColor = Colors.offWhiteColor
        textField.textColor = .white
        return textField
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    func updateAvaiableBalance(balance: String) {
        self.balanceLabel.text = balance
    }
}

extension TransferScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(transferTitleLabel)
        containerView.addSubview(horizontalStack)
        containerView.addSubview(transactionAmountField)
        containerView.addSubview(bottomLine)
    }
    
    func setupConstrains() {
        let safeArea = safeAreaLayoutGuide
        
        scrollView.fillConstraints(
            top: safeArea.topAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            bottom: safeArea.bottomAnchor
        )
        
        containerView.fillConstraints(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            bottom: scrollView.bottomAnchor
        )
        
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        transferTitleLabel.fillConstraints(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 20, bottom: 0, right: 20)
        )
        
        horizontalStack.fillConstraints(
            top: transferTitleLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 20, bottom: 0, right: 20)
        )
        
        transactionAmountField.fillConstraints(
            top: horizontalStack.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 20, bottom: 0, right: 20)
        )
        
        bottomLine.fillConstraints(
            top: transactionAmountField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: containerView.bottomAnchor,
            padding: .init(top: 2, left: 20, bottom: 0, right: 20),
            size: .init(width: 0, height: 1)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.primaryColor
        transactionAmountField.keyboardType = .numberPad
        transactionAmountField.becomeFirstResponder()
    }
}
