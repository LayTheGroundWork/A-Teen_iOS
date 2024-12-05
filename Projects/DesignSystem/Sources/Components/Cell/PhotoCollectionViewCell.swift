//
//  PhotoCollectionViewCell.swift
//  DesignSystem
//
//  Created by 노주영 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import UIKit

public final class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    public var removeImageButtonAction: (() -> Void)?

    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var plusImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "plus")
        imageView.tintColor = DesignSystemAsset.mainColor.color
        return imageView
    }()
    
    private lazy var videoMarkView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.videoIcon.image
        imageView.alpha = 0.5
        imageView.tintColor = UIColor.white
        return imageView
    }()

    lazy var removeImageButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.xMarkWhiteIcon.image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(clickRemoveButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func prepareForReuse() {
        contentView.backgroundColor = DesignSystemAsset.gray03.color
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = UIColor.white.cgColor
        
        plusImageView.isHidden = false
        photoImageView.isHidden = true
        removeImageButton.isHidden = true
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.backgroundColor = DesignSystemAsset.gray03.color
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 20
        
        contentView.addSubview(plusImageView)
        contentView.addSubview(photoImageView)
        contentView.addSubview(videoMarkView)
        contentView.addSubview(removeImageButton)
    }
    
    private func configLayout() {
        plusImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        videoMarkView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        removeImageButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.trailing.equalToSuperview().offset(-13)
            make.width.height.equalTo(24)
        }
        
    }

    // MARK: - Actions
    public func setCellCustom(item: Int) {
        plusImageView.isHidden = false
        photoImageView.isHidden = true
        videoMarkView.isHidden = true
        removeImageButton.isHidden = true
    }
    
    public func setImage(image: UIImage) {
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = DesignSystemAsset.mainColor.color.cgColor
        
        plusImageView.isHidden = true
        photoImageView.isHidden = false
        removeImageButton.isHidden = false
        photoImageView.image = image
    }
    
    public func showVideoMark() {
        videoMarkView.isHidden = false
    }
    
    public func clearCell() {
        contentView.layer.borderWidth = 0
        contentView.layer.borderColor = nil
        
        plusImageView.isHidden = false
        photoImageView.isHidden = true
        videoMarkView.isHidden = true
        removeImageButton.isHidden = true
    }
    
    @objc func clickRemoveButton(_ sender: UIButton){
        removeImageButtonAction?()
    }
}

extension PhotoCollectionViewCell: Reusable { }

