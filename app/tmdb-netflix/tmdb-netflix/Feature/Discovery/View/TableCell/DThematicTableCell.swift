//
//  MThematicTableCell.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit

class DThematicTableCell: UITableViewCell, LoadableReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupFoundationView()
        setupLabels()
        setupCollectionView()
    }
    
}

extension DThematicTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as PosterCollectionCell
        return cell
    }
}

private extension DThematicTableCell {
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
    
    private func setupCollectionView() {
        let height: CGFloat = 128
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: height * 0.69, height: height)
        flowLayout.minimumInteritemSpacing = 8
        flowLayout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flowLayout
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PosterCollectionCell.self)
    }
}
