//
//  CustomNaviView.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import SnapKit

import UIKit

class CustomNaviView: UIView {
    lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(clickSearchButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var alarmButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bell.fill"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(clickAlarmButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(titleImageView)
        self.addSubview(alarmButton)
        self.addSubview(searchButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomNaviView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.titleImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(115)
            make.height.equalTo(30)
        }
        
        self.alarmButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalTo(self.titleImageView.snp.bottom).offset(-6)
            make.width.height.equalTo(24)
        }
        
        self.searchButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.alarmButton.snp.leading).offset(-20)
            make.bottom.equalTo(self.titleImageView.snp.bottom).offset(-6)
            make.width.height.equalTo(24)
        }
    }
}

// MARK: - Action
extension CustomNaviView {
    @objc func clickSearchButton(_ sender: UIButton) {
        print("검색 버튼 클릭")
    }
    
    @objc func clickAlarmButton(_ sender: UIButton) {
        print("알림 버튼 클릭")
    }
}


