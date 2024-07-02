//
//  MainTabController.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import DesignSystem
import UIKit

final class MainTabController: UITabBarController {
    
    // MARK: - Public properties
    lazy var mainButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: DesignSystemAsset.mainIcon.name,
            selectedImageName: DesignSystemAsset.mainIconSelected.name,
            imageColor: nil,
            textColor: DesignSystemAsset.mainColor.color,
            labelText: "Main",
            buttonBackgroundColor: UIColor.clear,
            labelFont: UIFont.preferredFont(
                forTextStyle: .footnote),
            frame: .zero)
        button.tag = 0
        button.isSelected = true
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rankingButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: DesignSystemAsset.rankingIcon.name,
            selectedImageName: DesignSystemAsset.rankingIconSelected.name,
            imageColor: nil,
            textColor: UIColor.white,
            labelText: "Ranking",
            buttonBackgroundColor: UIColor.clear,
            labelFont: UIFont.preferredFont(
                forTextStyle: .footnote),
            frame: .zero)
        button.tag = 1
        button.isSelected = false
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var teenButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: DesignSystemAsset.teenIcon.name,
            selectedImageName: DesignSystemAsset.teenIconSelected.name,
            imageColor: nil,
            textColor: UIColor.white,
            labelText: "Teen",
            buttonBackgroundColor: UIColor.clear,
            labelFont: UIFont.preferredFont(
                forTextStyle: .footnote),
            frame: .zero)
        button.tag = 2
        button.isSelected = false
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var chatButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: "chatIcon",
            selectedImageName: DesignSystemAsset.chatIconSelected.name,
            imageColor: nil,
            textColor: UIColor.white,
            labelText: "Chat",
            buttonBackgroundColor: UIColor.clear,
            labelFont: UIFont.preferredFont(
                forTextStyle: .footnote),
            frame: .zero)
        button.tag = 3
        button.isSelected = false
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var profileButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: DesignSystemAsset.profile.name,
            selectedImageName: nil,
            imageColor: nil,
            textColor: UIColor.white,
            labelText: "My",
            buttonBackgroundColor: .clear,
            labelFont: UIFont.preferredFont(
                forTextStyle: .footnote),
            frame: .zero)
        button.tag = 4
        button.isSelected = false
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 14
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var tabBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.layer.cornerRadius = 20
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.clipsToBounds = true
        
        // 블러 효과 추가
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 20
        blurEffectView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        blurEffectView.clipsToBounds = true
        
        view.addSubview(blurEffectView)
        return view
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        self.tabBar.isHidden = true
        
        view.addSubview(tabBarView)
        self.clickButton(mainButton)
        
        tabBarView.setConstraints(
            right: view.rightAnchor,
            bottom: view.bottomAnchor,
            left: view.leftAnchor)
        
        tabBarView.setHeightConstraint(with: 80)
        
        let stackView = UIStackView(arrangedSubviews: [mainButton, rankingButton, teenButton, chatButton, profileButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        tabBarView.addSubview(stackView)
        
        stackView.setConstraints(
            top: tabBarView.topAnchor,
            right: tabBarView.rightAnchor,
            bottom: tabBarView.bottomAnchor,
            left: tabBarView.leftAnchor)
    }
}

extension MainTabController {
    @objc func clickButton(_ sender: CustomTabBarButton) {
        let beforeIndex = self.selectedIndex
        
        switch beforeIndex {
        case 0:
            changeBeforeButtonState(button: mainButton)
        case 1:
            changeBeforeButtonState(button: rankingButton)
        case 2:
            changeBeforeButtonState(button: teenButton)
        case 3:
            changeBeforeButtonState(button: chatButton)
        case 4:
            changeBeforeButtonState(button: profileButton)
        default:
            break
        }
        
        switch sender.tag {
        case 0:
            selectButtonState(button: mainButton)
        case 1:
            selectButtonState(button: rankingButton)
        case 2:
            selectButtonState(button: teenButton)
        case 3:
            selectButtonState(button: chatButton)
        case 4:
            selectButtonState(button: profileButton)
        default:
            break
        }
    }
    
    private func changeBeforeButtonState(button: CustomTabBarButton) {
        updateNotSelectButton(button)
        button.customLabel.textColor = UIColor.white
        button.isSelected = false
    }
    
    private func selectButtonState(button: CustomTabBarButton) {
        updateSelectButton(button)
        button.customLabel.textColor = DesignSystemAsset.mainColor.color
        button.isSelected = true
        
        self.selectedIndex = button.tag
    }
    
    private func updateSelectButton(_ button: CustomTabBarButton) {
        button.updateImage(for: .selected)
    }
    
    private func updateNotSelectButton(_ button: CustomTabBarButton) {
        button.updateImage(for: .normal)
    }
    
    func showTabbar() {
        tabBarView.isHidden = false
    }
    
    func hideTabbar() {
        tabBarView.isHidden = true
    }
}
