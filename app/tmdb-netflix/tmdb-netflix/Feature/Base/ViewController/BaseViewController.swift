//
//  BaseViewController.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
    }
    
    @objc func presentLandingPage(vc: UIViewController, completion: (() -> Void)? = nil) {
        vc.modalPresentationStyle = .fullScreen
        guard let topViewController = UIApplication.topViewController() else {
            self.present(vc, animated: true, completion: completion)
            return
        }
        topViewController.present(vc, animated: true, completion: completion)
    }
}
