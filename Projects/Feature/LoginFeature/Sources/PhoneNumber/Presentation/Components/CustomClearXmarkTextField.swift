//
//  CustomClearXmarkTextField.swift
//  ATeen
//
//  Created by phang on 6/12/24.
//

import UIKit

// MARK: - 커스텀 텍스트 필드
final class CustomClearXmarkTextField: UITextField {
    // rightView 에 clear 버튼 사용 시, 패딩 14 를 주기 위함
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var padding = super.rightViewRect(forBounds: bounds)
        padding.origin.x -= 14
        return padding
    }
    
    // 복사해서 붙여넣기 방지
//    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
//            return false
//        }
//        return super.canPerformAction(action, withSender: sender)
//    }
}
