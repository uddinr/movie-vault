import Foundation
import UIKit

class BaseNavigationController: UINavigationController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .backgroundSecondary
        navigationBar.standardAppearance = appearance;
        navigationBar.scrollEdgeAppearance = navigationBar.standardAppearance
        
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: .navTitleFontSize, weight: .bold),
                                                  NSAttributedString.Key.foregroundColor: UIColor.textPrimary]
    }
}
