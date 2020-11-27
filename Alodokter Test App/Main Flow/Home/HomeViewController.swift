//
//  HomeViewController.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class HomeViewController: TabbarBaseViewController {
    // MARK: - Properties
    
    lazy var collectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let collectionView: UICollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        collectionView.backgroundColor = .white
        collectionView.contentInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: "Content_Cell")
        
        return collectionView
    }()
    
    private let viewModel: HomeViewModel
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel.loadContents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
        self.viewModel.action = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Static Methods
    
    static func constructController() -> HomeViewController{
        let viewModel: HomeViewModel = HomeViewModel(dependency: HomeViewModelDependency())
        let viewController: HomeViewController = HomeViewController(viewModel: viewModel)
        
        return viewController
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        title = "Home"
        
        showBackButton(false)
        
        view.addSubview(collectionView)
        
        collectionView.makeConstraints { make in
            make.edge.equalTo(view)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.response?.imageAlbums.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ContentCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Content_Cell", for: indexPath) as? ContentCollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(album: viewModel.response?.imageAlbums[indexPath.row] ?? [])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let album: [ImageContent] = viewModel.response?.imageAlbums[indexPath.row] {
            coordinator?.navigateToContentDetailPage(album: album)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth - 32, height: 0.6 * screenWidth)
    }
}

extension HomeViewController: HomeViewModelAction {
    func configureHome() {
        collectionView.reloadData()
    }
}
