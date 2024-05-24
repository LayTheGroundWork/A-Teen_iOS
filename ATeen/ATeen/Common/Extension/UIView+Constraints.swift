//
//  UIView+Contraints.swift
//  CleanArchitecture
//
//  Created by 최동호 on 5/8/24.
//

import UIKit

extension UIView {
    func setConstraints(
        top: NSLayoutYAxisAnchor? = nil,
        right: NSLayoutXAxisAnchor? = nil,
        bottom: NSLayoutYAxisAnchor? = nil,
        left: NSLayoutXAxisAnchor? = nil,
        pTop: CGFloat = CGFloat.zero,
        pRight: CGFloat = CGFloat.zero,
        pBottom: CGFloat = CGFloat.zero,
        pLeft: CGFloat = CGFloat.zero
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: pTop).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -pRight).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -pBottom).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: pLeft).isActive = true
        }
    }
    
    func fillSuperView(widthPadding: CGFloat = .zero) {
        guard let superview = self.superview else { return }
        setConstraints(
            top: superview.topAnchor,
            right: superview.rightAnchor,
            bottom: superview.bottomAnchor,
            left: superview.leftAnchor,
            pTop: widthPadding,
            pRight: widthPadding,
            pBottom: widthPadding,
            pLeft: widthPadding
        )
    }
    
    func centerY() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func centerX() {
        guard let superview = self.superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
    
    func centerXY() {
        centerX()
        centerY()
    }
    
    func setHeightConstraint(with height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func setWidthConstraint(with width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
}

// MARK: - SubViews Height
extension UIView {
    func recursiveUnionInDepthFor(view: UIView) -> CGRect {
        var totalRect: CGRect = .zero
        
        // 모든 자식 View의 컨트롤의 크기를 재귀적으로 호출하며 최종 영역의 크기를 설정
        for subView in view.subviews {
            totalRect = totalRect.union(recursiveUnionInDepthFor(view: subView))
        }
        
        // 최종 계산 영역의 크기를 반환
        return totalRect.union(view.frame)
    }
}
