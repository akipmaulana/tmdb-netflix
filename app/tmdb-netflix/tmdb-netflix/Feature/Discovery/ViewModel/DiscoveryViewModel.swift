//
//  DiscoveryViewModel.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Foundation
import RxSwift
import RxCocoa

protocol DiscoveryViewModel: TMDBViewModel {
    init(kind: DiscoveryKind)
    
    var titleDomainLabelText: String { get }
    
    func getSafeThematic(at position: Int) -> ThematicData?
    
    func loadDiscoveryData()
}

final class DiscoveryDefaultViewModel: DiscoveryViewModel {
    
    private let kind: DiscoveryKind
    
    private let disposeBag = DisposeBag()
    
    private let _thematics = BehaviorRelay<[ThematicData]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _isFetchingMore = BehaviorRelay<Bool>(value: false)
    private var bagOfThematic: [ThematicData] = []
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var isFetchingMore: Driver<Bool> {
        return _isFetchingMore.asDriver()
    }
    
    var thematics: Driver<[ThematicData]> {
        return _thematics.asDriver()
    }
    
    var titleDomainLabelText: String {
        switch kind {
        case .movie:
            return "Movie"
        case .tv:
            return "TV Series"
        }
    }
    
    var numberOfThematics: Int {
        return _thematics.value.count
    }
    
    init(kind: DiscoveryKind) {
        self.kind = kind
    }
    
    func getSafeThematic(at position: Int) -> ThematicData? {
        if _thematics.value.indices.contains(position) {
            return _thematics.value[position]
        } else {
            return nil
        }
    }
    
    func loadDiscoveryData() {
        requestNowPlaying()
        requestPopular()
        requestTopRated()
        requestUpcoming()
    }
    
    // MARk: - Movie Thematics Request
    private func requestNowPlaying() {
        ApiManager.shared.movieService.request(target: .nowPlaying, mapper: ResponsePageable<Movie>.self) { [weak self] pageable in
            let newData: ThematicData = ThematicData(thematic: MovieThematicKind.nowPlaying, content: pageable.results ?? [])
            self?.bagOfThematic.append(newData)
            self?._thematics.accept(self?.bagOfThematic ?? [])
        } error: { error in
            print(error)
        }
    }
    
    private func requestPopular() {
        ApiManager.shared.movieService.request(target: .popular, mapper: ResponsePageable<Movie>.self) { [weak self] pageable in
            let newData: ThematicData = ThematicData(thematic: MovieThematicKind.popular, content: pageable.results ?? [])
            self?.bagOfThematic.append(newData)
            self?._thematics.accept(self?.bagOfThematic ?? [])
        } error: { error in
            print(error)
        }
    }
    
    private func requestTopRated() {
        ApiManager.shared.movieService.request(target: .topRated, mapper: ResponsePageable<Movie>.self) { [weak self] pageable in
            let newData: ThematicData = ThematicData(thematic: MovieThematicKind.topRated, content: pageable.results ?? [])
            self?.bagOfThematic.append(newData)
            self?._thematics.accept(self?.bagOfThematic ?? [])
        } error: { error in
            print(error)
        }
    }
    
    private func requestUpcoming() {
        ApiManager.shared.movieService.request(target: .upcoming, mapper: ResponsePageable<Movie>.self) { [weak self] pageable in
            let newData: ThematicData = ThematicData(thematic: MovieThematicKind.upcoming, content: pageable.results ?? [])
            self?.bagOfThematic.append(newData)
            self?._thematics.accept(self?.bagOfThematic ?? [])
        } error: { error in
            print(error)
        }
    }
}


