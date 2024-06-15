//
//  UIViewController+TouchGesture.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import UIKit

extension UIViewController {
    // 뷰 컨트롤러의 다른 부분을 터치하면 키보드 내림
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension UICollectionViewCell {
    // 콜렉션 뷰 셀의 다른 부분을 터치하면 키보드 내림
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.contentView.endEditing(true)
    }
}
