import UIKit

final class WelcomeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.primaryColor
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    lazy var welcomeLabel: UILabel = .descriptionLabel(titleText: "Seja bem-vindo ao Any26", subtitleText: nil, titleFontSize: 30, titleColor: .white)
    
    
    lazy var appLogoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bank-logo"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Colors.secundaryColor
        button.tintColor = Colors.primaryColor
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = Colors.secundaryColor
        button.tintColor = Colors.primaryColor
        button.setTitle("Cadastrar-se", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        return button
    }()
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        registerButton.layer.cornerRadius = registerButton.frame.height / 2
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        
        loginButton.clipsToBounds = true
        registerButton.clipsToBounds = true
    }
}

extension WelcomeView: CodeView {
    func buildViewHierarchy() {
        addSubview(appLogoImageView)
        addSubview(welcomeLabel)
        addSubview(loginButton)
        addSubview(registerButton)
    }
    
    func setupConstrains() {
        appLogoImageView.fillConstraints(
            top: topAnchor,
            leading: nil,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 16, left: 0, bottom: 0, right: 0),
            size: .init(width: 200, height: 200)
        )
        
        appLogoImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        loginButton.fillConstraints(
            top: appLogoImageView.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 32, bottom: 0, right: 32),
            size: .init(width: 0, height: 60)
        )

        registerButton.fillConstraints(
            top: loginButton.bottomAnchor,
            leading: loginButton.leadingAnchor,
            trailing: loginButton.trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 60)
        )
    }
    
    func setupAdditionalConfiguration() {
        welcomeLabel.textAlignment = .center
    }
    
}
