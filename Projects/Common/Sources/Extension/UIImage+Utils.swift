//
//  UIImage+Utils.swift
//  Common
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

extension UIImage {
    public func transformed(by transform: CGAffineTransform) -> UIImage? {
        let transformedRect = CGRect(origin: .zero, size: self.size).applying(transform)
        let newSize = transformedRect.size
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        context.concatenate(transform)
        self.draw(at: CGPoint(x: 0, y: 0))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    public func resized(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        self.draw(in: CGRect(origin: .zero, size: newSize))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        guard let resizedImage = resizedImage else { return UIImage() }
        return resizedImage
    }
}
