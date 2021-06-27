//
//  ReviewContentViewModel.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import Foundation
import RxSwift
import RxCocoa

protocol ReviewContenViewModel: TMDBViewModel {
    init(content: Content?)
    
    var contentRatingLabelText: String? { get }
    var contentVotingLabelText: String? { get }
    
    func loadReviews()
    
    func getSafeReview(at position: Int) -> Review?
}

final class ReviewContentDefaultViewModel: ReviewContenViewModel {
    
    private let content: Content?
    
    private let _reviews = BehaviorRelay<[Review]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _isFetchingMore = BehaviorRelay<Bool>(value: false)
    private var bagOfReviews: [Review] = []
    
    init(content: Content?) {
        self.content = content
    }
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var isFetchingMore: Driver<Bool> {
        return _isFetchingMore.asDriver()
    }
    
    var reviews: Driver<[Review]> {
        return _reviews.asDriver()
    }
    
    var numberOfReview: Int {
        return bagOfReviews.count
    }
    
    var contentRatingLabelText: String? {
        return "\(content?.voteAverage ?? 0)"
    }
    
    var contentVotingLabelText: String? {
        return "\(content?.voteCount ?? 0)"
    }
    
    func loadReviews() {
        if content is Movie {
            loadMovieReviews()
        } else {
            loadTVReviews()
        }
    }
    
    func getSafeReview(at position: Int) -> Review? {
        if bagOfReviews.indices.contains(position) {
            return bagOfReviews[position]
        }
        return nil
    }
    
    private func loadMovieReviews() {
        ApiManager.shared.movieService.request(target: .review(id: content?.id ?? 0, parameters: ["page": 1]), mapper: ResponsePageable<Review>.self) { [weak self] pageable in
            self?.bagOfReviews.append(contentsOf: pageable.results ?? [])
            self?._reviews.accept(self?.bagOfReviews ?? [])
        } error: { error in
            print(error)
        }
    }
    
    private func loadTVReviews() {
        ApiManager.shared.tvService.request(target: .review(id: content?.id ?? 0, parameters: ["page": 1]), mapper: ResponsePageable<Review>.self) { [weak self] pageable in
            self?.bagOfReviews.append(contentsOf: pageable.results ?? [])
            self?._reviews.accept(self?.bagOfReviews ?? [])
        } error: { error in
            print(error)
        }
    }
}
