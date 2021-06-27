//
//  PosterCollectionCell.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit
import SDWebImage

class PosterCollectionCell: UICollectionViewCell, LoadableReusableView, ViewModelProtocol {
    var viewModel: PosterDefaultViewModel?
    
    typealias ViewModel = PosterDefaultViewModel
    
    @IBOutlet weak private var posterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupImageView()
    }
    
    func bindView(vm: PosterDefaultViewModel?) {
        viewModel = vm
        posterImageView?.sd_setImage(with: URL(string: vm?.posterUrl ?? ""))
    }

    // MARK: - Private Setup
    private func setupImageView() {
        posterImageView.layer.cornerRadius = 6.0
        posterImageView.clipsToBounds = true
    }
}
