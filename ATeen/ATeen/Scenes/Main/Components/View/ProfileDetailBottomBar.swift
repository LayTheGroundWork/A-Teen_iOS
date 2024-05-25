//
//  ProfileDetailBottomBar.swift
//  ATeen
//
//  Created by 최동호 on 5/25/24.
//

import UIKit

final class ProfileDetailBottomBar: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    lazy var tabBarView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        view.layer.cornerRadius = 20
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        view.clipsToBounds = true
        
        // 그림자 설정
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 30
        view.layer.masksToBounds = false
        
        // 블러 효과 추가
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.9
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 20
        blurEffectView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        blurEffectView.clipsToBounds = true
        
        view.addSubview(blurEffectView)
        return view
    }()
    
    lazy var voteButton: UIButton = makeCustomVoteButton()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .main
    }
    
    private func makeCustomVoteButton() -> UIButton {
        let button = UIButton()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "heartIcon")
        imageView.tintColor = .white
        
        let label = UILabel()
        label.text = "투표하기"
        label.tintColor = .white
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        button.addSubview(imageView)
        button.addSubview(label)
        
        return button
    }
    
    // MARK: - Actions
    
}

// MARK: - Extensions here

