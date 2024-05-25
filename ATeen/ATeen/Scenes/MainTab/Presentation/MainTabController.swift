//
//  MainTabController.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

final class MainTabController: UITabBarController {
    
    // MARK: - Public properties
    lazy var mainButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: "mainIconSelected",
            imageColor: nil,
            textColor: .main,
            labelText: "Main",
            buttonBackgroundColor: .clear,
            labelFont: UIFont.preferredFont(
                forTextStyle: .footnote),
            frame: .zero)
        button.tag = 0
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var rankingButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: "rankingIcon",
            imageColor: nil,
            textColor: .white,
            labelText: "Ranking",
            buttonBackgroundColor: .clear,
            labelFont: UIFont.preferredFont(
                forTextStyle: .footnote),
            frame: .zero)
        button.tag = 1
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var teenButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: "teenIcon",
            imageColor: nil,
            textColor: .white,
            labelText: "Teen",
            buttonBackgroundColor: .clear,
            labelFont: UIFont.preferredFont(
                forTextStyle: .footnote),
            frame: .zero)
        button.tag = 2
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var chatButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: "chatIcon",
            imageColor: nil,
            textColor: .white,
            labelText: "Chat",
            buttonBackgroundColor: .clear,
            labelFont: UIFont.preferredFont(
                forTextStyle: .footnote),
            frame: .zero)
        button.tag = 3
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var profileButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: "profile",
            imageColor: nil,
            textColor: .white,
            labelText: "My",
            buttonBackgroundColor: .clear,
            labelFont: UIFont.preferredFont(
                forTextStyle: .footnote),
            frame: .zero)
        button.tag = 4
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
        switch button.tag {
        case 0:
            button.customImageView.image = UIImage(named: "mainIcon")
        case 1:
            button.customImageView.image = UIImage(named: "rankingIcon")
        case 2:
            button.customImageView.image = UIImage(named: "teenIcon")
        case 3:
            button.customImageView.image = UIImage(named: "chatIcon")
        default:
            break
        }
        button.customLabel.textColor = .white
        button.isSelected = false
    }
    
    private func selectButtonState(button: CustomTabBarButton) {
        switch button.tag {
        case 0:
            button.customImageView.image = UIImage(named: "mainIconSelected")
        case 1:
            button.customImageView.image = UIImage(named: "rankingIconSelected")
        case 2:
            button.customImageView.image = UIImage(named: "teenIconSelected")
        case 3:
            button.customImageView.image = UIImage(named: "chatIconSelected")
        default:
            break
        }
        button.customLabel.textColor = UIColor(named: "mainColor")
        button.isSelected = true
        
        self.selectedIndex = button.tag
    }
}
