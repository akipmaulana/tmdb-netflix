//
//  PosterCollectionCell.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit

class PosterCollectionCell: UICollectionViewCell, LoadableReusableView  {
    
    @IBOutlet weak private var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
    }

    // MARK: - Private Setup
    private func setupImageView() {
        posterImageView.layer.cornerRadius = 6.0
        posterImageView.clipsToBounds = true
    }
}
