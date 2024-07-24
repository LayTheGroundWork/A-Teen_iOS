//
//  ChatHeaderView.swift
//  ChatFeature
//
//  Created by 김명현 on 7/24/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit
import SnapKit

public enum HeaderLabel {
    case today
    case yesterday
    case theDayBeforeYesterday
    
    var localizedString: String {
        switch self {
        case .today:
            return "오늘"
        case .yesterday:
            return "어제"
        case .theDayBeforeYesterday:
            return "그제"
        }
    }
}

public final class ChatHeaderView: UITableViewHeaderFooterView {
    private var headerType: HeaderLabel = .today
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = headerType.localizedString
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = DesignSystemAsset.gray01.color
        
        return label
    }()
    
    private lazy var labelBackground: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.gray03.color
        view.layer.cornerRadius = 16
        
        return view
    }()
    
    public override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configUserInterFace()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(headerType: HeaderLabel) {
        self.headerType = headerType
        headerLabel.text = headerType.localizedString
    }
    
    private func configUserInterFace() {
        contentView.addSubview(labelBackground)
        labelBackground.addSubview(headerLabel)
    }
    
    private func configLayout() {
        labelBackground.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview() 
            make.height.equalTo(30)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 26, bottom: 0, right: 26))
        }
    }
    
}

extension ChatHeaderView: Reusable { }
