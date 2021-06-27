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
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    // MARK: - Setup Base View Func
    func addBackNavBarButton() {
        let back = UIBarButtonItem(image: UIImage(named: "icon-back")?.withRenderingMode(.alwaysTemplate), style: .done, target: self, action: #selector(arrowLeftButtonTapped))
        navigationItem.leftBarButtonItems = [back]
        navigationController?.navigationBar.tintColor = .white
    }
    
    // MARK: - Action Funcs
    @objc func presentLandingPage(vc: UIViewController, completion: (() -> Void)? = nil) {
        vc.modalPresentationStyle = .fullScreen
        guard let topViewController = UIApplication.topViewController() else {
            self.present(vc, animated: true, completion: completion)
            return
        }
        topViewController.present(vc, animated: true, completion: completion)
    }
    
    @objc private func arrowLeftButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
