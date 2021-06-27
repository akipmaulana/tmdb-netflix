//
//  DetailContentVC.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit

class DetailContentVC: BaseViewController, ViewModelProtocol {
    var viewModel: DetailContentDefaultViewModel?

    typealias ViewModel = DetailContentDefaultViewModel
    
    @IBOutlet weak private var foundationPlayerView: UIView!
    @IBOutlet weak private var coverTrailerView: UIView!
    @IBOutlet weak private var trailerLabel: UILabel!
    @IBOutlet weak private var domainLabel: UILabel!
    @IBOutlet weak private var contentTitleLabel: UILabel!
    @IBOutlet weak private var contentStatusLabel: UILabel!
    @IBOutlet weak private var contentReleasedLabel: UILabel!
    @IBOutlet weak private var contentDurationLabel: UILabel!
    @IBOutlet weak private var contentOverviewLabel: UILabel!
    @IBOutlet weak private var sectionTitleReviewLabel: UILabel!
    @IBOutlet weak private var sectionTitlePictureLabel: UILabel!
    @IBOutlet weak private var sectionReviewView: UIView!
    @IBOutlet weak private var sectionPictureView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackNavBarButton()
        setupTitleVC()
        setupHeaderView()
        setupBasicInformationView()
    }

    func bindView(vm: DetailContentDefaultViewModel?) {
        viewModel = vm
    }

}

private extension DetailContentVC {
    // MARK: - Setup View
    func setupTitleVC() {
        title = "Life of PI"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.sourceSansProSemiBold(size: .title),
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ]
    }
    
    func setupHeaderView() {
        coverTrailerView?.layer.cornerRadius = 6.0
        coverTrailerView?.backgroundColor = .charcoalGrey
        trailerLabel?.font = .sourceSansProSemiBold(size: .subtitle2)
        trailerLabel?.textColor = .white
        trailerLabel?.text = "Trailer"
    }
    
    func setupBasicInformationView() {
        domainLabel?.font = .sourceSansProSemiBold(size: .caption)
        domainLabel?.textColor = .matterhorn
        domainLabel?.text = "M O V I E"
        domainLabel?.numberOfLines = 0
        
        contentTitleLabel?.font = .sourceSansProBold(size: .h5)
        contentTitleLabel?.textColor = .white
        contentTitleLabel?.text = "Wish Dradon"
        contentTitleLabel?.numberOfLines = 0
        
        contentStatusLabel?.font = .sourceSansProSemiBold(size: .caption)
        contentStatusLabel?.textColor = .googleGreen
        contentStatusLabel?.text = "Released"
        contentStatusLabel?.numberOfLines = 0
        
        contentReleasedLabel?.font = .sourceSansProRegular(size: .caption)
        contentReleasedLabel?.textColor = .whiteSmoke
        contentReleasedLabel?.text = "27 December 2022"
        contentReleasedLabel?.numberOfLines = 0
        contentReleasedLabel?.textAlignment = .center
        
        contentDurationLabel?.font = .sourceSansProRegular(size: .caption)
        contentDurationLabel?.textColor = .whiteSmoke
        contentDurationLabel?.text = "Adult"
        contentDurationLabel?.numberOfLines = 0
        contentDurationLabel?.textAlignment = .right
        
        contentOverviewLabel?.font = .sourceSansProRegular(size: .body)
        contentOverviewLabel?.textColor = UIColor.white
        contentOverviewLabel?.text = "When the aging Meyer Lansky is investigated one last time by the Feds who suspect he has stashed away millions of dollars over half a century, the retired gangster spins a dizzying tale, revealing the untold truth about his life as the notorious boss of Murder Inc. and the National Crime Syndicate."
        contentOverviewLabel?.numberOfLines = 0
    }
}
