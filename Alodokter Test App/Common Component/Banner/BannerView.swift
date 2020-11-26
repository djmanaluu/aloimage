//
//  BannerView.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class BannerView: UIView {
    // MARK: - Properties
    
    private let action: (() -> Void)?
    
    // MARK: - Init
    
    init(action: (() -> Void)?) {
        self.action = action
        
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Static Methods
    
    /// Show Baner
    ///
    /// - Parameters:
    ///   - vc: VC
    ///   - text: content text
    ///   - buttonLabel: button titile
    ///   - action: action
    ///   - duration: (in seconds) Timer that trigger close the banner automatically. If we set the duration 0, it will close if we tap on button only
    static func showBannerView(on vc: UIViewController,
                               text: String,
                               buttonLabel: String,
                               duration: Double = 0.0,
                               action: (() -> Void)? = nil) {
        let bannerView: BannerView = BannerView(action: action)
        
        bannerView.configureBannerView(text: text, buttonLabel: buttonLabel)
        
        vc.view.addSubview(bannerView)
        
        bannerView.makeConstraints { make in
            make.top.equalTo(vc.view, position: .topSafeArea, constant: 16.0)
            make.left.equalTo(vc.view, constant: 16.0)
            make.right.equalTo(vc.view, constant: -16.0)
        }
        
        if duration > 0.0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + duration) { [weak bannerView] in
                bannerView?.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func configureBannerView(text: String, buttonLabel: String) {
        let contentLabel: UILabel = UILabel()
        let actionButton: UIButton = UIButton()
        
        backgroundColor = .alert
        
        layer.cornerRadius = 10.0
        
        contentLabel.font = .systemFont(ofSize: 14.0)
        contentLabel.numberOfLines = 0
        contentLabel.text = text
        contentLabel.textColor = .white
        
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        actionButton.setTitle(buttonLabel, for: .normal)
        actionButton.setTitleColor(.white, for: .normal)
        actionButton.titleLabel?.font = .boldSystemFont(ofSize: 14.0)
        
        addSubview(contentLabel)
        addSubview(actionButton)
        
        contentLabel.makeConstraints { make in
            make.top.left.right.equalTo(self, constant: 16.0)
            make.right.equalTo(self, constant: -16.0)
        }
        
        actionButton.makeConstraints { make in
            make.top.equalTo(contentLabel, position: .bottom, constant: 8.0)
            make.bottom.equalTo(self, constant: -4.0)
            make.right.equalTo(self, constant: -16.0)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func buttonTapped() {
        action?()
        
        removeFromSuperview()
    }
}
