//
//  CustomDivider.swift
//  DesignSystem
//
//  Created by phang on 7/8/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import UIKit

public final class CustomDivider: UIView {
    // MARK: - Life Cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.backgroundColor = DesignSystemAsset.gray04.color
    }
}

// MARK: - Layout
extension CustomDivider {
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(7)
        }
    }
}
