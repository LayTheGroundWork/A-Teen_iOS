//
//  IndicatorCircularView.swift
//  TeenFeature
//
//  Created by 강치우 on 7/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

class IndicatorCircularView: UIView {
    override func tintColorDidChange() {
        self.backgroundColor = tintColor
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }

    override var frame: CGRect {
        didSet {
            updateCornerRadius()
        }
    }

    private func updateCornerRadius() {
        layer.cornerRadius = min(bounds.width, bounds.height) / 2
    }
}
