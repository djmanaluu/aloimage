//
//  ProfileImage.swift
//  Alodokter Test App
//
//  Created by David Jordan Manalu on 27/11/20.
//  Copyright © 2020 David Jordan Manalu. All rights reserved.
//

import UIKit

private let kProfileImageKey: String = "PROFILE_IMAGE_KEY"

final class ProfileImage {
    static func save(image: UIImage) {
        let imageData: Data? = image.pngData()
        
        UserDefaults.standard.setValue(imageData, forKey: kProfileImageKey)
    }
    
    static func remove() {
        UserDefaults.standard.removeObject(forKey: kProfileImageKey)
    }
    
    static func getImage() -> UIImage? {
        guard let imageData: Data = UserDefaults.standard.value(forKey: kProfileImageKey) as? Data else { return nil }
        
        return UIImage(data: imageData)
    }
}
