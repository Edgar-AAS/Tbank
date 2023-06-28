import UIKit
import Infra
import Presentation

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    private let loginFactory: () -> LoginViewController = {
        let httpPostClient = makeNetworkPostClient()
        let authentication = makeRemoteAuthentication(httpClient: httpPostClient)
        let controller = makeLoginViewController(authentication: authentication)
        return controller
    }
        
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = NavigationController()
        navigationController.setRootViewController(TransferSuccessViewController())
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
