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
    
    public init(frame: CGRect, linkList: [(link: String, title: String?)]) {
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
        imageView.image = DesignSystemAsset.linkIcon.image
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
    func configUserInterface(linkList: [(link: String, title: String?)]) {
        self.backgroundColor = DesignSystemAsset.gray03.color
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 20
        
        for (index, linkInfo) in linkList.enumerated() {
            switch index {
            case 0:
                setProperties(
                    linkImageView: oneLinkImageView,
                    linkLabel: oneLinkLabel,
                    beforeImageView: nil,
                    linkInfo: linkInfo)
                
            case 1:
                setProperties(
                    linkImageView: twoLinkImageView,
                    linkLabel: twoLinkLabel,
                    beforeImageView: oneLinkImageView,
                    linkInfo: linkInfo)
                
            case 2:
                setProperties(
                    linkImageView: threeLinkImageView,
                    linkLabel: threeLinkLabel,
                    beforeImageView: twoLinkImageView,
                    linkInfo: linkInfo)
                
            default:
                break
            }
        }
    }
    
    func setProperties(
        linkImageView: UIImageView,
        linkLabel: UILabel,
        beforeImageView: UIImageView?,
        linkInfo: (link: String, title: String?)
    ) {
        if let title = linkInfo.title {
            let text = "\(title) | \(linkInfo.link)"
            let attributedStr = NSMutableAttributedString(string: text)
            attributedStr.addAttribute(.foregroundColor,
                                       value: DesignSystemAsset.gray01.color,
                                       range: (text as NSString).range(of: "|"))
            linkLabel.attributedText = attributedStr
        } else {
            linkLabel.text = linkInfo.link
        }
        
        self.addSubview(linkImageView)
        self.addSubview(linkLabel)
        
        configLabelLayout(
            linkImageView: linkImageView,
            linkLabel: linkLabel,
            beforeImageView: beforeImageView)
    }
}

// MARK: - Layout
extension CustomLinkView {
    func configLabelLayout(
        linkImageView: UIImageView,
        linkLabel: UILabel,
        beforeImageView: UIImageView?
    ) {
        if let beforeImageView = beforeImageView {
            linkImageView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.top.equalTo(beforeImageView.snp.bottom).offset(10)
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
            make.leading.equalTo(linkImageView.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(linkImageView.snp.top)
            make.height.equalTo(24)
        }
    }
}

