//
//  ImageCacheManager.swift
//  NSCache-Example
//
//  Created by SHIN YOON AH on 2022/06/24.
//

import UIKit

final class ImageCacheManager {
    
    static let shared = NSCache<NSString, UIImage>()
    
    private init() { }
}
