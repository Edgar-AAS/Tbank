import UIKit

public final class WelcomeViewController: UIViewController {
    lazy var customView: WelcomeView? = {
        return view as? WelcomeView
    }()

    public var goToLoginScreen: (() -> Void)?
    public var goTosignUpScreen: (() -> Void)?
    
    public override func loadView() {
        super.loadView()
        view = WelcomeView()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
        
    private func configure() {
        customView?.loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        customView?.registerButton.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc func loginButtonTapped() {
        goToLoginScreen?()
    }
    
    @objc func registerButtonTapped() {
        goTosignUpScreen?()
    }
}
