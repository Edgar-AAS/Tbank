import UIKit
import Infra
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    private let signUpFactory: () -> SignUpViewController = {
        let httpPostClient = makeNetworkPostClient()
        let addAccount = makeRemoteAddAccount(httpPostClient: httpPostClient)
        let controller = makeSignUpController(addAccount: addAccount)
        return controller
    }
    
    private let loginFactory: () -> LoginViewController = {
        let httpGetClient = makeNetworkGetClient()
        let authentication = makeRemoteAuthentication(httpClient: httpGetClient)
        let controller = makeLoginViewController(authentication: authentication)
        return controller
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let nav = NavigationController()
        let welcomeRouter = WelcomeRouter(nav: nav, loginFactory: loginFactory, signUpFactory: signUpFactory)
        let welcomeController = WelcomeViewController()
        welcomeController.signUp = welcomeRouter.goToSignUp
        welcomeController.login = welcomeRouter.goToLogin
        nav.setRootViewController(welcomeController)
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}
