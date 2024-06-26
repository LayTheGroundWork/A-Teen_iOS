//
//  UIView+CALayer.swift
//  DesignSystem
//
//  Created by phang on 6/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

extension UIView {
    // MARK: - 점선을 그리는 메서드
    @discardableResult
    public func addLineDashedStroke(
        pattern: [NSNumber]?,
        radius: CGFloat,
        color: CGColor
    ) -> CALayer {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = color
        borderLayer.lineWidth = 1
        borderLayer.lineDashPattern = pattern
        borderLayer.frame = bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: .allCorners,
            cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.addSublayer(borderLayer)
        return borderLayer
    }
}
