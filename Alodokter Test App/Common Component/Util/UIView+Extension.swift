//
//  UIView+Extension.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 26/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

extension UIView {
    func makeConstraints(_ block: (ConstraintMaker) -> Void) {
        translatesAutoresizingMaskIntoConstraints = false
        let maker: ConstraintMaker = ConstraintMaker(currentView: self)
        block(maker)
    }
}
