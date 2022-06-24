//
//  UIImageView+Extension.swift
//  NSCache-Example
//
//  Created by SHIN YOON AH on 2022/06/24.
//

import UIKit

extension UIImageView {
    func loadImageUrl(_ url: String) {
        DispatchQueue.global(qos: .background).async {
            let cachedKey = NSString(string: url)
            
            if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey) {
                DispatchQueue.main.async {
                    self.image = cachedImage
                }
                return
            }
            
            guard let url = URL(string: url) else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                let image = UIImage(data: data)!
                DispatchQueue.main.async {
                    ImageCacheManager.shared.setObject(image, forKey: cachedKey)
                    self.image = image
                }
            }.resume()
        }
    }
}
