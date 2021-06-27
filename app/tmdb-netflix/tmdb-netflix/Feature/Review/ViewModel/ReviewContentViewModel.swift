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
    
    func loadMore()
    
    func getSafeReview(at position: Int) -> Review?
}

final class ReviewContentDefaultViewModel: ReviewContenViewModel {
    
    private let content: Content?
    
    private let _reviews = BehaviorRelay<[Review]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private var bagOfReviews: [Review] = []
    private var bagOfPageable: ResponsePageable<Review>?
    private var canLoadMore: Bool = true
    private var page: Int = 1
    
    init(content: Content?) {
        self.content = content
    }
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
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
    
    func loadMore() {
        guard _isFetching.value == false else { return }
        guard let page = bagOfPageable?.page, let total = bagOfPageable?.totalPages, page < total else { return }
        self.page = page + 1
        _isFetching.accept(true)
        loadReviews()
    }
    
    func getSafeReview(at position: Int) -> Review? {
        if bagOfReviews.indices.contains(position) {
            return bagOfReviews[position]
        }
        return nil
    }
    
    private func loadMovieReviews() {
        ApiManager.shared.movieService.request(target: .review(id: content?.id ?? 0, parameters: ["page": page]), mapper: ResponsePageable<Review>.self) { [weak self] pageable in
            self?._isFetching.accept(false)
            self?.bagOfPageable = pageable
            self?.bagOfReviews.append(contentsOf: pageable.results ?? [])
            self?._reviews.accept(self?.bagOfReviews ?? [])
        } error: { [weak self] error in
            self?._isFetching.accept(false)
            print(error)
        }
    }
    
    private func loadTVReviews() {
        ApiManager.shared.tvService.request(target: .review(id: content?.id ?? 0, parameters: ["page": page]), mapper: ResponsePageable<Review>.self) { [weak self] pageable in
            self?._isFetching.accept(false)
            self?.bagOfPageable = pageable
            self?.bagOfReviews.append(contentsOf: pageable.results ?? [])
            self?._reviews.accept(self?.bagOfReviews ?? [])
        } error: { [weak self] error in
            self?._isFetching.accept(false)
            print(error)
        }
    }
}
