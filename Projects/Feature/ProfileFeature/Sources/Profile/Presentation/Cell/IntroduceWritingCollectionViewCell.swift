//
//  IntroduceWritingCollectionViewCell.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/17/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

final class IntroduceWritingCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.backgroundColor = UIColor.black
    }
    
    private func configLayout() {
       
    }
    
    // MARK: - Actions
    public func setProperties(

    ) {
 
    }
    
    // MARK: - Actions
}

// MARK: - Extensions here
extension IntroduceWritingCollectionViewCell: Reusable { }


