//
//  SnsPlatformView.swift
//  ProfileDetailFeature
//
//  Created by 노주영 on 11/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import Domain
import DesignSystem
import UIKit

public protocol SnsPlatformViewDelegate: AnyObject {
    func didTapSnsPlatformButton(index: Int)
}

final class SnsPlatformView: UIView {
    private weak var coordinator: SnsPlatformViewDelegate?
    private var snsPlatform: SnsLinkData?
    private var viewList: [UIView] = []
    
    lazy var instagramButton: CustomSnsButton = {
        let button = CustomSnsButton(frame: .zero, image: DesignSystemAsset.instagramLogo.image)
        button.tag = 0
        button.addTarget(self, action: #selector(didTapSnsPlatformButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var xButton: CustomSnsButton = {
        let button = CustomSnsButton(frame: .zero, image: DesignSystemAsset.xLogo.image)
        button.tag = 1
        button.addTarget(self, action: #selector(didTapSnsPlatformButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var youtubeButton: CustomSnsButton = {
        let button = CustomSnsButton(frame: .zero, image: DesignSystemAsset.youtubeLogo.image)
        button.tag = 2
        button.addTarget(self, action: #selector(didTapSnsPlatformButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var tiktokButton: CustomSnsButton = {
        let button = CustomSnsButton(frame: .zero, image: DesignSystemAsset.tikTokLogo.image)
        button.tag = 3
        button.addTarget(self, action: #selector(didTapSnsPlatformButton(_:)), for: .touchUpInside)
        return button
    }()
    
    init(
        frame: CGRect,
        coordinator: SnsPlatformViewDelegate,
        snsPlatform: SnsLinkData?
    ) {
        self.coordinator = coordinator
        self.snsPlatform = snsPlatform
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func setUI() {
        self.backgroundColor = .systemBackground
        self.layer.cornerRadius = ViewValues.defaultRadius
        self.layer.borderWidth = 2
        self.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
        
        guard let snsPlatform = snsPlatform else { return }
        
        let snsList = [snsPlatform.instagram, snsPlatform.x, snsPlatform.youtube, snsPlatform.tiktok]
        
        for (index, sns) in snsList.enumerated() {
            if !sns.isEmpty {
                chooseSnsPlatform(index)
            }
        }
        
        let stackView = UIStackView(arrangedSubviews: viewList)
        stackView.axis = .horizontal
        stackView.alignment = .center
        
        self.addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func chooseSnsPlatform(_ index: Int) {
        if !viewList.isEmpty {
            let lineView = makeLineView()
            setConfigUserInterfaceAndLayout(lineView)
        }
        
        switch index {
        case 0:
            setConfigUserInterfaceAndLayout(instagramButton)
        case 1:
            setConfigUserInterfaceAndLayout(xButton)
        case 2:
            setConfigUserInterfaceAndLayout(youtubeButton)
        case 3:
            setConfigUserInterfaceAndLayout(tiktokButton)
        default:
            break
        }
    }
    
    private func setConfigUserInterfaceAndLayout(_ property: UIView) {
        viewList.append(property)
        self.addSubview(property)
        
        if property is CustomSnsButton {
            property.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.width.equalTo(70)
                make.height.equalTo(50)
            }
        } else {
            property.snp.makeConstraints { make in
                make.width.equalTo(1)
                make.height.equalTo(50)
            }
        }
    }
    
    @objc private func didTapSnsPlatformButton(_ sender: UIButton) {
        coordinator?.didTapSnsPlatformButton(index: sender.tag)
    }
}

extension SnsPlatformView {
    private func makeLineView() -> UIView {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.gray03.color
        view.layer.cornerRadius = 0.5
        return view
    }
}
