import UIKit

public class ContactListToTransferHeader: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var transferDestinationLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 25.0, weight: .heavy)
        label.textColor = Colors.offWhiteColor
        return label
    }()
        
    private lazy var transferDestinationDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Encontre um contato na sua lista ou inicie uma nova transferência"
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .semibold)
        label.textColor = UIColor(hexString: "#cecece")
        return label
    }()
    
    lazy var pixKeyTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 25.0, weight: .semibold)
        textField.tintColor = Colors.offWhiteColor
        textField.placeholder = "Nome, CPF/CNPJ ou chave Pix"
        textField.textColor = .white
        return textField
    }()
    
    private lazy var bottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    func updateBalanceLabel(balanceString: String) {
        transferDestinationLabel.text = "Para quem você quer transferir \(balanceString)?"
    }
}

extension ContactListToTransferHeader: CodeView {
    func buildViewHierarchy() {
        addSubview(transferDestinationLabel)
        addSubview(transferDestinationDescriptionLabel)
        addSubview(pixKeyTextField)
        addSubview(bottomLine)
    }
    
    func setupConstrains() {
        transferDestinationLabel.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 20, bottom: 0, right: 20)
        )
        
        transferDestinationDescriptionLabel.fillConstraints(
            top: transferDestinationLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 20, bottom: 0, right: 20)
        )
        
        pixKeyTextField.fillConstraints(
            top: transferDestinationDescriptionLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 20, bottom: 0, right: 20)
        )
        
        bottomLine.fillConstraints(
            top: pixKeyTextField.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 2, left: 20, bottom: 40, right: 20),
            size: .init(width: 0, height: 1)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.primaryColor
    }
}
