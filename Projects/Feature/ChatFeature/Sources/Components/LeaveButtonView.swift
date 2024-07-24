//
//  LeaveButtonView.swift
//  ChatFeature
//
//  Created by 김명현 on 7/19/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit

public final class LeaveButtonView: UIView {
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = "나가기"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .red
        addSubview(label)

        // 레이아웃 설정
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
//        // 오른쪽 변만 cornerRadius 주기
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: [.topRight, .bottomRight], cornerRadii: CGSize(width: 12, height: 12))
        let mask = CAShapeLayer()
        
        mask.path = path.cgPath
        
        self.layer.mask = mask
    }
}

