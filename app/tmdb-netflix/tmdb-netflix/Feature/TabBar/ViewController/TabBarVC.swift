//
//  TabBarVC.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit

protocol TabBarScreen {
    
}

final class TabBarVC: UITabBarController {
    var movieHubVC: DiscoveryVC = {
        let vc = DiscoveryVC()
        vc.bindView(vm: DiscoveryDefaultViewModel(kind: .movie))
        return vc
    }()
    var tvHubVC: DiscoveryVC = {
        let vc = DiscoveryVC()
        vc.bindView(vm: DiscoveryDefaultViewModel(kind: .tv))
        return vc
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prepareUI()
        self.prepareNVC()
    }
    
    override var shouldAutorotate: Bool {
        if let selectedVC = selectedViewController {
            return selectedVC.shouldAutorotate
        }
        return super.shouldAutorotate
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if let selectedVC = selectedViewController {
            return selectedVC.supportedInterfaceOrientations
        }
        return super.supportedInterfaceOrientations
    }
    
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        if let selectedVC = selectedViewController {
            return selectedVC.preferredInterfaceOrientationForPresentation
        }
        return super.preferredInterfaceOrientationForPresentation
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let _ = self.viewControllers?[(tabBar.items?.index(of: item))!]
    }
    
    private func prepareUI() {
        view.backgroundColor = .black
        tabBar.tintColor = .white
        if #available(iOS 10.0, *) {
            tabBar.unselectedItemTintColor = UIColor.whiteSmoke.withAlphaComponent(0.8)
        }
        tabBar.barTintColor = UIColor.black
        tabBar.isTranslucent = true
    }
    
    private func prepareNVC() {
        let tabOneNVC = self.createNavigationController(title: "Movie", icon: UIImage(named: "icon-movie")!, vc: movieHubVC)
        let tabTwoNVC = self.createNavigationController(title: "TV Series", icon: UIImage(named: "icon-tv-series")!, vc: tvHubVC)
        self.viewControllers = [tabOneNVC, tabTwoNVC]
    }
    
    private func createNavigationController(title: String, icon: UIImage, vc: BaseViewController) -> BaseNavigationController {
        let nvc = BaseNavigationController(rootViewController: vc)
        nvc.title = title
        nvc.tabBarItem.setTitleTextAttributes([
            NSAttributedString.Key.font: UIFont.sourceSansProRegular(size: .overline),
            ], for: .normal)
        nvc.tabBarItem.image = icon
        nvc.tabBarItem.selectedImage = icon.withRenderingMode(.alwaysOriginal)
        return nvc
    }
}
