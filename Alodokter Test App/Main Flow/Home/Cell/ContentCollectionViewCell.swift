//
//  ContentCollectionViewCell.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class ContentCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    
    private lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
        
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configureCell(album: [ImageContent]) {
        imageView.setImage(withUrlString: album.first?.imageUrl ?? "")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        contentView.clipsToBounds = true
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 2.0
        contentView.layer.cornerRadius = 10.0
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5.0
        
        contentView.addSubview(imageView)
        
        imageView.makeConstraints { make in
            make.edge.equalTo(contentView)
        }
    }
}
