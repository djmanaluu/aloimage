//
//  CommonTextFieldContainer.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class CommonTextFieldContainer: UITextField {
    // MARK: - Init
    
    init(borderColor: UIColor) {
        super.init(frame: .zero)
        
        setupView(borderColor: borderColor)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView(borderColor: UIColor = .themePrimary) {
        let leftView: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 16.0))
        let rightView: UIView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 8.0, height: 16.0))
        
        autocorrectionType = .no
        autocapitalizationType = .none
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 10.0
        self.leftView = leftView
        self.rightView = rightView
        
        leftViewMode = .always
        rightViewMode = .always
        
        font = .systemFont(ofSize: 12.0)
        textColor = .themePrimary
        
        makeConstraints { make in
            make.height.equalToConstant(36.0)
        }
    }
    
    // MARK: - Actions
    
    @objc
    private func onTapView() {
        
    }
}
