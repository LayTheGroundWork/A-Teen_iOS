//
//  AboutATeenCustomView.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import SnapKit

import UIKit

class CustomAboutATeenView: UIView {
    lazy var customView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(named: "mainPartBorderColor")?.cgColor
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = UIColor(named: "mainColor")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "mainColor")
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(named: "mainColor")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 2
        return label
    }()
    
    init(frame: CGRect, imageName: String, title: String, text: String) {
        super.init(frame: frame)
        self.titleImageView.image = UIImage(systemName: imageName)
        self.titleLabel.text = title
        self.textLabel.text = text
        
        self.addSubview(customView)
        
        self.customView.addSubview(titleImageView)
        self.customView.addSubview(titleLabel)
        self.customView.addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomAboutATeenView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.customView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        titleImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(14)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.titleImageView.snp.trailing).offset(5)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(24)
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.titleImageView.snp.leading)
            make.trailing.equalTo(self.titleLabel.snp.trailing)
            make.top.equalTo(self.titleImageView.snp.bottom).offset(2)
            make.bottom.equalToSuperview().offset(-14)
        }
    }
}


