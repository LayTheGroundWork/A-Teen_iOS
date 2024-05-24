//
//  CustomQuestionTextView.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import SnapKit

import UIKit

class CustomQuestionTextView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(named: "grayTextColor")
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    init(frame: CGRect, index: Int, title: String, text: String) {
        super.init(frame: frame)
        self.titleLabel.text = "\(index). \(title)"
        self.textLabel.text = text
        
        self.addSubview(titleLabel)
        self.addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomQuestionTextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.greaterThanOrEqualTo(self.textLabel.textHeight(width: UIScreen.main.bounds.width - 31, font: self.titleLabel.font!, text: self.titleLabel.text!))
        }
        
        textLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset((self.titleLabel.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: self.titleLabel.font!]).height + 7)
            make.height.greaterThanOrEqualTo(self.textLabel.textHeight(width: UIScreen.main.bounds.width - 31, font: self.textLabel.font!, text: self.textLabel.text!))
        }
    }
}

