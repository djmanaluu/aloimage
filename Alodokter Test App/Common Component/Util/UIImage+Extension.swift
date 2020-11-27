//
//  UIImage+Extension.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImage(withUrlString urlString: String) {
        NetworkUtil.requestData(from: urlString) { data, _, _ in
            DispatchQueue.main.async { [weak self] in
                guard let self: UIImageView = self, let imageData: Data = data else { return }
                
                self.image = UIImage(data: imageData)
            }
        }
    }
}
