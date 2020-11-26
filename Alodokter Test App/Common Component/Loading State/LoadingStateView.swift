//
//  LoadingStateView.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class LoadingStateView: UIView {
    // MARK: - Properties
    
    private lazy var loadingIndicator: LoadingAnimationView = {
        let loadingIndicator: LoadingAnimationView = LoadingAnimationView()
        
        return loadingIndicator
    }()
    
    private lazy var loadingLabel: UILabel = {
        let loadingLabel: UILabel = UILabel()
        
        loadingLabel.font = .systemFont(ofSize: 14.0)
        loadingLabel.numberOfLines = 0
        loadingLabel.text = "Loading"
        loadingLabel.textAlignment = .center
        
        return loadingLabel
    }()
    
    private var isLoadingRunning: Bool = false
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func show() {
        if let superview: UIView = superview {
            superview.bringSubviewToFront(self)
        }
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self: LoadingStateView = self else { return }
            
            self.alpha = 1.0
        }
        
        loadingIndicator.isHidden = false
        loadingLabel.isHidden = false
        
        if !isLoadingRunning {
            loadingIndicator.playAnimation()
            isLoadingRunning.toggle()
        }
    }
    
    func hide() {
        loadingIndicator.isHidden = true
        loadingLabel.isHidden = true
        
        UIView.animate(withDuration: 0.25) { [weak self] in
            guard let self: LoadingStateView = self else { return }
            
            self.alpha = 0.0
        }
        
        isLoadingRunning = false
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        let containerView: UIView = UIView()
        
        backgroundColor = .white
        
        addSubview(containerView)
        
        containerView.addSubview(loadingIndicator)
        containerView.addSubview(loadingLabel)
        
        containerView.makeConstraints { make in
            make.centerY.left.right.equalTo(self)
        }
        
        loadingIndicator.makeConstraints { make in
            make.top.centerX.equalTo(containerView)
        }
        
        loadingLabel.makeConstraints { make in
            make.top.equalTo(loadingIndicator, position: .bottom, constant: 12.0)
            make.bottom.equalTo(containerView)
            make.left.equalTo(containerView, constant: 16.0)
            make.right.equalTo(containerView, constant: -16.0)
        }
    }
}
