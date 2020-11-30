//
//  UIImage+Extension.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

let imageCache: NSCache<NSString, AnyObject> = NSCache<NSString, AnyObject>()

extension UIImageView {
    func setImage(withUrlString urlString: String) {
        if let cacheImageData: UIImage = imageCache.object(forKey: urlString as NSString) as? UIImage {
            image = cacheImageData
        }
        else {
            NetworkUtil.requestData(from: urlString) { data, _, _ in
                DispatchQueue.main.async { [weak self] in
                    guard let self: UIImageView = self, let imageData: Data = data else { return }
                    
                    if let image: UIImage = UIImage(data: imageData) {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        
                        self.image = image
                    }
                }
            }
        }
    }
}
