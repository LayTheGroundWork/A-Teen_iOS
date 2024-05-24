//
//  CustomHeartView.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import SnapKit

import UIKit

class CustomHeartButton: UIButton {
    lazy var heartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "heartIcon")
        imageView.tintColor = .white
        return imageView
    }()
    
    lazy var heartCountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    init(frame: CGRect, text: String) {
        super.init(frame: frame)
        self.backgroundColor = .black
        
        self.heartCountLabel.text = text
        
        self.addSubview(heartImageView)
        self.addSubview(heartCountLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomHeartButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        heartImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(26)
        }
        
        heartCountLabel.snp.makeConstraints { make in
            make.top.equalTo(self.heartImageView.snp.bottom)
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalToSuperview().offset(-10)
            make.height.equalTo(24)
        }
    }
}


