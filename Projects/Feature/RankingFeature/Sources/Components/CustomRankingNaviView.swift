//
//  CustomRankingNaviView.swift
//  RankingFeature
//
//  Created by 김명현 on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

class CustomRankingNaviView: UIView {
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Ranking"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        return titleLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomRankingNaviView {
    override func layoutSubviews() {
        super.layoutSubviews()

        self.addSubview(titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
        }
    }
}


