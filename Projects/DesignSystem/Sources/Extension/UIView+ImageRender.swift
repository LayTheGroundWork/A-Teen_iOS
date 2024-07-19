//
//  UIView+ImageRender.swift
//  DesignSystem
//
//  Created by 김명현 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

extension UIView {
    public func asImage() -> UIImage? {
        self.layoutIfNeeded()
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        print(bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
