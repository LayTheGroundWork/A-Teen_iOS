//
//  TeenCollectionViewCell.swift
//  DesignSystem
//
//  Created by 최동호 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import Domain
import UIKit

public final class TeenCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Private properties
    private let colors: [CGColor] = [
        .init(red: 0, green: 0, blue: 0, alpha: 0.5),
        .init(red: 0, green: 0, blue: 0, alpha: 0)
    ]
    
    public var chatButtonAction: (() -> Void)?
    public var heartButtonAction: (() -> Void)?
    public var menuButtonAction: (() -> Void)?

    private lazy var topGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height / 2)
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.locations = [0.0, 0.44, 1.0]
        return layer
    }()
    
    private lazy var bottomGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: contentView.frame.height / 2, width: contentView.frame.width, height: contentView.frame.height / 2)
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0.5, y: 1.0)
        layer.endPoint = CGPoint(x: 0.5, y: 0.0)
        layer.locations = [0.0, 0.44, 1.0]
        return layer
    }()
    
    public lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.addSublayer(topGradientLayer)
        imageView.layer.addSublayer(bottomGradientLayer)
        return imageView
    }()
    
    private lazy var schoolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.schoolIcon.image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.white
        return imageView
    }()
    
    private lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.text = "인덕원고등학교"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    private lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "ateen"
        label.textColor = DesignSystemAsset.gray03.color
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .bold)
        return label
    }()
    
    private lazy var chattingButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.chattingIcon.image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = DesignSystemAsset.mainColor.color
        button.layer.cornerRadius = 23.5
        return button
    }()
    
    private lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.heartIcon.image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = DesignSystemAsset.mainColor.color
        button.layer.cornerRadius = 23.5
        button.isUserInteractionEnabled = true
        return button
    }()
    
    private lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.menuIcon.image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Life Cycle
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        configUserInterface()
        configLayout()
        setButtonActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    public override func prepareForReuse() {
        titleImageView.image = nil
        schoolLabel.text = ""
        nameLabel.text = ""
        idLabel.text = ""
        heartButton.setImage(DesignSystemAsset.heartIcon.image, for: .normal)
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.addSubview(titleImageView)
        contentView.addSubview(schoolImageView)
        contentView.addSubview(schoolLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(idLabel)
        contentView.addSubview(chattingButton)
        contentView.addSubview(heartButton)
        contentView.addSubview(menuButton)
    }
    
    private func configLayout() {
        self.titleImageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        self.schoolImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-38)
            make.height.equalTo(24)
        }
        
        self.schoolLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.schoolImageView.snp.trailing).offset(2)
            make.bottom.equalToSuperview().offset(-38)
            make.width.equalTo(100)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-80)
            make.bottom.equalTo(self.schoolImageView.snp.top)
        }
        
        self.idLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalTo(self.nameLabel.snp.top).offset(-2)
        }
        
        self.menuButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-27.5)
            make.bottom.equalToSuperview().offset(-38)
            make.width.height.equalTo(24)
        }
        
        self.heartButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.menuButton.snp.top).offset(-16)
            make.width.height.equalTo(47)
        }
        
        self.chattingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.heartButton.snp.top).offset(-16)
            make.width.height.equalTo(47)
        }
    }
    
    private func setButtonActions() {
        chattingButton.addTarget(self, action: #selector(clickChattingButton(_:)), for: .touchUpInside)
        heartButton.addTarget(self, action: #selector(clickHeartButton(_:)), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(clickMenuButton(_:)), for: .touchUpInside)
    }
    
    public func setCell(teen: UserData) {
        if teen.profileImages == nil || teen.profileImages == "thumbnail_testKey" {
            switch teen.id {
            case 0:
                titleImageView.image = DesignSystemAsset.badge1.image
            case 1:
                titleImageView.image = DesignSystemAsset.badge8.image
            case 2:
                titleImageView.image = DesignSystemAsset.badge7.image
            case 3:
                titleImageView.image = DesignSystemAsset.badge4.image
            case 4:
                titleImageView.image = DesignSystemAsset.badge5.image
            case 5:
                titleImageView.image = DesignSystemAsset.badge3.image
            case 6:
                titleImageView.image = DesignSystemAsset.badge9.image
            case 7:
                titleImageView.image = DesignSystemAsset.badge6.image
            case 8:
                titleImageView.image = DesignSystemAsset.badge10.image
            default:
                titleImageView.image = DesignSystemAsset.badge2.image
            }
        } else {
            //TODO: url로 사진 가져오기
            titleImageView.image = DesignSystemAsset.badge4.image
        }
        schoolLabel.text = teen.schoolName
        nameLabel.text = teen.nickName
        idLabel.text = teen.uniqueId
        teen.likeStatus ? heartButton.setImage(DesignSystemAsset.heartFillIcon.image, for: .normal) :  heartButton.setImage(DesignSystemAsset.heartIcon.image, for: .normal)
    }
    
    public func getImage() -> UIImage {
        titleImageView.image ?? UIImage()
    }
    
    // MARK: - Actions
    @objc func clickChattingButton(_ sender: UIButton) {
        chatButtonAction?()
    }
    
    @objc func clickHeartButton(_ sender: UIButton) {
        heartButtonAction?()
    }
    
    @objc func clickMenuButton(_ sender: UIButton) {
        menuButtonAction?()
    }
}

extension TeenCollectionViewCell: Reusable { }
