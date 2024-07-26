//
//  CircularView.swift
//  ProfileDetailFeature
//
//  Created by 노주영 on 7/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

class CircularView: UIView {
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
