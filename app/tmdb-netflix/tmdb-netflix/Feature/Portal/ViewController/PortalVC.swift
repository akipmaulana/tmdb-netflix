//
//  PortalVC.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import UIKit

class PortalVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        openLandingPage()
    }

    func requestDiscoverMovie() {
        ApiManager.shared.discoverService.request(target: .movie(parameter: [:]), mapper: ResponsePageable<Movie>.self) { pageable in
            print(pageable)
        } error: { error in
            print(error)
        }
    }
    
    func requestDiscoverTv() {
        
    }
    
    func openLandingPage() {
        let tabBarVC: TabBarVC = TabBarVC()
        presentLandingPage(vc: tabBarVC, completion: nil)
    }
}
