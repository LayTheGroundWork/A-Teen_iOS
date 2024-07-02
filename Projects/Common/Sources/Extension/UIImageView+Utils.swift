//
//  UIImageView+Utils.swift
//  Common
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

extension UIImageView {
    func setImageFromData(data: Data?) {
        if let data = data {
            if let image = UIImage(data: data) {
                self.image = image
            }
        }
    }
}
