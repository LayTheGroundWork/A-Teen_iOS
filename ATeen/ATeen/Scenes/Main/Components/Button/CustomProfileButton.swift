//
//  CustomBadgeButton.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import SnapKit

import UIKit

class CustomProfileButton: UIButton {
    lazy var customTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return label
    }()
    
    lazy var rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rightIcon")
        imageView.tintColor = .white
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    init(frame: CGRect, title: String, count: String, imageString: String) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "mainColor")
        
        setInfomation(title: title, count: count, imageString: imageString)
        
        self.addSubview(rightArrowImageView)
        self.addSubview(customTitleLabel)
        self.addSubview(countLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setInfomation(title: String, count: String, imageString: String) {
        self.customTitleLabel.text = title
        self.countLabel.text = count
        //self.customImageView.image = UIImage(named: imageString)
    }
}

// MARK: - Layout
extension CustomProfileButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        rightArrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
        
        customTitleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
            make.trailing.equalTo(self.rightArrowImageView.snp.leading).offset(-16)
            make.height.equalTo(16)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(self.customTitleLabel.snp.bottom).offset(3)
            make.trailing.equalTo(self.rightArrowImageView.snp.leading).offset(-16)
            make.height.equalTo(16)
        }
    }
}


