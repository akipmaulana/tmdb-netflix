//
//  DiscoveryVC.swift
//  tmdb-netflix
//
//  Created by Akirah Dev on 27/06/21.
//  
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

final class DiscoveryVC: BaseViewController, TabBarScreen, ViewModelProtocol {
    
    typealias ViewModel = DiscoveryDefaultViewModel
    
    internal var viewModel: DiscoveryDefaultViewModel?
    
    private let disposeBag = DisposeBag()
    
    @IBOutlet weak private var topNavBarView: UIView!
    @IBOutlet weak private var domainLabel: UILabel!
    @IBOutlet weak private var genreSelectedLabel: UILabel!
    @IBOutlet weak private var scrollView: UIScrollView!
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var latestPosterImageView: UIImageView!
    @IBOutlet weak private var decorationView: UIView!
    @IBOutlet weak private var latestGenreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupTableView()
        setupDecorationView()
        setupCustomNavigationBarView()
        viewModel?.loadGenre()
        viewModel?.loadDiscoveryData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        viewModel?.loadLatestContent()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func bindView(vm: DiscoveryDefaultViewModel?) {
        viewModel = vm
        
        viewModel?.thematics.drive(onNext: {[unowned self] (_) in
            self.tableView?.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel?.latestContent.drive(onNext: {[unowned self] _ in
            self.latestPosterImageView?.sd_setImage(with: URL(string: self.viewModel?.latestPosterImageUrl ?? ""))
            self.latestGenreLabel?.text = self.viewModel?.latestGenreLabelText
        }).disposed(by: disposeBag)
    }
}

extension DiscoveryVC: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableViewDelegate, UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfThematics ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DThematicTableCell
        cell.bindView(vm: DThematiceDefaultViewModel(data: viewModel?.getSafeThematic(at: indexPath.section)))
        cell.delegate = self
        return cell
    }
}

extension DiscoveryVC: DThematicTableCellDelegate {
    func dthematicTableCell(_ cell: DThematicTableCell, didTap poster: Content?) {
        let detailContentVC = DetailContentVC()
        detailContentVC.bindView(vm: DetailContentDefaultViewModel())
        navigationController?.pushViewController(detailContentVC, animated: true)
    }
}

private extension DiscoveryVC {
    // MARK: - Setup View
    func setupCustomNavigationBarView() {
        topNavBarView?.backgroundColor = .clear
        topNavBarView?.applyGradient(withColours: [.black, UIColor.black.withAlphaComponent(0.8), .clear], gradientOrientation: .vertical)
        
        domainLabel?.font = .sourceSansProBold(size: .title)
        domainLabel?.textColor = .white
        domainLabel?.numberOfLines = 0
        domainLabel?.text = viewModel?.titleDomainLabelText
        
        genreSelectedLabel?.font = .sourceSansProSemiBold(size: .subtitle2)
        genreSelectedLabel?.textColor = .white
        genreSelectedLabel?.numberOfLines = 0
        genreSelectedLabel?.text = "All Genres ▼"
    }
    
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
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView?.isScrollEnabled = false
        tableView?.register(DThematicTableCell.self)
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 8))
        tableView.tableHeaderView = UIView(frame: CGRect.zero)
    }
    
    func setupDecorationView() {
        decorationView?.backgroundColor = .clear
        decorationView?.applyGradient(withColours: [.clear, UIColor.black.withAlphaComponent(0.8), .black], gradientOrientation: .vertical)
        
        latestGenreLabel?.font = .sourceSansProSemiBold(size: .caption)
        latestGenreLabel?.textColor = .white
        latestGenreLabel?.numberOfLines = 0
        latestGenreLabel?.text = ""
    }
}
