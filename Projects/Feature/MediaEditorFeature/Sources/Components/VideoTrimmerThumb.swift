//
//  VideoTrimmerThumb.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import UIKit

final class VideoTrimmerThumb: UIView {
    var isActive = false
    
    var leadingChevronImageView = UIImageView(image: UIImage(systemName: "pause"))
    var trailingChevronView = UIImageView(image: UIImage(systemName: "pause"))

    var wrapperView = UIView()
    var leadingView = UIView()
    var trailingView = UIView()
    var topView = UIView()
    var bottomView = UIView()
    
    let leadingGrabber = UIControl()
    let trailingGrabber = UIControl()

    let chevronWidth = CGFloat(16)
    let edgeHeight = CGFloat(4)

    private func setup() {

        leadingChevronImageView.contentMode = .scaleAspectFit
        trailingChevronView.contentMode = .scaleAspectFit

        leadingChevronImageView.tintColor = .black
        trailingChevronView.tintColor = .black

        leadingChevronImageView.tintAdjustmentMode = .normal
        trailingChevronView.tintAdjustmentMode = .normal

        leadingView.layer.cornerRadius = 6
        leadingView.layer.cornerCurve = .continuous
        leadingView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]

        trailingView.layer.cornerRadius = 6
        trailingView.layer.cornerCurve = .continuous
        trailingView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]

        leadingView.addSubview(leadingChevronImageView)
        trailingView.addSubview(trailingChevronView)

        addSubview(wrapperView)

        wrapperView.addSubview(leadingView)
        wrapperView.addSubview(trailingView)
        wrapperView.addSubview(topView)
        wrapperView.addSubview(bottomView)

        wrapperView.addSubview(leadingGrabber)
        wrapperView.addSubview(trailingGrabber)

        updateColor()
    }
    private func updateColor() {
        let color = UIColor.systemYellow
        leadingView.backgroundColor = color
        trailingView.backgroundColor = color
        topView.backgroundColor = color
        bottomView.backgroundColor = color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        let size = bounds.size

        wrapperView.frame = CGRect(origin: .zero, size: size)

        leadingView.frame = CGRect(x: 0, y: 0, width: chevronWidth, height: bounds.height)
        trailingView.frame = CGRect(x: bounds.width - chevronWidth, y: 0, width: chevronWidth, height: bounds.height)
        topView.frame = CGRect(x: chevronWidth, y: 0, width: bounds.width - chevronWidth * 2, height: edgeHeight)
        bottomView.frame = CGRect(x: chevronWidth, y: bounds.height - edgeHeight, width: bounds.width - chevronWidth * 2, height: edgeHeight)

        let chevronHorizontalInset = CGFloat(2)
        let chevronVerticalInset = CGFloat(8)
        let chevronFrame = CGRect(x: chevronHorizontalInset, y: chevronVerticalInset, width: chevronWidth - chevronHorizontalInset * 2, height: size.height - chevronVerticalInset * 2)

        leadingChevronImageView.frame = chevronFrame
        trailingChevronView.frame = chevronFrame

        leadingGrabber.frame = leadingView.frame
        trailingGrabber.frame = trailingView.frame
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
