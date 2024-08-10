//
//  SNSBottomSheetViewController.swift
//  ProfileDetailFeature
//
//  Created by 강치우 on 8/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit
import UIKit

final class SNSBottomSheetViewController: UIViewController {
    
    let label: UILabel = {
        let text = UILabel()
        text.text = "링크"
        text.textColor = .systemBlue
        return text
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(label)
        
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
