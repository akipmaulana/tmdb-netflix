//
//  ReviewContentVC.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit
import RxSwift
import RxCocoa

class ReviewContentVC: BaseViewController, ViewModelProtocol {

    typealias ViewModel = ReviewContentDefaultViewModel
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var ratingTitleLabel: UILabel!
    @IBOutlet weak private var ratingValueLabel: UILabel!
    @IBOutlet weak private var voteTitleLabel: UILabel!
    @IBOutlet weak private var voteValueLabel: UILabel!
    
    private let disposeBag = DisposeBag()
    
    var viewModel: ReviewContentDefaultViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addBackNavBarButton()
        setupReviewRating()
        setupTitleVC()
        setupTableView()
        viewModel?.loadReviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        renderView()
    }

    func bindView(vm: ReviewContentDefaultViewModel?) {
        viewModel = vm
        
        viewModel?.reviews.drive(onNext: {[unowned self] (_) in
            self.tableView?.reloadData()
        }).disposed(by: disposeBag)
    }

    func renderView() {
        ratingValueLabel?.text = viewModel?.contentRatingLabelText
        voteValueLabel?.text = viewModel?.contentVotingLabelText
    }
}

extension ReviewContentVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfReview ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ReviewBoxTableCell
        cell.bindView(vm: ReviewBoxDefaultViewModel(review: viewModel?.getSafeReview(at: indexPath.row)))
        return cell
    }
}

private extension ReviewContentVC {
    // MARK: - Setup View
    func setupTitleVC() {
        title = "Ratings & Reviews"
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont.sourceSansProSemiBold(size: .title),
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ]
    }
    
    func setupReviewRating() {
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
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView?.register(ReviewBoxTableCell.self)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 8))
        tableView.tableHeaderView = UIView(frame: CGRect.zero)
    }
}
