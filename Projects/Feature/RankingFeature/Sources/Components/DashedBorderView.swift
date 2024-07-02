//
//  DashedBorderView.swift
//  RankingFeature
//
//  Created by phang on 6/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit
import DesignSystem

// MARK: - DashedBorderView
public class DashedBorderView: UIView {
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        addLineDashedStroke(pattern: [3, 3],
                            radius: self.layer.cornerRadius,
                            color: DesignSystemAsset.mainColor.color.cgColor)
    }
}
