//
//  SeachSchoolResultTableViewCell.swift
//  ATeen
//
//  Created by 김명현 on 5/29/24.
//

import UIKit

class SearchSchoolResultTableViewCell: UITableViewCell {
    private lazy var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayQuestionCellColor")
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUserInterface() {
        self.selectionStyle = .none
        
        contentView.addSubview(schoolNameLabel)
        contentView.addSubview(lineView)
    }
    
    private func configLayout() {
        schoolNameLabel.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(47)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    override func prepareForReuse() {
        lineView.isHidden = false
    }
    
    func fontChange(with schoolName: String, isBold: Bool) {
        schoolNameLabel.text = schoolName
        schoolNameLabel.font = isBold ? UIFont.customFont(forTextStyle: .callout, weight: .bold) : UIFont.customFont(forTextStyle: .callout, weight: .regular)
    }
    
    func hiddenLineView(row: Int, lastIndex: Int) {
        if row == lastIndex {
            lineView.isHidden = true
        }
    }
}

extension SearchSchoolResultTableViewCell: Reusable { }
