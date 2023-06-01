import UIKit

public class CardInformationView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .red
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cardNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "Picareta"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.offWhiteColor
        label.textAlignment = .left
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Nome"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var usernameContentLabel: UILabel = {
        let label = UILabel()
        label.text = "Edgar A A Santos"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Colors.secundaryColor
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "Número"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.offWhiteColor
        label.textAlignment = .left
        return label
    }()
    
    private lazy var numberContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "1234 1234 1234 1234"
        label.textColor = Colors.secundaryColor
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var expirationDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Validade"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.offWhiteColor
        label.textAlignment = .center
        return label
    }()
    
    private lazy var expirationDateContentlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Colors.secundaryColor
        label.text = "03/31"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cvcLabel: UILabel = {
        let label = UILabel()
        label.text = "CVC"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = Colors.offWhiteColor
        return label
    }()
    
    private lazy var cvcContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "123"
        label.textColor = Colors.secundaryColor
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardMarkLabel: UILabel = {
        let label = UILabel()
        label.text = "Mastercard"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = Colors.offWhiteColor
        return label
    }()
    
    private lazy var cardMarkContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Colors.secundaryColor
        label.text = "Platinum"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardFunctionLabel: UILabel = {
        let label = UILabel()
        label.text = "Função"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = Colors.offWhiteColor
        return label
    }()
    
    private lazy var cardFunctionContentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = Colors.secundaryColor
        label.minimumScaleFactor = 0.7
        label.adjustsFontSizeToFitWidth = true
        label.text = "Débito e crédito"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var deleteCardButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexString: "0A2647")
        button.setTitle("Excluir cartão digital", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.tintColor = UIColor(hexString: "FF4735")
        button.largeContentImageInsets = .init(top: 0, left: 20, bottom: 0, right: 50)
        button.layer.cornerRadius = 30
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var nameView = makeInfoView()
    private lazy var cardNumberView = makeInfoView()
    private lazy var expirationDateView = makeInfoView()
    private lazy var cvcView = makeInfoView()
    private lazy var cardMarkView = makeInfoView()
    private lazy var cardFunctionView = makeInfoView()

    private lazy var expirationDateAndCVCHorizontalStack = makeHorizontalStack(with: [expirationDateView, cvcView], spacing: 32)
    private lazy var cardMarkAndCardFunctionHorizontalStack = makeHorizontalStack(with: [cardMarkView, cardFunctionView], spacing: 32)
    
    func updateUI(cardViewModel: CardModel) {
        cardNameLabel.text = cardViewModel.name
        numberContentLabel.text = cardViewModel.cardNumber
        expirationDateContentlabel.text = cardViewModel.cardExpirationDate
        cvcContentLabel.text = cardViewModel.cvc
        cardMarkContentLabel.text = cardViewModel.cardFlag
        cardFunctionContentLabel.text = cardViewModel.cardFunction
    }
}

