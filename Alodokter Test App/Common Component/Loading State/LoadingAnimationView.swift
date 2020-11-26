//
//  LoadingAnimationView.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

private let kLoadingCircleSpacing: CGFloat = 2.0
private let kLoadingCircleViewHeight: CGFloat = 28.0
private let kLoadingCircleViewWidth: CGFloat = 16.0

final class LoadingAnimationView: UIView {
    // MARK: - Properties
    
    private lazy var leftLoadingCircleView: LoadingCircleView = {
        let leftLoadingCircleView: LoadingCircleView = LoadingCircleView(color: .red)
        
        return leftLoadingCircleView
    }()
    
    private lazy var middleLoadingCircleView: LoadingCircleView = {
        let middleLoadingCircleView: LoadingCircleView = LoadingCircleView(color: .yellow)
        
        return middleLoadingCircleView
    }()
    
    private lazy var rightLoadingCircleView: LoadingCircleView = {
        let rightLoadingCircleView: LoadingCircleView = LoadingCircleView(color: .themePrimary)
        
        rightLoadingCircleView.delegate = self
        
        return rightLoadingCircleView
    }()
    
    private var isRun: Bool = false
    
    private var isLoopingFinish: Bool = true {
        didSet {
            if isLoopingFinish && isRun {
                playAnimation()
            }
        }
    }
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func playAnimation() {
        isRun = true
        isLoopingFinish = false
        
        leftLoadingCircleView.playAnimation()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            guard let self: LoadingAnimationView = self else { return }
            
            self.middleLoadingCircleView.playAnimation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self: LoadingAnimationView = self else { return }
            
            self.rightLoadingCircleView.playAnimation()
        }
    }
    
    func stopAnimation() {
        isRun = false
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        addSubview(leftLoadingCircleView)
        addSubview(middleLoadingCircleView)
        addSubview(rightLoadingCircleView)
        
        leftLoadingCircleView.makeConstraints { make in
            make.top.bottom.left.equalTo(self)
            make.height.equalToConstant(kLoadingCircleViewHeight)
            make.width.equalToConstant(kLoadingCircleViewWidth)
        }
        
        middleLoadingCircleView.makeConstraints { make in
            make.top.bottom.equalTo(self)
            make.left.equalTo(leftLoadingCircleView, position: .right, constant: kLoadingCircleSpacing)
            make.height.equalToConstant(kLoadingCircleViewHeight)
            make.width.equalToConstant(kLoadingCircleViewWidth)
        }
        
        rightLoadingCircleView.makeConstraints { make in
            make.top.bottom.right.equalTo(self)
            make.left.equalTo(middleLoadingCircleView, position: .right, constant: kLoadingCircleSpacing)
            make.height.equalToConstant(kLoadingCircleViewHeight)
            make.width.equalToConstant(kLoadingCircleViewWidth)
        }
    }
}

extension LoadingAnimationView: LoadingCircleViewDelegate {
    func remindAnimationIsFinish() {
        isLoopingFinish = true
    }
}

