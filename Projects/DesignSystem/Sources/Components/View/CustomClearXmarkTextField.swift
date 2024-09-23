//
//  CustomClearXmarkTextField.swift
//  DesignSystem
//
//  Created by 노주영 on 9/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

// MARK: - 커스텀 텍스트 필드
public final class CustomClearXmarkTextField: UITextField {
    // rightView 에 clear 버튼 사용 시, 패딩 14 를 주기 위함
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var padding = super.rightViewRect(forBounds: bounds)
        padding.origin.x -= 14
        return padding
    }
   
//    // 복사해서 붙여넣기 방지
//    public override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
//        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
//            return false
//        }
//        return super.canPerformAction(action, withSender: sender)
//    }
}
