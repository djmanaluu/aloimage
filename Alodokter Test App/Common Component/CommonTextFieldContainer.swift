//
//  CommonTextFieldContainer.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class CommonTextFieldContainer: UIView {
    lazy var textField: UITextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        layer.borderColor = UIColor.themePrimary.cgColor
        layer.borderWidth = 2.0
        layer.cornerRadius = 10.0
        
        textField.font = .systemFont(ofSize: 12.0)
        textField.textColor = .themePrimary
        
        addSubview(textField)
        
        textField.makeConstraint { make in
            make.top.left.equalTo(self, constant: 12.0)
            make.right.bottom.equalTo(self, constant: -12.0)
        }
    }
}
