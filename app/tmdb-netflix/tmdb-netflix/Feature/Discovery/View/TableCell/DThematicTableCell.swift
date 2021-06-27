//
//  MThematicTableCell.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit

protocol DThematicTableCellDelegate: AnyObject {
    func dthematicTableCell(_ cell: DThematicTableCell, didTap poster: Content?)
}

class DThematicTableCell: UITableViewCell, LoadableReusableView, ViewModelProtocol {
    
    typealias ViewModel = DThematiceDefaultViewModel
    
    internal var viewModel: DThematiceDefaultViewModel?

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: DThematicTableCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        setupFoundationView()
        setupLabels()
        setupCollectionView()
    }
    
    func bindView(vm: DThematiceDefaultViewModel?) {
        viewModel = vm
        
        titleLabel?.text = vm?.thematicTitleLabelText
        collectionView?.reloadData()
    }
    
}

extension DThematicTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    // MARK: - UICollectionViewDelegate, UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.content.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(forIndexPath: indexPath) as PosterCollectionCell
        cell.bindView(vm: PosterDefaultViewModel(content: viewModel?.getSafeContent(at: indexPath.item)))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.dthematicTableCell(self, didTap: viewModel?.getSafeContent(at: indexPath.item))
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
        titleLabel?.text = ""
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
