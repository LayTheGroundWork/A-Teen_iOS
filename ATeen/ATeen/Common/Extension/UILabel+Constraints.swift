//
//  UILabel+Constraints.swift
//  ATeen
//
//  Created by 노주영 on 5/24/24.
//

import UIKit

extension UILabel {
    func textHeight(width: CGFloat, font: UIFont, text: String) -> CGFloat {
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
