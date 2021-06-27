//
//  AppExtension.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit

extension UIApplication {
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(viewController: nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(viewController: presented)
        }
        return viewController
    }
}

extension UIView {
    func applyGradient(withColours colours: [UIColor], gradientOrientation orientation: GradientOrientation, radius: CGFloat = 0) {
        clearGradient()
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.name = Tag.gradientLayer
        gradient.frame = self.bounds
        gradient.cornerRadius = radius
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func clearGradient() {
        self.layer.sublayers?.removeAll(where: { ($0.name ?? "") == Tag.gradientLayer })
    }
}
