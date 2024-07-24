//
//  CustomTeenPageControl.swift
//  TeenFeature
//
//  Created by 강치우 on 7/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

class CustomTeenPageControl: UIView {
    // 총 페이지 갯수
    var pages: Int = 0 {
        didSet {
            guard pages != oldValue else { return }
            pages = max(0, pages)
            invalidateIntrinsicContentSize()
            createViews()
        }
    }

    // 현재 페이지
    var selectedPage: Int = 0 {
        didSet {
            guard selectedPage != oldValue else { return }
            selectedPage = max(0, min (selectedPage, pages - 1))
            updateColors()
            if (0..<centerDots).contains(selectedPage - pageOffset) {
                centerOffset = selectedPage - pageOffset
            } else {
                pageOffset = selectedPage - centerOffset
            }
        }
    }

    // 보일 수 있는 점의 최대 갯수
    var maxDots = 7 {
        didSet {
            maxDots = max(3, maxDots)
            if maxDots % 2 == 0 {
                maxDots += 1
            }
            invalidateIntrinsicContentSize()
        }
    }

    // 중앙에 표시되는 가장 큰 점의 갯수
    open var centerDots = 3 {
        didSet {
            centerDots = max(1, centerDots)
            if centerDots > maxDots {
                centerDots = maxDots
            }
            if centerDots % 2 == 0 {
                centerDots += 1
            }
            invalidateIntrinsicContentSize()
        }
    }

    // UI
    var dotColor = UIColor.lightGray { didSet { updateColors() } }
    var selectedColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1) { didSet { updateColors() } }

    var dotViews: [UIView] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            dotViews.forEach(addSubview)
            updateColors()
            setNeedsLayout()
        }
    }

    var dotSize: CGFloat = 6 {
        didSet {
            dotSize = max(1, dotSize)
            dotViews.forEach { $0.frame = CGRect(origin: .zero, size: CGSize(width: dotSize, height: dotSize)) }
            invalidateIntrinsicContentSize()
        }
    }

    var spacing: CGFloat = 4 {
        didSet {
            spacing = max(1, spacing)
            invalidateIntrinsicContentSize()
        }
    }

    private var lastSize = CGSize.zero

    // Animation
    var slideDuration: TimeInterval = 0.15

    private var centerOffset = 0
    private var pageOffset = 0 {
        didSet {
            UIView.animate(withDuration: slideDuration, delay: 0.15, options: [], animations: self.updatePositions, completion: nil)
        }
    }

    public init() {
        super.init(frame: .zero)
        isOpaque = false
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard bounds.size != lastSize else { return }
        lastSize = bounds.size
        updatePositions()
    }

    override var intrinsicContentSize: CGSize {
        let pages = min(maxDots, self.pages)
        let width = CGFloat(pages) * dotSize + CGFloat(pages - 1) * spacing
        let height = dotSize
        return CGSize(width: width, height: height)
    }

    private func createViews() {
        dotViews = (0..<pages).map { index in
            IndicatorCircularView(frame: CGRect(origin: .zero, size: CGSize(width: dotSize, height: dotSize)))
        }
    }

    private func updateColors() {
        dotViews.enumerated().forEach { page, dot in
            dot.tintColor = page == selectedPage ? selectedColor : dotColor
        }
    }

    func updatePositions() {
        let centerDots = min(self.centerDots, pages)
        let maxDots = min(self.maxDots, pages)
        let sidePages = (maxDots - centerDots) / 2
        let horizontalOffset = CGFloat(-pageOffset + sidePages) * (dotSize + spacing) + (bounds.width - intrinsicContentSize.width) / 2
        let centerPage = centerDots / 2 + pageOffset
        dotViews.enumerated().forEach { page, dot in
            let center = CGPoint(x: horizontalOffset + bounds.minX + dotSize / 2 + (dotSize + spacing) * CGFloat(page), y: bounds.midY)
            let scale: CGFloat = {
                let distance = abs(page - centerPage)
                if distance > (maxDots / 2) { return 0 }
                return [1, 0.66, 0.33, 0.16][max(0, min(3, distance - centerDots / 2))]
            }()
            dot.frame = CGRect(origin: .zero, size: CGSize(width: dotSize * scale, height: dotSize * scale))
            dot.center = center
        }
    }
}
