//
//  CategoryTournamentCollectionViewCell.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import SnapKit

import UIKit

class CategoryTournamentCollectionViewCell: UICollectionViewCell {
    lazy var categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(categoryImageView)
        
        self.categoryImageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        categoryImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(19)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        titleLabel.text = ""
        categoryImageView.image = nil
        categoryImageView.backgroundColor = .systemGray4
    }
    
    func setUI(category: TournamentCategory) {
        titleLabel.text = category.title
        categoryImageView.image = UIImage(named: category.image)
        
        switch category.title {
        case "운동":
            categoryImageView.backgroundColor = UIColor(named: "mainColor")
            
        case "스터디":
            categoryImageView.backgroundColor = UIColor(named: "mainOrangeColor")
            
        default:
            categoryImageView.backgroundColor = .systemGray4
        }
    }
}

extension CategoryTournamentCollectionViewCell: Reusable { }
