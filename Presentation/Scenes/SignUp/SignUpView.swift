import Foundation
import UIKit

public class SignUpView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(hexString: "BEF0CB")
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var appImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "tree-frog"))
        return image
    }()
    
    lazy var createAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Criar conta"
        label.font = UIFont.boldSystemFont(ofSize: 48)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let loadingView = UIActivityIndicatorView()
        loadingView.hidesWhenStopped = true
        loadingView.style = .large
        loadingView.color = UIColor.systemGreen
        return loadingView
    }()
    
    lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexString: "68B984")
        button.tintColor = .black
        button.setTitle("Cadastrar", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var nameTextField = CustomTextField()
    lazy var emailTextField = CustomTextField()
    lazy var passwordTextField = CustomTextField()
    lazy var passwordConfirmationTextField = CustomTextField()
    
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        nameTextField.addBottomLineWithColor(color: .red, widht: 1)
        emailTextField.addBottomLineWithColor(color: .red, widht: 1)
        passwordTextField.addBottomLineWithColor(color: .red, widht: 1)
        passwordConfirmationTextField.addBottomLineWithColor(color: .red, widht: 1)
    }
}

extension SignUpView: CodeView {
    func buildViewHierarchy() {
        addSubview(appImage)
        addSubview(createAccountLabel)
        addSubview(nameTextField)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(passwordConfirmationTextField)
        addSubview(saveButton)
        addSubview(loadingIndicator)
    }
    
    func setupConstrains() {
        appImage.fillConstraints(
            top: safeAreaLayoutGuide.topAnchor,
            leading: nil,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 16, left: 0, bottom: 0, right: 0)
        )
        appImage.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        appImage.size(size: .init(width: 128, height: 128))
        
        createAccountLabel.fillConstraints(
            top: appImage.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16)
        )
        
        nameTextField.fillConstraints(
            top: createAccountLabel.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 44)
        )
        
        emailTextField.fillConstraints(
            top: nameTextField.bottomAnchor,
            leading: nameTextField.leadingAnchor,
            trailing: nameTextField.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 0, bottom: 0, right: 0),
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
        
        passwordConfirmationTextField.fillConstraints(
            top: passwordTextField.bottomAnchor,
            leading: passwordTextField.leadingAnchor,
            trailing: passwordTextField.trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 44)
        )
        
        saveButton.fillConstraints(
            top: passwordConfirmationTextField.bottomAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 16, left: 64, bottom: 0, right: 64),
            size: .init(width: 0, height: 56)
        )
        
        loadingIndicator.fillConstraints(
            top: saveButton.bottomAnchor,
            leading: nil,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 16, left: 0, bottom: 0, right: 0),
            size: .init(width: 44, height: 44)
        )
        loadingIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        setupKeyboardTypes()
        configureTextFieldsOrder()
    }
    
    private func setupKeyboardTypes() {
        nameTextField.keyboardType = .asciiCapable
        emailTextField.keyboardType = .emailAddress
        passwordTextField.keyboardType = .asciiCapable
        passwordConfirmationTextField.keyboardType = .asciiCapable
    }
    
    private func configureTextFieldsOrder() {
        nameTextField.tag = 1
        emailTextField.tag = 2
        passwordTextField.tag = 3
        passwordConfirmationTextField.tag = 4
    }
    
    func setupDelegateTextFields(delegate: UITextFieldDelegate) {
        nameTextField.delegate = delegate
        emailTextField.delegate = delegate
        passwordTextField.delegate = delegate
        passwordConfirmationTextField.delegate = delegate
    }
}
