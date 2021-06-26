//
//  PortalVC.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 26/06/21.
//  
//

import UIKit

class PortalVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        requestDiscoverMovie()
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
}
