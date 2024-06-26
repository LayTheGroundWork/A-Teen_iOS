//
//  CustomRankingTopView.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

enum RankPlace: String {
    case first = "1"
    case second = "2"
    case third = "3"
}

final class CustomRankingTopView: UIView {
    let imageName: String
    let rank: RankPlace
    let userName: String
    let proportion: Double
    let imageWidth = (ViewValues.width - 32 - 28) / 3 - 2
    let imageHeight = ((ViewValues.width - 32 - 28) / 3 - 2) * 1.14
    
    // MARK: - Private properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        // TODO: - 이미지 체크 필요
        imageView.image = DesignSystemImages.Image(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = ViewValues.defaultRadius
        return imageView
    }()
    
    private lazy var imageBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = rank == .first ? DesignSystemAsset.subColor.color : DesignSystemAsset.gray03.color
        view.layer.cornerRadius = ViewValues.defaultRadius
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var rankCircle: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.subColor.color
        view.clipsToBounds = true
        view.layer.cornerRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var rankNumber: UILabel = {
        let label = UILabel()
        label.text = rank.rawValue
        label.textColor = DesignSystemAsset.darkYellow.color
        label.font = .customFont(forTextStyle: .footnote, weight: .bold)
        return label
    }()
    
    private lazy var firstsCrownImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.crownIcon.image
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = userName
        label.textColor = .white
        label.font = .customFont(forTextStyle: .footnote, weight: .bold)
        return label
    }()
    
    private lazy var proportionLabel: UILabel = {
        let label = UILabel()
        label.text = "\(proportion)%"
        label.textColor = .white
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    // MARK: - Life Cycle
    init(
        frame: CGRect = .zero,
        imageName: String,
        rank: RankPlace,
        userName: String,
        proportion: Double
    ) {
        self.imageName = imageName
        self.rank = rank
        self.userName = userName
        self.proportion = proportion
        super.init(frame: frame)
        
        configUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.backgroundColor = .clear
        
        self.addSubview(imageBackgroundView)
        imageBackgroundView.addSubview(imageView)
        imageView.addSubview(nameLabel)
        imageView.addSubview(proportionLabel)
        
        self.addSubview(rankCircle)
        rankCircle.addSubview(rankNumber)
        
        if rank == .first {
            self.addSubview(firstsCrownImage)
        }
    }
}

// MARK: - Layout
extension CustomRankingTopView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(1)
            make.leading.equalToSuperview().offset(1)
            make.trailing.equalToSuperview().offset(-1)
            if rank == .first {
                make.bottom.equalToSuperview().offset(-11)
            } else {
                make.bottom.equalToSuperview().offset(-1)
            }
            make.width.equalTo(imageWidth)
            make.height.equalTo(imageHeight)
        }
        
        rankCircle.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.width.height.equalTo(38)
        }
        
        rankNumber.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        if rank == .first {
            firstsCrownImage.snp.makeConstraints { make in
                make.centerY.equalTo(rankCircle.snp.centerY)
                make.leading.equalTo(rankCircle.snp.trailing).offset(6)
            }
        }
    }
}
