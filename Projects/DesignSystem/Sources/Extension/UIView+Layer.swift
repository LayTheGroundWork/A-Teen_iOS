//
//  UIView+Layer.swift
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
    
    // MARK: - cornerRadius 있는, 아래쪽 그림자 그리는 메서드
    public func addDropYShadow(
        width: Double,
        height: Double,
        color: UIColor,
        opacity: Float,
        radius: CGFloat,
        offset: CGSize
    ) {
        let renderRect = CGRect(x: 0,
                                y: bounds.height + 1,
                                width: width,
                                height: height)
        layer.shadowPath = UIBezierPath(roundedRect: renderRect,
                                        cornerRadius: layer.cornerRadius).cgPath
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = offset
    }
    
    // MARK: - 버튼 안쪽으로 밝은 그림자 그리는 메서드
    func addInnerXYShadowToButton() {
        // TODO: -
    }
}
