//
//  MyBadgeDetailViewController.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/13/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol MyBadgeDetailViewControllerCoordinator: AnyObject {
    func didFinish()
}

public final class MyBadgeDetailViewController: UIViewController {
    // MARK: - Private properties
    private weak var coordinator: MyBadgeDetailViewControllerCoordinator?
    
    private lazy var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.xMarkIcon.image, for: .normal)
        button.addTarget(self, action: #selector(clickCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var badgeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 58
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    private lazy var explainLabel: UILabel = {
        let label = UILabel()
        label.textColor = DesignSystemAsset.gray02.color
        label.textAlignment = .center
        label.font = .customFont(forTextStyle: .callout, weight: .regular)
        label.numberOfLines = 2
        return label
    }()

    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    public init(
        coordinator: MyBadgeDetailViewControllerCoordinator,
        badge: Badge
    ) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        
        badgeImageView.image = changeBadgeToImage(badge.type)
        titleLabel.text = badge.type.rawValue
        explainLabel.text = badge.explain
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(dialogView)

        dialogView.addSubview(closeButton)
        dialogView.addSubview(badgeImageView)
        dialogView.addSubview(titleLabel)
        dialogView.addSubview(explainLabel)
    }
    
    private func configLayout() {
        dialogView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.centerY.equalToSuperview()
            make.height.equalTo(372)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(24)
        }
        
        badgeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(dialogView.snp.centerY).offset(-5)
            make.width.height.equalTo(116)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(badgeImageView.snp.bottom).offset(22)
        }
        
        explainLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.top.equalTo(titleLabel.snp.bottom).offset(13)
        }
    }
    
    private func changeBadgeToImage(_ badgeType: BadgeType) -> UIImage {
        switch badgeType {
        case .badge1:
            DesignSystemAsset.badge1.image
        case .badge2:
            DesignSystemAsset.badge2.image
        case .badge3:
            DesignSystemAsset.badge3.image
        case .badge4, .badge5, .badge6, .badge7, .badge8, .badge9, .badge10, .badge11, .badge12:
            DesignSystemAsset.badge4.image
        }
    }

    // MARK: - Actions
    @objc private func clickCloseButton(_ sender: UIButton) {
        coordinator?.didFinish()
    }
}
