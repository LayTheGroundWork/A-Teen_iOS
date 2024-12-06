//
//  CategoryCollectionViewCell.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import SnapKit

import Common
import UIKit

class CategoryTodayCollectionViewCell: UICollectionViewCell {
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.tintColor = UIColor.black
        label.backgroundColor = UIColor.white
        label.layer.masksToBounds = true
        label.layer.borderWidth = 1
        label.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.layer.cornerRadius = 20
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryLabel)
        
        self.categoryLabel.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        categoryLabel.textColor = .black
        categoryLabel.tintColor = .black
        categoryLabel.backgroundColor = .white
    }
    
    func setButton(category: ProfileCategory) {
        if category.isSelect {
            categoryLabel.textColor = .white
            categoryLabel.backgroundColor = .black
        }
        categoryLabel.text = category.title
    }
}

extension CategoryTodayCollectionViewCell: Reusable { }
