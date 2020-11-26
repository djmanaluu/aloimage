//
//  LoadingCircleView.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

private let kLoadingCircleMinAlpha: CGFloat = 0.2
private let kLoadingCircleMinSize: CGFloat = 6.0
private let kLoadingCircleViewHeight: CGFloat = 28.0
private let kLoadingCircleViewWidth: CGFloat = 16.0

protocol LoadingCircleViewDelegate: AnyObject {
    /// Remind that the animation already finish
    func remindAnimationIsFinish()
}

final class LoadingCircleView: UIView {
    // MARK: - Properties
    
    weak var delegate: LoadingCircleViewDelegate?
    
    private lazy var circleView: UIView = {
        let circleView: UIView = UIView()
        
        circleView.layer.cornerRadius = kLoadingCircleMinSize / 2.0
        
        return circleView
    }()
    
    private lazy var circleHeightAnchor: NSLayoutConstraint = circleView.heightAnchor.constraint(equalToConstant: kLoadingCircleMinSize)
    
    private lazy var circleWidthAnchor: NSLayoutConstraint = circleView.widthAnchor.constraint(equalToConstant: kLoadingCircleMinSize)
    
    private lazy var circleViewTopAnchor: NSLayoutConstraint = circleView.topAnchor.constraint(equalTo: topAnchor, constant: kLoadingCircleViewHeight - kLoadingCircleMinSize)
    
    private let circleColor: UIColor
    
    // MARK: - Init
    
    init(color: UIColor) {
        circleColor = color
        
        super.init(frame: .zero)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func playAnimation() {
        UIView.animate(withDuration: 0.25, animations: {
            self.circleView.backgroundColor = self.circleColor.withAlphaComponent(1.0)
            self.circleView.layer.cornerRadius = kLoadingCircleViewWidth / 2.0
            self.circleHeightAnchor.constant = kLoadingCircleViewWidth
            self.circleWidthAnchor.constant = kLoadingCircleViewWidth
            self.circleViewTopAnchor.constant = 0.0
            
            self.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.25, animations: {
                self.circleView.backgroundColor = self.circleColor.withAlphaComponent(kLoadingCircleMinAlpha)
                self.circleView.layer.cornerRadius = kLoadingCircleMinSize / 2.0
                self.circleHeightAnchor.constant = kLoadingCircleMinSize
                self.circleWidthAnchor.constant = kLoadingCircleMinSize
                self.circleViewTopAnchor.constant = kLoadingCircleViewHeight - kLoadingCircleMinSize
                
                self.layoutIfNeeded()
            }) { [weak self] _ in
                guard let self: LoadingCircleView = self else { return }
                
                self.delegate?.remindAnimationIsFinish()
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        addSubview(circleView)
        
        circleView.makeConstraints { make in
            make.centerX.equalTo(self)
        }
        
        circleHeightAnchor.isActive = true
        circleWidthAnchor.isActive = true
        circleViewTopAnchor.isActive = true
    }
}

