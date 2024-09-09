//
//  CustomLinkView.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public class CustomLinkView: UIView {
    lazy var oneBackgroundView: UIView = makeBackgroundView()
    lazy var oneLinkImageView: UIImageView = makeLinkImageView()
    lazy var oneLinkLabel: UILabel = makeLinkLabel()
    
    lazy var twoBackgroundView: UIView = makeBackgroundView()
    lazy var twoLinkImageView: UIImageView = makeLinkImageView()
    lazy var twoLinkLabel: UILabel = makeLinkLabel()
    
    lazy var threeBackgroundView: UIView = makeBackgroundView()
    lazy var threeLinkImageView: UIImageView = makeLinkImageView()
    lazy var threeLinkLabel: UILabel = makeLinkLabel()
    
    lazy var fourBackgroundView: UIView = makeBackgroundView()
    lazy var fourLinkImageView: UIImageView = makeLinkImageView()
    lazy var fourLinkLabel: UILabel = makeLinkLabel()
    
    public init(frame: CGRect, linkList: [(Int, String)]) {
        super.init(frame: frame)
        configUserInterface(linkList: linkList)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Properties
extension CustomLinkView {
    func makeBackgroundView() -> UIView {
        let view = UIView()
        view.layer.borderWidth = 2.0
        view.layer.cornerRadius = 10
        view.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
        return view
    }
    
    func makeLinkImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }
    
    func makeLinkLabel() -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }
}

// MARK: - UI
extension CustomLinkView {
    func configUserInterface(linkList: [(Int, String)]) {
//        self.backgroundColor = DesignSystemAsset.gray03.color
//        self.layer.masksToBounds = true
//        self.layer.cornerRadius = 20
        
        for (index, linkInfo) in linkList.enumerated() {
            switch index {
            case 0:
                setProperties(
                    linkBackgroundView: oneBackgroundView,
                    linkImageView: oneLinkImageView,
                    linkLabel: oneLinkLabel,
                    beforeBackgroundView: nil,
                    linkInfo: linkInfo)
                
            case 1:
                setProperties(
                    linkBackgroundView: twoBackgroundView,
                    linkImageView: twoLinkImageView,
                    linkLabel: twoLinkLabel,
                    beforeBackgroundView: oneBackgroundView,
                    linkInfo: linkInfo)
                
            case 2:
                setProperties(
                    linkBackgroundView: threeBackgroundView,
                    linkImageView: threeLinkImageView,
                    linkLabel: threeLinkLabel,
                    beforeBackgroundView: twoBackgroundView,
                    linkInfo: linkInfo)
                
            case 3:
                setProperties(
                    linkBackgroundView: fourBackgroundView,
                    linkImageView: fourLinkImageView,
                    linkLabel: fourLinkLabel,
                    beforeBackgroundView: threeBackgroundView,
                    linkInfo: linkInfo)
                
            default:
                break
            }
        }
    }
    
    func setProperties(
        linkBackgroundView: UIView,
        linkImageView: UIImageView,
        linkLabel: UILabel,
        beforeBackgroundView: UIView?,
        linkInfo: (Int, String)
    ) {
        switch linkInfo.0 {
        case 0: linkImageView.image = DesignSystemAsset.instagramLogo.image
        case 1: linkImageView.image = DesignSystemAsset.xLogo.image
        case 2: linkImageView.image = DesignSystemAsset.tikTokLogo.image
        case 3: linkImageView.image = DesignSystemAsset.youtubeLogo.image
        default:
            break
        }
        
        linkLabel.text = linkInfo.1
        
        self.addSubview(linkBackgroundView)
        
        linkBackgroundView.addSubview(linkImageView)
        linkBackgroundView.addSubview(linkLabel)
        
        configLabelLayout(
            linkBackgroundView: linkBackgroundView,
            linkImageView: linkImageView,
            linkLabel: linkLabel,
            beforeBackgroundView: beforeBackgroundView)
    }
}

// MARK: - Layout
extension CustomLinkView {
    func configLabelLayout(
        linkBackgroundView: UIView,
        linkImageView: UIImageView,
        linkLabel: UILabel,
        beforeBackgroundView: UIView?
    ) {
        if let beforeBackgroundView = beforeBackgroundView {
            linkBackgroundView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(beforeBackgroundView.snp.bottom).offset(10)
                make.height.equalTo(48)
            }
        } else {
            linkBackgroundView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalToSuperview().offset(18)
                make.height.equalTo(48)
            }
        }
        
        linkImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(14)
            make.top.equalToSuperview().offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.width.equalTo(24)
        }
        
        linkLabel.snp.makeConstraints { make in
            make.leading.equalTo(linkImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(linkImageView.snp.top)
            make.height.equalTo(24)
        }
    }
}

