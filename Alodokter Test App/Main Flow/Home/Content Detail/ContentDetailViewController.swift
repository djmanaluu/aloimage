//
//  ContentDetailViewController.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class ContentDetailViewController: TabbarBaseViewController {
    // MARK: - Properties
    
    private var pageControl: UIPageControl = UIPageControl()
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Contents Viewer"
    }
    
    // MARK: - Public Methods
    
    func configure(album: [ImageContent]) {
        let scrollView: UIScrollView = UIScrollView()
        let stackView: UIStackView = UIStackView()
        
        for image in album {
            let imageView: UIImageView = UIImageView()
            
            imageView.backgroundColor = .lightGray
            imageView.clipsToBounds = true
            imageView.contentMode = .scaleAspectFit
            imageView.setImage(withUrlString: image.imageUrl)
            
            stackView.addArrangedSubview(imageView)
            
            imageView.makeConstraints { make in
                make.width.equalToConstant(UIScreen.main.bounds.width)
            }
        }
        
        scrollView.backgroundColor = .lightGray
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        
        pageControl.currentPage = 0
        pageControl.numberOfPages = album.count
        
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        
        scrollView.addSubview(stackView)
        
        scrollView.makeConstraints { make in
            make.top.equalTo(view, position: .topSafeArea)
            make.bottom.equalTo(view, position: .bottomSafeArea)
            make.left.right.equalTo(view)
        }
        
        stackView.makeConstraints { make in
            make.edge.equalTo(scrollView)
            make.top.equalTo(view, position: .topSafeArea)
            make.bottom.equalTo(view, position: .bottomSafeArea)
            make.width.equalToConstant(CGFloat(album.count) * UIScreen.main.bounds.width)
        }
        
        pageControl.makeConstraints { make in
            make.bottom.equalTo(view, position: .bottomSafeArea, constant: -8.0)
            make.centerX.equalTo(view)
        }
    }
}

extension ContentDetailViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex: Int = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width)
        
        pageControl.currentPage = pageIndex
    }
}
