//
//  ErrorStateView.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class ErrorStateView: UIView {
    // MARK: - Properties
    
    private lazy var imageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let descriptionLabel: UILabel = UILabel()
        
        descriptionLabel.font = .systemFont(ofSize: 14.0)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.text = "We are sorry, there is a Network Issue :("
        descriptionLabel.textAlignment = .center
        
        return descriptionLabel
    }()
    
    private lazy var retryButton: UIButton = {
        let retryButton: CommonButton = CommonButton()
        
        retryButton.addTarget(self, action: #selector(retryButtonOnTapped), for: .touchUpInside)
        retryButton.setTitle("Retry", for: .normal)
        
        return retryButton
    }()
        
    private var retryButtonAction: (() -> Void)?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func configureErrorView(retryButtonAction: @escaping (() -> Void)) {
        self.retryButtonAction = retryButtonAction
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        let containerView: UIView = UIView()
        
        backgroundColor = .white
        
        imageView.image = UIImage(named: "ic-network-issue")
        
        descriptionLabel.text = "We are sorry, there is a Network Issue :("
        
        retryButton.setTitle("Retry", for: .normal)
        
        addSubview(containerView)
        
        containerView.addSubview(imageView)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(retryButton)
        
        containerView.makeConstraints { make in
            make.centerY.left.right.equalTo(self)
        }
        
        imageView.makeConstraints { make in
            make.top.centerX.equalTo(containerView)
            make.size.equalToConstant(120.0)
        }
        
        descriptionLabel.makeConstraints { make in
            make.top.equalTo(imageView, position: .bottom, constant: 24.0)
            make.left.equalTo(containerView, constant: 16.0)
            make.right.equalTo(containerView, constant: -16.0)
        }
        
        retryButton.makeConstraints { make in
            make.top.equalTo(descriptionLabel, position: .bottom, constant: 24.0)
            make.bottom.equalTo(containerView)
            make.left.equalTo(containerView, constant: 16.0)
            make.right.equalTo(containerView, constant: -16.0)
        }
    }
    
    // MARK: - Button's Actions
    
    @objc
    private func retryButtonOnTapped() {
        retryButtonAction?()
    }
}
