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
    
    func loadLatestContent()
    
    func loadGenre()
}

final class DiscoveryDefaultViewModel: DiscoveryViewModel {
    
    private let kind: DiscoveryKind
    
    private let disposeBag = DisposeBag()
    
    private let _thematics = BehaviorRelay<[ThematicData]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _isFetchingMore = BehaviorRelay<Bool>(value: false)
    private let _latestContent = BehaviorRelay<Content?>(value: nil)
    private let _genre = BehaviorRelay<[Genre]>(value: [])
    private var bagOfThematic: [ThematicData] = []
    private var bagOfGenre: [Genre] = []
    private var bagOfLatestContent: Content?
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var isFetchingMore: Driver<Bool> {
        return _isFetchingMore.asDriver()
    }
    
    var thematics: Driver<[ThematicData]> {
        return _thematics.asDriver()
    }
    
    var genres: Driver<[Genre]> {
        return _genre.asDriver()
    }
    
    var latestContent: Driver<Content?> {
        return _latestContent.asDriver()
    }
    
    var latestPosterImageUrl: String? {
        return String.init(format: "%@%@", APIConstant.baseImageUrl, bagOfLatestContent?.posterPath ?? "")
    }
    
    var latestGenreLabelText: String? {
        let genreIds = bagOfLatestContent?.genreIds ?? []
        let res = zip(bagOfGenre, genreIds).enumerated().filter{ $1.0.id == $1.1 }.map{ $1.0 }
        return res.compactMap{ $0.name ?? "-" }.joined(separator: " • ")
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
        bagOfThematic.removeAll()
        switch kind {
        case .movie:
            requestNowPlaying()
            requestPopular()
            requestTopRated()
            requestUpcoming()
        case .tv:
            requestOnTheAir()
            requestTVPopular()
            requestTVTopRated()
            requestAiringToday()
        }
    }
    
    func loadLatestContent() {
    }
    
    func loadGenre() {
        switch kind {
        case .movie:
            requestMovieGenre()
        case .tv:
            requestTVGenre()
        }
    }
    
    // MARK: - API Movie Request
    private func requestMovieGenre() {
        ApiManager.shared.genreService.request(target: .movie, mapper: GenreResponse.self) { [weak self] response in
            self?.bagOfGenre = response.genres ?? []
            self?._genre.accept(self?.bagOfGenre ?? [])
        } error: { error in
            print(error)
        }
    }
    
    private func requestNowPlaying() {
        ApiManager.shared.movieService.request(target: .nowPlaying, mapper: ResponsePageable<Movie>.self) { [weak self] pageable in
            let newData: ThematicData = ThematicData(thematic: MovieThematicKind.nowPlaying, content: pageable.results ?? [])
            self?.bagOfThematic.append(newData)
            self?.bagOfLatestContent = pageable.results?.first
            self?._latestContent.accept(self?.bagOfLatestContent)
            self?._genre.accept(self?.bagOfGenre ?? [])
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
    
    // MARK: - API TV Request
    private func requestTVGenre() {
        ApiManager.shared.genreService.request(target: .tv, mapper: GenreResponse.self) { [weak self] response in
            self?.bagOfGenre = response.genres ?? []
            self?._genre.accept(self?.bagOfGenre ?? [])
        } error: { error in
            print(error)
        }
    }
    
    private func requestAiringToday() {
        ApiManager.shared.tvService.request(target: .airingToday, mapper: ResponsePageable<TVSeries>.self) { [weak self] pageable in
            let newData: ThematicData = ThematicData(thematic: TVThematicKind.airingToday, content: pageable.results ?? [])
            self?.bagOfThematic.append(newData)
            self?._thematics.accept(self?.bagOfThematic ?? [])
        } error: { error in
            print(error)
        }
    }
    
    private func requestOnTheAir() {
        ApiManager.shared.tvService.request(target: .onTheAir, mapper: ResponsePageable<TVSeries>.self) { [weak self] pageable in
            let newData: ThematicData = ThematicData(thematic: TVThematicKind.onTheAir, content: pageable.results ?? [])
            self?.bagOfThematic.append(newData)
            self?.bagOfLatestContent = pageable.results?.first
            self?._latestContent.accept(self?.bagOfLatestContent)
            self?._genre.accept(self?.bagOfGenre ?? [])
            self?._thematics.accept(self?.bagOfThematic ?? [])
        } error: { error in
            print(error)
        }
    }
    
    private func requestTVTopRated() {
        ApiManager.shared.tvService.request(target: .topRated, mapper: ResponsePageable<TVSeries>.self) { [weak self] pageable in
            let newData: ThematicData = ThematicData(thematic: TVThematicKind.topRated, content: pageable.results ?? [])
            self?.bagOfThematic.append(newData)
            self?._thematics.accept(self?.bagOfThematic ?? [])
        } error: { error in
            print(error)
        }
    }
    
    private func requestTVPopular() {
        ApiManager.shared.tvService.request(target: .popular, mapper: ResponsePageable<TVSeries>.self) { [weak self] pageable in
            let newData: ThematicData = ThematicData(thematic: TVThematicKind.popular, content: pageable.results ?? [])
            self?.bagOfThematic.append(newData)
            self?._thematics.accept(self?.bagOfThematic ?? [])
        } error: { error in
            print(error)
        }
    }
}


