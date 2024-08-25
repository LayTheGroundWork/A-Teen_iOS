//
//  TeenImageCellCollectionViewCell.swift
//  ProfileDetailFeature
//
//  Created by 노주영 on 7/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

class TeenImageCellCollectionViewCell: UICollectionViewCell {
    lazy var teenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(teenImageView)
        
        teenImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        teenImageView.image = nil
    }
    
    func setImage(image: UIImage) {
        teenImageView.image = image
        teenImageView.contentMode = .scaleAspectFill
    }
}

extension TeenImageCellCollectionViewCell: Reusable { }
