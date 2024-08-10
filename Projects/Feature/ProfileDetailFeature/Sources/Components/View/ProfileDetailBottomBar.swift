//
//  ProfileDetailBottomBar.swift
//  ATeen
//
//  Created by 최동호 on 5/25/24.
//

import Common
import DesignSystem
import UIKit

public protocol ProfileDetailBottomBarDelegate: AnyObject {
    func didTapSNSButton(
        contentViewController: UIViewController
    )
}

final class ProfileDetailBottomBar: UIView {
    // MARK: - Private properties
    lazy var voteButton: UIButton = {
        let button = CustomVoteButton(
            imageName: "heartIcon",
            imageColor: UIColor.white,
            textColor: UIColor.white,
            labelText: "투표하기",
            buttonBackgroundColor: .black,
            labelFont: UIFont.preferredFont(forTextStyle: .caption1),
            frame: .zero)
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    lazy var messageButton: UIButton = makeSmallButton(imageName: "blackChattingIcon")
    
    lazy var snsButton: UIButton = makeSmallButton(imageName: "linkBlackIcon")
    
    private weak var coordinator: ProfileDetailBottomBarDelegate?
    
    init(
        frame: CGRect,
        coordinator: ProfileDetailBottomBarDelegate
    ) {
        self.coordinator = coordinator
        super.init(frame: frame)
        configUserInterface()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Helpers
    private func configUserInterface() {
        
        selfConfiguration()
        
        self.addSubview(voteButton)
        self.addSubview(messageButton)
        self.addSubview(snsButton)
        
        voteButton.snp.makeConstraints { make in
            make.width.equalTo(ViewValues.bottomVoteButtonWidth)
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.equalToSuperview().offset(15)
        }
        
        messageButton.snp.makeConstraints { make in
            make.width.equalTo(ViewValues.bottomSmallButtonWidth)
            make.height.equalTo(50)
            make.leading.equalTo(voteButton.snp.trailing).offset(ViewValues.defaultPadding)
            make.top.equalToSuperview().offset(15)
        }
        
        snsButton.snp.makeConstraints { make in
            make.width.equalTo(messageButton)
            make.height.equalTo(50)
            make.leading.equalTo(messageButton.snp.trailing).offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalToSuperview().offset(15)
        }
    }
    
    private func selfConfiguration() {
        self.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        self.layer.cornerRadius = ViewValues.defaultRadius
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        self.clipsToBounds = true
        
        // 그림자 설정
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = ViewValues.defaultRadius
        self.layer.masksToBounds = false
        
        // 블러 효과 추가
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = ViewValues.defaultRadius
        blurEffectView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        blurEffectView.clipsToBounds = true
        
        self.addSubview(blurEffectView)
    }
    
    private func makeSmallButton(imageName: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = ViewValues.defaultRadius
        button.backgroundColor = UIColor.white
        // 그림자 설정
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.15
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowRadius = 14
        button.layer.masksToBounds = false
        
        let imageView = UIImageView()
        imageView.image = imageForName(imageName)
        
        button.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.width.height.equalTo(26)
            make.center.equalToSuperview()
        }
        
        return button
    }
    
    private func imageForName(_ imageName: String) -> UIImage? {
        switch imageName {
        case "blackChattingIcon":
            return DesignSystemAsset.blackChattingIcon.image
        case "linkBlackIcon":
            return DesignSystemAsset.linkBlackIcon.image
        case "linkWhiteIcon":
            return DesignSystemAsset.linkWhiteIcon.image
        default:
            return nil
        }
    }
    
    private func setupActions() {
        snsButton.addTarget(self, action: #selector(didTapSNSButton), for: .touchUpInside)
    }
    
    @objc private func didTapSNSButton() {
        let contentViewController = SNSBottomSheetViewController()
        contentViewController.modalPresentationStyle = .pageSheet

        if let sheet = contentViewController.sheetPresentationController {
            // 지원할 크기 지정
            if #available(iOS 16.0, *) {
                sheet.detents = [.custom { context in
                    return 150
                }]
            } else {
                sheet.detents = [.medium()]
            }
            
            sheet.delegate = self
            
            // 시트 상단에 그래버 표시
            sheet.prefersGrabberVisible = true
            
            sheet.preferredCornerRadius = 25
            
            // 처음 크기 지정
            sheet.selectedDetentIdentifier = .medium
            
            // 뒤 배경 흐리게 제거
            // sheet.largestUndimmedDetentIdentifier = .medium
        }

        parentViewController?.present(contentViewController, animated: true, completion: nil)

        coordinator?.didTapSNSButton(
            contentViewController: contentViewController
        )
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

extension ProfileDetailBottomBar: UISheetPresentationControllerDelegate { }
