//
//  UILabel+Constraints.swift
//  ATeen
//
//  Created by 노주영 on 5/24/24.
//

import UIKit

extension UILabel {
    public func textHeight(width: CGFloat, font: UIFont, text: String) -> CGFloat {
        // 최대 크기 설정
        let maxSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)

        // 텍스트 속성 설정
        let textAttributes: [NSAttributedString.Key: Any] = [.font: font]

        // 텍스트 크기 계산
        let boundingRect = text.boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: textAttributes, context: nil)

        // 필요한 높이 계산
        let requiredHeight = ceil(boundingRect.height)
        
        return requiredHeight
    }
}

extension UILabel {
    public func setLineSpacing(spacing: CGFloat) { // 줄 간격 조절
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}
