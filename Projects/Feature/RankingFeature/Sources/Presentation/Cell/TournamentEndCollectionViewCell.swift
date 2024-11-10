//
//  TournamentEndCollectionViewCell.swift
//  RankingFeature
//
//  Created by phang on 6/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import Domain
import UIKit

protocol TournamentEndCollectionViewCellDelegate: AnyObject {
    func finishTournament()
}

final class TournamentEndCollectionViewCell: UICollectionViewCell {
    weak var delegate: TournamentEndCollectionViewCellDelegate?
    
    // MARK: - Private properties
    private lazy var infoMessageView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.grayDark.color
        view.layer.cornerRadius = ViewValues.defaultRadius
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var filledCircleView: UIView = {
        let circle = UIView()
        circle.backgroundColor = DesignSystemAsset.mainColor.color
        circle.layer.cornerRadius = 60
        return circle
    }()
    
    private lazy var oneBorderCircleView: DashedBorderView = {
        let circle = DashedBorderView()
        circle.backgroundColor = UIColor.clear
        circle.layer.cornerRadius = 22
        return circle
    }()
    
    private lazy var twoBorderCircleView: DashedBorderView = {
        let circle = DashedBorderView()
        circle.backgroundColor = UIColor.clear
        circle.layer.cornerRadius = 28
        return circle
    }()
    
    private lazy var mainTextLabel: UILabel = {
        let label = UILabel()
        label.text = "투표 완료!"
        label.textColor = UIColor.white
        label.font = .customFont(forTextStyle: .callout, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var subTextLabel: UILabel = {
        let label = UILabel()
        label.text = "이번 투표 결과는 이번 주\n토너먼트에 반영됩니다."
        label.textColor = UIColor.white
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var textStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [mainTextLabel, subTextLabel])
        stack.axis = .vertical
        stack.spacing = 5
        stack.alignment = .center
        return stack
    }()
    
    private lazy var userView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.grayDark.color
        view.layer.cornerRadius = ViewValues.defaultRadius
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    private lazy var schoolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.schoolIcon.image
        return imageView
    }()
    
    private lazy var userInfoLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("결과 확인하기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: .highlighted)
        button.titleLabel?.font = .customFont(forTextStyle: .callout, weight: .regular)
        button.backgroundColor = DesignSystemAsset.mainColor.color
        button.layer.cornerRadius = ViewValues.defaultRadius
        button.addTarget(self, action: #selector(didTapSelectButton(_: )), for: .touchUpInside)
        return button
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
        contentView.backgroundColor = UIColor.black
        
        contentView.addSubview(infoMessageView)
        contentView.addSubview(userView)
        contentView.addSubview(selectButton)
        
        infoMessageView.addSubview(filledCircleView)
        infoMessageView.addSubview(oneBorderCircleView)
        infoMessageView.addSubview(twoBorderCircleView)
        infoMessageView.addSubview(textStackView)
        
        userView.addSubview(userImage)
        userView.addSubview(userNameLabel)
        userView.addSubview(userInfoLabel)
        userView.addSubview(schoolImageView)
    }
    
    private func configLayout() {
        infoMessageView.snp.makeConstraints { make in
            if ViewValues.height <= ViewValues.DeviceScreenSizes.model8Plus.rawValue {
                make.top.equalToSuperview()
                make.height.equalTo(80)
            } else {
                make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(50)
                make.height.equalTo(120)
            }
            make.leading.equalToSuperview().offset(48)
            make.trailing.equalToSuperview().offset(-48)
        }
        
        filledCircleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-45)
            make.leading.equalToSuperview().offset(-35)
            make.width.height.equalTo(120)
        }
        
        oneBorderCircleView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(68)
            make.bottom.equalToSuperview().offset(22)
            make.width.height.equalTo(44)
        }
        
        twoBorderCircleView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(7)
            make.width.height.equalTo(56)
        }
        
        textStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        userView.snp.makeConstraints { make in
            make.top.equalTo(infoMessageView.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(48)
            make.trailing.equalToSuperview().offset(-48)
            make.height.equalTo((ViewValues.width - 96) * 1.16 + 80)
        }
        
        userImage.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo((ViewValues.width - 96) * 1.16)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalTo(userImage.snp.bottom).offset(23)
            make.leading.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-23)
        }
        
        userInfoLabel.snp.makeConstraints { make in
            make.bottom.equalTo(userNameLabel.snp.bottom)
            make.trailing.equalToSuperview().offset(-10)
        }
        
        schoolImageView.snp.makeConstraints { make in
            make.centerY.equalTo(userInfoLabel.snp.centerY)
            make.trailing.equalTo(userInfoLabel.snp.leading).offset(-2)
            make.width.height.equalTo(24)
        }
        
        selectButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(50)
            if ViewValues.height <= ViewValues.DeviceScreenSizes.model8Plus.rawValue {
                make.bottom.equalToSuperview().offset(-20)
            } else {
                make.bottom.equalToSuperview().offset(-48)
            }
        }
    }
        
    func setProperties(
        delegate: TournamentEndCollectionViewCellDelegate,
        winner: TournamentParticipantData,
        age: Int
    ) {
        self.delegate = delegate
        
        self.userImage.image = DesignSystemAsset.badge7.image
        self.userNameLabel.text = winner.userName
        self.userInfoLabel.text = "\(winner.userSchool), \(age)세"
    }
    
    // MARK: - Actions
    @objc private func didTapSelectButton(_ sender: UIButton) {
        delegate?.finishTournament()
    }
}

// MARK: - Extensions here
extension TournamentEndCollectionViewCell: Reusable { }
