//
//  CommonButton.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

final class CommonButton: UIButton {
    init(isButtonActived actived: Bool = true) {
        super.init(frame: .zero)
        
        isActived(actived)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func isActived(_ actived: Bool) {
        if actived {
            backgroundColor = .themePrimary
        }
        else {
            backgroundColor = .lightGray
        }
        
        isEnabled = actived
    }
    
    // MARK: - Private Methods
    
    private func setupButton() {
        layer.cornerRadius = 10.0
        
        titleLabel?.font = .systemFont(ofSize: 16.0)
        
        makeConstraints { make in
            make.height.equalToConstant(36.0)
        }
    }
}
