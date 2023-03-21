import UIKit

final class WelcomeView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .darkGray
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexString: "68B984")
        button.tintColor = .black
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = 10
        return button
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(hexString: "68B984")
        button.tintColor = .black
        button.setTitle("Cadastrar", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.layer.cornerRadius = 10
        return button
    }()
}

extension WelcomeView: CodeView {
    func buildViewHierarchy() {
        addSubview(loginButton)
        addSubview(registerButton)
    }
    
    func setupConstrains() {
        loginButton.fillConstraints(
            top: nil,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 32, bottom: 0, right: 32),
            size: .init(width: 0, height: 60)
        )
        
        loginButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        registerButton.fillConstraints(
            top: loginButton.bottomAnchor,
            leading: loginButton.leadingAnchor,
            trailing: loginButton.trailingAnchor,
            bottom: nil,
            padding: .init(top: 32, left: 0, bottom: 0, right: 0),
            size: .init(width: 0, height: 60)
        )
    }
}
