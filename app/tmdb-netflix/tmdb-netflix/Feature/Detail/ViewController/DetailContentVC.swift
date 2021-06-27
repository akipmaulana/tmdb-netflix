//
//  DetailContentVC.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit
import RxSwift
import RxCocoa

class DetailContentVC: BaseViewController, ViewModelProtocol {
    var viewModel: DetailContentDefaultViewModel?

    typealias ViewModel = DetailContentDefaultViewModel
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak private var decorationView: UIView!
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var foundationPlayerView: UIView!
    @IBOutlet weak private var posterImageView: UIImageView!
    @IBOutlet weak private var coverTrailerView: UIView!
    @IBOutlet weak private var trailerLabel: UILabel!
    @IBOutlet weak private var domainLabel: UILabel!
    @IBOutlet weak private var contentTitleLabel: UILabel!
    @IBOutlet weak private var contentStatusLabel: UILabel!
    @IBOutlet weak private var contentReleasedLabel: UILabel!
    @IBOutlet weak private var contentDurationLabel: UILabel!
    @IBOutlet weak private var contentOverviewLabel: UILabel!
    @IBOutlet weak private var sectionTitleReviewLabel: UILabel!
    @IBOutlet weak private var sectionReviewView: UIView!
    @IBOutlet weak private var seeMoreButton: UIButton!
    @IBOutlet weak private var ratingTitleLabel: UILabel!
    @IBOutlet weak private var ratingValueLabel: UILabel!
    @IBOutlet weak private var voteTitleLabel: UILabel!
    @IBOutlet weak private var voteValueLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        addBackNavBarButton()
        //setupTitleVC()
        setupHeaderView()
        setupBasicInformationView()
        setupReviewRating()
        setupButtons()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        renderData()
    }

    func bindView(vm: DetailContentDefaultViewModel?) {
        viewModel = vm
    }

    func renderData() {
        posterImageView?.sd_setImage(with: URL(string: viewModel?.posterImageUrl ?? ""))
        domainLabel?.text = viewModel?.domainLabelText
        contentTitleLabel?.text = viewModel?.contentTitleLabelText
        contentStatusLabel?.text = viewModel?.contentStatusLabelText
        contentReleasedLabel?.text = viewModel?.contentReleasedLabelText
        contentDurationLabel?.text = viewModel?.contentAdultLabelText
        contentOverviewLabel?.text = viewModel?.contentOverviewLabelText
        ratingValueLabel?.text = viewModel?.contentRatingLabelText
        voteValueLabel?.text = viewModel?.contentVotingLabelText
    }
}

private extension DetailContentVC {
    // MARK: - Setup View
    
    func setupScrollView() {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
        scrollView.contentOffset = .zero
        scrollView.showsVerticalScrollIndicator = false
    }
    
    func setupHeaderView() {
        coverTrailerView?.isHidden = true
        coverTrailerView?.layer.cornerRadius = 6.0
        coverTrailerView?.backgroundColor = .charcoalGrey
        trailerLabel?.font = .sourceSansProSemiBold(size: .subtitle2)
        trailerLabel?.textColor = .white
        trailerLabel?.text = "Trailer"
        
        decorationView?.backgroundColor = .clear
        decorationView?.applyGradient(withColours: [.clear, UIColor.black.withAlphaComponent(0.8), .black], gradientOrientation: .vertical)
    }
    
    func setupBasicInformationView() {
        domainLabel?.font = .sourceSansProSemiBold(size: .caption)
        domainLabel?.textColor = .matterhorn
        domainLabel?.text = ""
        domainLabel?.numberOfLines = 0
        
        contentTitleLabel?.font = .sourceSansProBold(size: .h5)
        contentTitleLabel?.textColor = .white
        contentTitleLabel?.text = ""
        contentTitleLabel?.numberOfLines = 0
        
        contentStatusLabel?.font = .sourceSansProSemiBold(size: .caption)
        contentStatusLabel?.textColor = .googleGreen
        contentStatusLabel?.text = ""
        contentStatusLabel?.numberOfLines = 0
        
        contentReleasedLabel?.font = .sourceSansProRegular(size: .caption)
        contentReleasedLabel?.textColor = .whiteSmoke
        contentReleasedLabel?.text = ""
        contentReleasedLabel?.numberOfLines = 0
        contentReleasedLabel?.textAlignment = .center
        
        contentDurationLabel?.font = .sourceSansProRegular(size: .caption)
        contentDurationLabel?.textColor = .whiteSmoke
        contentDurationLabel?.text = ""
        contentDurationLabel?.numberOfLines = 0
        contentDurationLabel?.textAlignment = .right
        
        contentOverviewLabel?.font = .sourceSansProRegular(size: .body)
        contentOverviewLabel?.textColor = UIColor.white
        contentOverviewLabel?.text = ""
        contentOverviewLabel?.numberOfLines = 0
        
        sectionTitleReviewLabel?.font = .sourceSansProSemiBold(size: .h6)
        sectionTitleReviewLabel?.textColor = UIColor.white
        sectionTitleReviewLabel?.text = "Reviews & Rating"
        sectionTitleReviewLabel?.numberOfLines = 0
    }
    
    func setupReviewRating() {
        sectionReviewView?.backgroundColor = .clear
        
        ratingValueLabel?.font = .sourceSansProSemiBold(size: .h4)
        ratingValueLabel?.textColor = UIColor.white
        ratingValueLabel?.text = ""
        ratingValueLabel?.numberOfLines = 0
        
        ratingTitleLabel?.font = .sourceSansProRegular(size: .title)
        ratingTitleLabel?.textColor = UIColor.white
        ratingTitleLabel?.text = "Out of 10"
        ratingTitleLabel?.numberOfLines = 0
        
        voteValueLabel?.font = .sourceSansProSemiBold(size: .h4)
        voteValueLabel?.textColor = UIColor.white
        voteValueLabel?.text = ""
        voteValueLabel?.numberOfLines = 0
        
        voteTitleLabel?.font = .sourceSansProRegular(size: .title)
        voteTitleLabel?.textColor = UIColor.white
        voteTitleLabel?.text = "Vote Count"
        voteTitleLabel?.numberOfLines = 0
    }
    
    func setupButtons() {
        seeMoreButton?.titleLabel?.font = .sourceSansProSemiBold(size: .subtitle2)
        seeMoreButton?.setTitleColor(.link, for: .normal)
        seeMoreButton?.setTitle("See More", for: .normal)
        seeMoreButton?.addTarget(self, action: #selector(didTapSeeMore(_:)), for: .touchUpInside)
    }
    
    @objc func didTapSeeMore(_ button: UIButton) {
        let reviewVC = ReviewContentVC()
        reviewVC.bindView(vm: ReviewContentDefaultViewModel(content: viewModel?.content))
        navigationController?.pushViewController(reviewVC, animated: true)
    }
}
