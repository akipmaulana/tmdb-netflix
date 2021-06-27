//
//  ReviewContentVC.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit

class ReviewContentVC: BaseViewController, ViewModelProtocol {

    typealias ViewModel = ReviewContentDefaultViewModel
    
    var viewModel: ReviewContentDefaultViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func bindView(vm: ReviewContentDefaultViewModel?) {
        
    }

}
