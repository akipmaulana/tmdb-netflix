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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        viewModel?.loadDiscoveryData()
    }
    
    func bindView(vm: DiscoveryDefaultViewModel?) {
        viewModel = vm
        
        viewModel?.thematics.drive(onNext: {[unowned self] (_) in
            self.tableView?.reloadData()
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
        return cell
    }
}

private extension DiscoveryVC {
    
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
        latestGenreLabel?.text = "Comedy • Romantic • Family"
    }
}
