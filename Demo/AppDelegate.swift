//
//  Copyright © FINN.no AS, Inc. All rights reserved.
//

import Paw
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let viewController = DemoViewController()

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.tabBarItem = UITabBarItem(title: "Paw", image: nil, tag: 0)

        let navigationBarApperance = UINavigationBar.appearance()
        navigationBarApperance.tintColor = .primaryBlue

        let tabbarController = UITabBarController()
        tabbarController.viewControllers = [navigationController]

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = tabbarController
        window?.makeKeyAndVisible()

        return true
    }
}
