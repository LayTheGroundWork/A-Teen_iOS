//
//  PhotoCollectionViewCell.swift
//  LoginFeature
//
//  Created by 노주영 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

final class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = DesignSystemAsset.lightMainColor.color
        return imageView
    }()

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        contentView.backgroundColor = DesignSystemAsset.gray03.color
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.white.cgColor
        
        plusImageView.isHidden = false
        plusImageView.tintColor = DesignSystemAsset.lightMainColor.color
        
        photoImageView.isHidden = true
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.backgroundColor = DesignSystemAsset.gray03.color
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(plusImageView)
        contentView.addSubview(photoImageView)
    }
    
    private func configLayout() {
        plusImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - Actions
    func setCellCustom(item: Int) {
        switch item {
        case 0:
            contentView.backgroundColor = UIColor.white
            contentView.layer.borderWidth = 2
            contentView.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
            
            plusImageView.tintColor = DesignSystemAsset.mainColor.color
        default:
            break
        }
        plusImageView.isHidden = false
        photoImageView.isHidden = true
    }
    
    func setImage(image: UIImage) {
        plusImageView.isHidden = true
        photoImageView.isHidden = false
        photoImageView.image = image
    }
}

extension PhotoCollectionViewCell: Reusable { }

