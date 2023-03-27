import UIKit
import Infra
import Presentation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private let signUpFactory: () -> SignUpViewController = {
        let httpPostClient = makeNetworkPostClient()
        let addAccount = makeRemoteAddAccount(httpPostClient: httpPostClient)
        let controller = makeSignUpController(addAccount: addAccount)
        return controller
    }
    
    private let loginFactory: () -> LoginViewController = {
        let httpPostClient = makeNetworkPostClient()
        let authentication = makeRemoteAuthentication(httpClient: httpPostClient)
        let controller = makeLoginViewController(authentication: authentication)
        return controller
    }
        
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let welcomeController = WelcomeViewController()
        let welcomeRouter = WelcomeRouter(nav: Navigator.navigationController, loginFactory: loginFactory, signUpFactory: signUpFactory)
        welcomeController.goToLoginScreen = welcomeRouter.goToLogin
        welcomeController.goTosignUpScreen = welcomeRouter.goToSignUp
        Navigator.navigationController.setRootViewController(welcomeController)
        window?.rootViewController = Navigator.navigationController
        window?.makeKeyAndVisible()
    }
}
