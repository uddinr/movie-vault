import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupFont()
        setupUI()
        return true
    }
    
    private func setupFont(){
        UIFont.overrideInitialize()
    }
    
    private func setupUI(){
        let moviesView = MoviesListViewController()
        let moviesNav = MoviesListNavigationController(rootViewController: moviesView)
        
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.tintColor = UIColor.tintColor
        window?.rootViewController = moviesNav
        window?.makeKeyAndVisible()
    }
}