extension CardInformationView: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(cardNameLabel)
        containerView.addSubview(nameView)
        containerView.addSubview(cardNumberView)
        containerView.addSubview(expirationDateAndCVCHorizontalStack)
        containerView.addSubview(cardMarkAndCardFunctionHorizontalStack)
        containerView.addSubview(deleteCardButton)
        nameView.addSubview(usernameLabel)
        nameView.addSubview(usernameContentLabel)
        cardNumberView.addSubview(numberLabel)
        cardNumberView.addSubview(numberContentLabel)
        expirationDateView.addSubview(expirationDateLabel)
        expirationDateView.addSubview(expirationDateContentlabel)
        cvcView.addSubview(cvcLabel)
        cvcView.addSubview(cvcContentLabel)
        cardMarkView.addSubview(cardMarkLabel)
        cardMarkView.addSubview(cardMarkContentLabel)
        cardFunctionView.addSubview(cardFunctionLabel)
        cardFunctionView.addSubview(cardFunctionContentLabel)
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
        containerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        
        cardNameLabel.fillConstraints(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        nameView.fillConstraints(
            top: cardNameLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 16, bottom: 0, right: 16)
        )
        
        usernameLabel.fillConstraints(
            top: nameView.topAnchor,
            leading: nameView.leadingAnchor,
            trailing: nameView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        usernameContentLabel.fillConstraints(
            top: usernameLabel.bottomAnchor,
            leading: nameView.leadingAnchor,
            trailing: nameView.trailingAnchor,
            bottom: nameView.bottomAnchor,
            padding: .init(top: 8, left: 16, bottom: 16, right: 16)
        )
        
        cardNumberView.fillConstraints(
            top: nameView.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        numberLabel.fillConstraints(
            top: cardNumberView.topAnchor,
            leading: cardNumberView.leadingAnchor,
            trailing: cardNumberView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )

        numberContentLabel.fillConstraints(
            top: numberLabel.bottomAnchor,
            leading: cardNumberView.leadingAnchor,
            trailing: cardNumberView.trailingAnchor,
            bottom: cardNumberView.bottomAnchor,
            padding: .init(top: 8, left: 16, bottom: 16, right: 16)
        )
        
        expirationDateAndCVCHorizontalStack.fillConstraints(
            top: cardNumberView.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )

        expirationDateLabel.fillConstraints(
            top: expirationDateView.topAnchor,
            leading: expirationDateView.leadingAnchor,
            trailing: expirationDateView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )

        expirationDateContentlabel.fillConstraints(
            top: expirationDateLabel.bottomAnchor,
            leading: expirationDateView.leadingAnchor,
            trailing: expirationDateView.trailingAnchor,
            bottom: expirationDateView.bottomAnchor,
            padding: .init(top: 8, left: 16, bottom: 16, right: 16)
        )
    
        cvcLabel.fillConstraints(
            top: cvcView.topAnchor,
            leading: cvcView.leadingAnchor,
            trailing: cvcView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )

        cvcContentLabel.fillConstraints(
            top: cvcLabel.bottomAnchor,
            leading: cvcView.leadingAnchor,
            trailing: cvcView.trailingAnchor,
            bottom: cvcView.bottomAnchor,
            padding: .init(top: 8, left: 16, bottom: 16, right: 16)
        )
        
        cardMarkAndCardFunctionHorizontalStack.fillConstraints(
            top: expirationDateAndCVCHorizontalStack.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        deleteCardButton.fillConstraints(
            top: cardMarkAndCardFunctionHorizontalStack.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: containerView.bottomAnchor,
            padding: .init(top: 32, left: 32, bottom: 16, right: 32),
            size: .init(width: 0, height: 60)
        )
        
        cardMarkLabel.fillConstraints(
            top: cardMarkView.topAnchor,
            leading: cardMarkView.leadingAnchor,
            trailing: cardMarkView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        cardMarkContentLabel.fillConstraints(
            top: cardMarkLabel.bottomAnchor,
            leading: cardMarkView.leadingAnchor,
            trailing: cardMarkView.trailingAnchor,
            bottom: cardMarkView.bottomAnchor,
            padding: .init(top: 8, left: 16, bottom: 16, right: 16)
        )
        
        cardFunctionLabel.fillConstraints(
            top: cardFunctionView.topAnchor,
            leading: cardFunctionView.leadingAnchor,
            trailing: cardFunctionView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        cardFunctionContentLabel.fillConstraints(
            top: cardFunctionLabel.bottomAnchor,
            leading: cardFunctionView.leadingAnchor,
            trailing: cardFunctionView.trailingAnchor,
            bottom: cardFunctionView.bottomAnchor,
            padding: .init(top: 8, left: 16, bottom: 16, right: 16)
        )
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.primaryColor
        scrollView.backgroundColor = Colors.primaryColor
    }
}

extension CardInformationView {
    private func makeVerticalStack(with views: [UIView], spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = spacing
        return stackView
    }
    
    private func makeHorizontalStack(with views: [UIView], spacing: CGFloat) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = spacing
        return stackView
    }
    
    private func makeInfoView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.backgroundColor = UIColor(hexString: "0A2647")
        return view
    }
}
