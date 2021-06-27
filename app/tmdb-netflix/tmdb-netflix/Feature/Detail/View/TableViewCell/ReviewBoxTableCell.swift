//
//  ReviewBoxTableCell.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit
import SDWebImage

class ReviewBoxTableCell: UITableViewCell, LoadableReusableView, ViewModelProtocol {

    typealias ViewModel = ReviewBoxDefaultViewModel
    
    var viewModel: ReviewBoxDefaultViewModel?
    
    @IBOutlet weak private var foundationView: UIView!
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private var dateLabel: UILabel!
    @IBOutlet weak private var contentLabel: UILabel!
    @IBOutlet weak private var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupLabels()
        setupAvatarImageView()
        setupFoundationView()
    }

    func bindView(vm: ReviewBoxDefaultViewModel?) {
        viewModel = vm
        nameLabel?.text = viewModel?.nameLabelText
        dateLabel?.text = viewModel?.dateLabelText
        contentLabel?.text = viewModel?.contentLabelText
        avatarImageView?.sd_setImage(with: URL(string: viewModel?.avatarUrl ?? ""))
    }

}

private extension ReviewBoxTableCell {
    // MARK: - Setup View
    func setupLabels() {
        nameLabel?.font = .sourceSansProSemiBold(size: .subtitle1)
        nameLabel?.textColor = .white
        nameLabel?.numberOfLines = 0
        nameLabel?.text = ""
        
        dateLabel?.font = .sourceSansProRegular(size: .subtitle2)
        dateLabel?.textColor = .white
        dateLabel?.numberOfLines = 0
        dateLabel?.text = ""
        
        contentLabel?.font = .sourceSansProRegular(size: .body)
        contentLabel?.textColor = .white
        contentLabel?.numberOfLines = 0
        contentLabel?.text = ""
    }
    
    func setupAvatarImageView() {
        avatarImageView.layer.cornerRadius = 32
    }
    
    func setupFoundationView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        foundationView?.backgroundColor = .charcoalGrey
        foundationView?.layer.cornerRadius = 8.0
    }
}
