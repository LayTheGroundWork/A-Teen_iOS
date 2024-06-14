//
//  AboutATeenTableViewCell.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import UIKit

class HeaderTableViewCell: UITableViewCell {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.anotherTeen
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(46)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension HeaderTableViewCell: Reusable { }
