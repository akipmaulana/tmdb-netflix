//
//  BaseViewModel.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Foundation

protocol TMDBViewModel {
}

protocol VCViewModelProtocol {
    
    associatedtype ViewModel: TMDBViewModel
    
    var viewModel: ViewModel? { get set }
    
    func bindView(vm: ViewModel?)
}
