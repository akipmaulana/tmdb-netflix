//
//  MThematicTableCell.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit

class MThematicTableCell: UITableViewCell, LoadableReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFoundationView()
        setupLabels()
    }
    
}

private extension MThematicTableCell {
    func setupFoundationView() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear
    }
    
    func setupLabels() {
        titleLabel?.font = .sourceSansProBold(size: .subtitle1)
        titleLabel?.textColor = .whiteSmoke
        titleLabel?.numberOfLines = 0
        titleLabel?.text = "Trending Now"
    }
}
