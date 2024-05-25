//
//  ProfileDetailBottomBar.swift
//  ATeen
//
//  Created by 최동호 on 5/25/24.
//

import UIKit

final class ProfileDetailBottomBar: UIView {
    // MARK: - Private properties
    lazy var voteButton: UIButton = {
        let button = CustomVoteButton(
            imageName: "heartIcon",
            imageColor: .white,
            textColor: .white,
            labelText: "투표하기",
            buttonBackgroundColor: .main,
            labelFont: UIFont.preferredFont(forTextStyle: .caption1),
            frame: .zero)
        button.layer.cornerRadius = 20
        return button
    }()
    
    lazy var messageButton: UIButton = makeSmallButton(imageName: "blackChattingIcon")
    
    lazy var snsButton: UIButton = makeSmallButton(imageName: "instaIcon")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    private func configUserInterface() {
        let screenWidth = UIScreen.main.bounds.width
        let voteButtonWidth = (screenWidth - 48) / 2
        
        selfConfiguration()
        
        self.addSubview(voteButton)
        self.addSubview(messageButton)
        self.addSubview(snsButton)
        
        voteButton.snp.makeConstraints { make in
            make.width.equalTo(voteButtonWidth)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(15)
        }
        
        messageButton.snp.makeConstraints { make in
            make.width.equalTo((voteButtonWidth - 16) / 2)
            make.height.equalTo(50)
            make.leading.equalTo(voteButton.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(15)
        }
        
        snsButton.snp.makeConstraints { make in
            make.width.equalTo(messageButton)
            make.height.equalTo(50)
            make.leading.equalTo(messageButton.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(15)
        }
    }
    
    private func selfConfiguration() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.layer.cornerRadius = 20
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.clipsToBounds = true
        
        // 그림자 설정
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.layer.shadowRadius = 30
        self.layer.masksToBounds = false
        
        // 블러 효과 추가
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 20
        blurEffectView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        blurEffectView.clipsToBounds = true
        
        self.addSubview(blurEffectView)
    }
    
    private func makeSmallButton(imageName: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.backgroundColor = .white
        // 그림자 설정
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.1
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowRadius = 30
        button.layer.masksToBounds = false
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        button.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.center.equalToSuperview()
        }
        
        return button
    }
}
