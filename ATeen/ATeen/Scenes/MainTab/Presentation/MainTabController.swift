//
//  MainTabController.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

final class MainTabController: UITabBarController {
    // MARK: - Life Cycle
    let mainButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: "mainIconSelected",
            textColor: .main,
            labelText: "Main",
            frame: .zero)
        
        return button
    }()
    
    let rankingButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: "rankingIcon",
            textColor: .white,
            labelText: "Ranking",
            frame: .zero)
        
        return button
    }()
    
    let teenButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: "teenIcon",
            textColor: .white,
            labelText: "Teen",
            frame: .zero)
        
        return button
    }()
    
    let chatButton: CustomTabBarButton = {
        let button = CustomTabBarButton(
            imageName: "chatIcon",
            textColor: .white,
            labelText: "Chat",
            frame: .zero)
        
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
        
        let stackView = UIStackView(arrangedSubviews: [mainButton, rankingButton, teenButton, chatButton])
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
