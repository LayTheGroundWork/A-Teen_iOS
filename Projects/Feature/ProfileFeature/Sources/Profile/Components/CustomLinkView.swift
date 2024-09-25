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
    lazy var oneLinkImageView: UIImageView = makeLinkImageView()
    lazy var oneLinkLabel: UILabel = makeLinkLabel()
    
    lazy var twoLinkImageView: UIImageView = makeLinkImageView()
    lazy var twoLinkLabel: UILabel = makeLinkLabel()
    
    lazy var threeLinkImageView: UIImageView = makeLinkImageView()
    lazy var threeLinkLabel: UILabel = makeLinkLabel()
    
    lazy var fourLinkImageView: UIImageView = makeLinkImageView()
    lazy var fourLinkLabel: UILabel = makeLinkLabel()
    
    lazy var oneLineView: UIView = makeLineView()
    lazy var twoLineView: UIView = makeLineView()
    lazy var threeLineView: UIView = makeLineView()
    
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
    
    func makeLineView() -> UIView {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.grayLineColor.color
        view.layer.cornerRadius = 0.5
        return view
    }
}

// MARK: - UI
extension CustomLinkView {
    func configUserInterface(linkList: [(Int, String)]) {
        self.backgroundColor = DesignSystemAsset.gray03.color
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        
        for (index, linkInfo) in linkList.enumerated() {
            switch index {
            case 0:
                setProperties(
                    linkImageView: oneLinkImageView,
                    linkLabel: oneLinkLabel,
                    linkLineView: nil,
                    beforeImageView: nil,
                    linkInfo: linkInfo)
                
            case 1:
                setProperties(
                    linkImageView: twoLinkImageView,
                    linkLabel: twoLinkLabel,
                    linkLineView: oneLineView,
                    beforeImageView: oneLinkImageView,
                    linkInfo: linkInfo)
                
            case 2:
                setProperties(
                    linkImageView: threeLinkImageView,
                    linkLabel: threeLinkLabel,
                    linkLineView: twoLineView,
                    beforeImageView: twoLinkImageView,
                    linkInfo: linkInfo)
                
            case 3:
                setProperties(
                    linkImageView: fourLinkImageView,
                    linkLabel: fourLinkLabel,
                    linkLineView: threeLineView,
                    beforeImageView: threeLinkImageView,
                    linkInfo: linkInfo)
                
            default:
                break
            }
        }
    }
    
    func setProperties(
        linkImageView: UIImageView,
        linkLabel: UILabel,
        linkLineView: UIView?,
        beforeImageView: UIImageView?,
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
        
        self.addSubview(linkImageView)
        self.addSubview(linkLabel)
        
        if let linkLineView = linkLineView {
            self.addSubview(linkLineView)
        }
        
        configLabelLayout(
            linkImageView: linkImageView,
            linkLabel: linkLabel,
            linkLineView: linkLineView,
            beforeImageView: beforeImageView)
    }
}

// MARK: - Layout
extension CustomLinkView {
    func configLabelLayout(
        linkImageView: UIImageView,
        linkLabel: UILabel,
        linkLineView: UIView?,
        beforeImageView: UIImageView?
    ) {
        if let beforeImageView = beforeImageView, 
            let linkLineView = linkLineView {
            linkLineView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                make.top.equalTo(beforeImageView.snp.bottom).offset(13)
                make.height.equalTo(1)
            }
            
            linkImageView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.top.equalTo(linkLineView.snp.bottom).offset(14)
                make.width.height.equalTo(24)
            }
        } else {
            linkImageView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.top.equalToSuperview().offset(18)
                make.width.height.equalTo(24)
            }
        }
        
        linkLabel.snp.makeConstraints { make in
            make.leading.equalTo(linkImageView.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(linkImageView.snp.top)
            make.height.equalTo(24)
        }
    }
}

