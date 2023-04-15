import UIKit

protocol CardSuccessViewDelegate: AnyObject {
    func cardAcessbuttonDidTapped()
}

public class CardSuccessView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private weak var delegate: CardSuccessViewDelegate?
    
    convenience init(_ delegate: CardSuccessViewDelegate) {
        self.init(frame: .zero)
        self.delegate = delegate
    }
    
    lazy var imageContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var successCardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "inputCard-logo")
        return imageView
    }()
    
    lazy var successfullyCreatedCardMessageTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Seu cartão digital foi criado"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .offWhiteColor
        return label
    }()
    
    lazy var successfullyCreatedCardMessageDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Os dados do seu cartão ficam disponiveis na área \"Meus cartões\"."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(hexString: "#cecece")
        return label
    }()
    
    lazy var cardAcessbutton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .secundaryColor
        button.setTitle("Acessar cartão", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tap), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        button.setTitleColor(.primaryColor, for: .normal)
        return button
    }()
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        cardAcessbutton.layer.cornerRadius = cardAcessbutton.frame.height / 2
        cardAcessbutton.clipsToBounds = true
    }
    
    @objc private func tap() {
        delegate?.cardAcessbuttonDidTapped()
    }
}

extension CardSuccessView: CodeView {
    func buildViewHierarchy() {
        addSubview(imageContentView)
        imageContentView.addSubview(successCardImageView)
        addSubview(successfullyCreatedCardMessageTitleLabel)
        addSubview(successfullyCreatedCardMessageDescriptionLabel)
        addSubview(cardAcessbutton)
    }

    func setupConstrains() {
        let safeArea = safeAreaLayoutGuide
        
        imageContentView.fillConstraints(
            top: safeArea.topAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
    
        successCardImageView.fillConstraints(
            top: imageContentView.topAnchor,
            leading: nil,
            trailing: nil,
            bottom: imageContentView.bottomAnchor,
            padding: .init(top: 32, left: 0, bottom: 32, right: 0),
            size: .init(width: 180, height: 180)
        )
        
        successCardImageView.centerXAnchor.constraint(equalTo: imageContentView.centerXAnchor).isActive = true
        
        successfullyCreatedCardMessageTitleLabel.fillConstraints(
            top: imageContentView.bottomAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 16, bottom: 0, right: 16)
        )
        
        successfullyCreatedCardMessageDescriptionLabel.fillConstraints(
            top: successfullyCreatedCardMessageTitleLabel.bottomAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 16, bottom: 0, right: 16)
        )
        
        cardAcessbutton.fillConstraints(
            top: nil,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 24, bottom: 0, right: 24),
            size: .init(width: 0, height: 60)
        )
        
        successfullyCreatedCardMessageDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: cardAcessbutton.topAnchor, constant: -16).isActive = true
        cardAcessbutton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -16).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .primaryColor
    }
}


