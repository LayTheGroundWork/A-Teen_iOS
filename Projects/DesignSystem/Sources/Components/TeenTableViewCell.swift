//
//  TeenTableViewCell.swift
//  DesignSystem
//
//  Created by 최동호 on 7/20/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import UIKit

public final class TeenTableViewCell: UITableViewCell {
    // MARK: - Private properties
    private let colors: [CGColor] = [
        .init(red: 0, green: 0, blue: 0, alpha: 0.5),
        .init(red: 0, green: 0, blue: 0, alpha: 0)
    ]
    
    public var chatButtonAction: (() -> Void)?
    public var heartButtonAction: (() -> Void)?
    public var menuButtonAction: (() -> Void)?

    lazy var topGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.locations = [0.0, 0.44, 1.0]
        return layer
    }()
    
    lazy var bottomGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0.5, y: 1.0)
        layer.endPoint = CGPoint(x: 0.5, y: 0.0)
        layer.locations = [0.0, 0.44, 1.0]
        return layer
    }()
    
    lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.addSublayer(topGradientLayer)
        imageView.layer.addSublayer(bottomGradientLayer)
        return imageView
    }()
    
    lazy var schoolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.schoolIcon.image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor.white
        return imageView
    }()
    
    lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.text = "인덕원고등학교"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = "ateen"
        label.textColor = DesignSystemAsset.gray03.color
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .bold)
        return label
    }()
    
    lazy var chattingButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.chattingIcon.image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = DesignSystemAsset.mainColor.color
        button.layer.cornerRadius = 23.5
        return button
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.heartIcon.image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = DesignSystemAsset.mainColor.color
        button.layer.cornerRadius = 23.5
        button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.menuIcon.image, for: .normal)
        button.tintColor = .white
        return button
    }()
    
    // MARK: - Life Cycle
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configUserInterface()
        configLayout()
        setButtonActions()
    }
 
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
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
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        self.schoolImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(24)
        }
        
        self.schoolLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.schoolImageView.snp.trailing).offset(2)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(100)
            make.height.equalTo(24)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-80)
            make.bottom.equalTo(self.schoolImageView.snp.top)
        }
        
        self.idLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.bottom.equalTo(self.nameLabel.snp.top).offset(-2)
        }
        
        self.menuButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-43.5)
            make.bottom.equalToSuperview().offset(-38)
            make.width.height.equalTo(24)
        }
        
        self.heartButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-32)
            make.bottom.equalTo(self.menuButton.snp.top).offset(-16)
            make.width.height.equalTo(47)
        }
        
        self.chattingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-32)
            make.bottom.equalTo(self.heartButton.snp.top).offset(-16)
            make.width.height.equalTo(47)
        }
    }
    
    private func setButtonActions() {
        chattingButton.addTarget(self, action: #selector(clickChattingButton(_:)), for: .touchUpInside)
        heartButton.addTarget(self, action: #selector(clickHeartButton(_:)), for: .touchUpInside)
        menuButton.addTarget(self, action: #selector(clickMenuButton(_:)), for: .touchUpInside)
    }
    
    public func setCell(teen: TodayTeen) {
        titleImageView.image = teen.image
        nameLabel.text = teen.name
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

extension TeenTableViewCell: Reusable { }
