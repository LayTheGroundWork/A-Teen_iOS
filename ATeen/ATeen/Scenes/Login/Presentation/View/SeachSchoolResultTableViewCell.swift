//
//  SeachSchoolResultTableViewCell.swift
//  ATeen
//
//  Created by 김명현 on 5/29/24.
//

import UIKit

class SeachSchoolResultTableViewCell: UITableViewCell {
    
    let schoolNameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUserInterface() {
        contentView.addSubview(schoolNameLabel)
        
        schoolNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(ViewValues.defaultSpacing)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultSpacing)
        }
    }
    
    func configure(with schoolName: String) {
        schoolNameLabel.text = schoolName
    }
}
