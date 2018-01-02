import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let viewController = ObjectViewController()
        viewController.tabBarItem = UITabBarItem(title: "Object Page", image: nil, tag: 0)

        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [viewController]

        let navigationController = UINavigationController(rootViewController: tabbarController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}

