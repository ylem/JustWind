import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private lazy var navigationController: UINavigationController =  {
        let viewController = UIViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        return navigationController
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureAppCoordinator()
        configureNavigationBarLayout()
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    private func configureAppCoordinator() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let coordinator = CoordinatorBuilder().app(presenter: navigationController,
                                                   window: window)
        coordinator.start()
    }
    
    private func configureNavigationBarLayout() {
        UINavigationBar.appearance().barTintColor = .white
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().prefersLargeTitles = true
    }
}

