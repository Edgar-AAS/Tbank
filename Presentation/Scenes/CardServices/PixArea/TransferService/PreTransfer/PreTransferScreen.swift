import UIKit
import Domain

public class PreTransferScreen: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = Colors.primaryColor
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var transferringLabel: UILabel = {
        let label = UILabel()
        label.text = "Transferindo"
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 35, weight: .semibold)
        label.textColor = Colors.offWhiteColor
        return label
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "R$ 542,40"
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.systemFont(ofSize: 45, weight: .heavy)
        label.textColor = Colors.secundaryColor
        return label
    }()
    
    private lazy var contactNameLabel: UILabel = {
        let label = UILabel()
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var cpfTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "CPF"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(hexString: "#cecece")
        return label
    }()
    
    private lazy var cpfValueLabel: UILabel = {
        let label = UILabel()
        label.text = "123.123.123-23"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = Colors.offWhiteColor
        return label
    }()
    
    private lazy var institutionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Instituição"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = UIColor(hexString: "#cecece")
        return label
    }()
    
    private lazy var institutionValueLabel: UILabel = {
        let label = UILabel()
        label.text = "TB PAGAMENTOS -IP"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = Colors.offWhiteColor
        return label
    }()
    
    private lazy var cpfHorizontalStack = makeHorizontalStack(with: [cpfTitleLabel, UIView(), cpfValueLabel], spacing: 0)
    private lazy var institutionHorizontalStack = makeHorizontalStack(with: [institutionTitleLabel, UIView(), institutionValueLabel], spacing: 0)
    private lazy var verticalStack = makeVerticalStack(with: [transferringLabel, balanceLabel, contactNameLabel, cpfHorizontalStack, institutionHorizontalStack], spacing: 0)
    
    func setupTextLabels(_ balance: String, contact: ContactModel) {
        let staticText = "para "
        
        let leftText = NSMutableAttributedString(string: staticText)
        let rightText = NSMutableAttributedString(string: contact.name)
        
        leftText.addAttribute(.font, value: UIFont.systemFont(ofSize: 24, weight: .semibold), range: NSRange(location: 0, length: leftText.length))
        leftText.addAttribute(.foregroundColor, value: Colors.offWhiteColor, range: NSRange(location: 0, length: leftText.length))
        
        rightText.addAttribute(.font, value: UIFont.systemFont(ofSize: 30, weight: .bold), range: NSRange(location: 0, length: rightText.length))
        rightText.addAttribute(.foregroundColor, value: Colors.offWhiteColor, range: NSRange(location: 0, length: rightText.length))
        leftText.append(rightText)
        contactNameLabel.attributedText = leftText
        
        cpfValueLabel.text = contact.cpf
        balanceLabel.text = balance
    }
}

extension PreTransferScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(verticalStack)
    }
    
    func setupConstrains() {
        let safeArea = safeAreaLayoutGuide
        
        scrollView.fillConstraints(
            top: safeArea.topAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            bottom: bottomAnchor
        )
        
        containerView.fillConstraints(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            bottom: scrollView.bottomAnchor
        )
        
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        verticalStack.fillConstraints(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: containerView.bottomAnchor,
            padding: .init(top: 20, left: 20, bottom: 0, right: 20)
        )
    }
    
    func setupAdditionalConfiguration() {
        verticalStack.setCustomSpacing(15, after: transferringLabel)
        verticalStack.setCustomSpacing(0, after: balanceLabel)
        verticalStack.setCustomSpacing(100, after: contactNameLabel)
        verticalStack.setCustomSpacing(20, after: cpfHorizontalStack)
    }
}
