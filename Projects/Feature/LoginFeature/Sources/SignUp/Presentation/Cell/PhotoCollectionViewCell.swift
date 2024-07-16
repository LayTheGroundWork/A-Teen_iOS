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
    private var viewModel: SignUpViewModel?
    
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
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.backgroundColor = DesignSystemAsset.gray03.color
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(plusImageView)

    }
    
    private func configLayout() {
        plusImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }
    }
    
    override func prepareForReuse() {
        contentView.backgroundColor = DesignSystemAsset.gray03.color
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.white.cgColor
        
        plusImageView.tintColor = DesignSystemAsset.lightMainColor.color

    }

    // MARK: - Actions
    func setProperties(viewModel: SignUpViewModel) {
        self.viewModel = viewModel
    }
    
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
    }
}

extension PhotoCollectionViewCell: Reusable { }

