import UIKit
import Infra
import UI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
//        let authentication = makeRemoteAuthentication(httpClient: makeNetworkGetClient())
        window?.rootViewController = WelcomeViewController()
        window?.makeKeyAndVisible()
    }
}
