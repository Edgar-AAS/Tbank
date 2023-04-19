import UIKit

public protocol CardConfigurationViewDelegate: AnyObject {
    func digitalCardButtonDidTapped()
}

public class CardConfigurationView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private weak var delegate: CardConfigurationViewDelegate?
    
    convenience init(_ delegate: CardConfigurationViewDelegate) {
        self.init(frame: .zero)
        self.delegate = delegate
    }
        
    lazy var makeDigitalCardButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .gray
        button.setTitle("Criar cartão digital", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.isUserInteractionEnabled = false
        button.setTitleColor(.primaryColor, for: .normal)   
        return button
    }()
    
    @objc func tap() {
        delegate?.digitalCardButtonDidTapped()
    }
    
    func disableButton() {
        makeDigitalCardButton.backgroundColor = UIColor(hexString: "#8e8e93")
        makeDigitalCardButton.isUserInteractionEnabled = false
        cardNameTextField.tintColor = .gray
        cardNameTextField.layer.borderColor = UIColor.gray.cgColor
    }
    
    func enableButton() {
        makeDigitalCardButton.backgroundColor = .secundaryColor
        makeDigitalCardButton.isUserInteractionEnabled = true
        cardNameTextField.tintColor = .secundaryColor
        cardNameTextField.layer.borderColor = UIColor.secundaryColor.cgColor
    }
    
    lazy var digitalCardTitle: UILabel = .descriptionLabel(titleText: "Dê um nome ao seu cartão digital!", subtitleText: "\nEscolha um nome que identifique facilmente o seu uso.", titleFontSize: 30, subtitleFontSize: 20, titleColor: .offWhiteColor, subtitleColor: UIColor(hexString: "#cecece"))
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var cardNameTextField: CustomTextField = .init(placeholderText: "Digite o nome do seu cartão digital")
    
    public func setupCardNameTextFieldDelegateWith(_ delegate: UITextFieldDelegate) {
        cardNameTextField.delegate = delegate
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        makeDigitalCardButton.layer.cornerRadius = makeDigitalCardButton.frame.size.height / 2
        makeDigitalCardButton.clipsToBounds = true
    }
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.hidesWhenStopped = true
        loadingView.style = .large
        loadingView.color = .secundaryColor
        return loadingView
    }()
}

extension CardConfigurationView: CodeView {
    func buildViewHierarchy() {
        addSubview(digitalCardTitle)
        addSubview(cardNameTextField)
        addSubview(makeDigitalCardButton)
        addSubview(loadingIndicator)
    }
    
    func setupConstrains() {
        digitalCardTitle.fillConstraints(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 16, bottom: 0, right: 16)
        )
        
        cardNameTextField.fillConstraints(
            top: digitalCardTitle.bottomAnchor,
            leading: digitalCardTitle.leadingAnchor,
            trailing: digitalCardTitle.trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 44)
        )
        
        makeDigitalCardButton.fillConstraints(
            top: cardNameTextField.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 48, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 60)
        )
        
        loadingIndicator.fillConstraints(
            top: makeDigitalCardButton.bottomAnchor,
            leading: nil,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 32, left: 0, bottom: 0, right: 0),
            size: .init(width: 64, height: 64)
        )
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .primaryColor
        cardNameTextField.setupLeftImageView(image: UIImage(systemName: "list.bullet.rectangle")!, with: .gray)
        cardNameTextField.tintColor = .gray
        cardNameTextField.layer.borderColor = UIColor.gray.cgColor
    }
}
