import Foundation
import UIKit

public class LoginView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .primaryColor
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.textColor = UIColor.white
        return label
    }()
    
    lazy var loginDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Acesse sua conta com email e senha"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.systemGray
        return label
    }()	
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.hidesWhenStopped = true
        loadingView.style = .large
        loadingView.color = .secundaryColor
        return loadingView
    }()
    
    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .secundaryColor
        button.setTitle("Entrar", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.tintColor = .primaryColor
        return button
    }()
    
    lazy var loginImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "login-logo")!)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var emailTextField = CustomTextField(placeholderText: "Digite seu email")
    lazy var passwordTextField = CustomTextField(placeholderText: "Digite sua senha")
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        emailTextField.addBottomLineWithColor(color: .secundaryColor, widht: 1)
        passwordTextField.addBottomLineWithColor(color: .secundaryColor, widht: 1)
        
        loginButton.layer.cornerRadius = loginButton.frame.height / 2
        loginButton.clipsToBounds = true
        
        emailTextField.setupLeftImageView(image: .envelopeImage())
        passwordTextField.setupLeftImageView(image: .lockImage())
    }
}

extension LoginView: CodeView {
    func buildViewHierarchy() {
        addSubview(contentView)
        contentView.addSubview(loginImageView)
        addSubview(loginLabel)
        addSubview(loginDescriptionLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(loadingIndicator)
    }
    
    func setupConstrains() {
        contentView.fillConstraints(
            top: safeAreaLayoutGuide.topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 0, bottom: 0, right: 0)
        )
    
        loginImageView.fillConstraints(
            top: contentView.topAnchor,
            leading: nil,
            trailing: nil,
            bottom: contentView.bottomAnchor,
            padding: .init(top: 16, left: 0, bottom: 24, right: 0)
        )
        
        loginImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        loginLabel.fillConstraints(
            top: contentView.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        loginDescriptionLabel.fillConstraints(
            top: loginLabel.bottomAnchor,
            leading: loginLabel.leadingAnchor,
            trailing: loginLabel.trailingAnchor,
            bottom: nil,
            padding: .init(top: 8, left: 0, bottom: 0, right: 0)
        )
        
        emailTextField.fillConstraints(
            top: loginDescriptionLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 44)
        )
        
        passwordTextField.fillConstraints(
            top: emailTextField.bottomAnchor,
            leading: emailTextField.leadingAnchor,
            trailing: emailTextField.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 44)
        )
        
        loginButton.fillConstraints(
            top: passwordTextField.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 32, bottom: 0, right: 32),
            size: .init(width: 0, height: 60)
        )
        
        loadingIndicator.fillConstraints(
            top: loginButton.bottomAnchor,
            leading: nil,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 32, left: 0, bottom: 0, right: 0),
            size: .init(width: 64, height: 64)
        )
        
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        configureTextFieldsOrder()
        setupKeyboardTypes()
    }
    
    private func setupKeyboardTypes() {
        emailTextField.keyboardType = .emailAddress
        passwordTextField.keyboardType = .asciiCapable
        passwordTextField.isSecureTextEntry = true
    }
    
    private func configureTextFieldsOrder() {
        emailTextField.tag = 1
        passwordTextField.tag = 2
    }
    
    func setupDelegateTextFields(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
    }
}
