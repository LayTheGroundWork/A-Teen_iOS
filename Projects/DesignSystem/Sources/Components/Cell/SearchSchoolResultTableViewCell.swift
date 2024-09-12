//
//  SeachSchoolResultTableViewCell.swift
//  ATeen
//
//  Created by 김명현 on 5/29/24.
//

import Common
import Domain
import DesignSystem
import UIKit

public final class SearchSchoolResultTableViewCell: UITableViewCell {
    private lazy var schoolNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .body, weight: .regular)
        return label
    }()
    
    private lazy var schoolAddressLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray01.color
        return label
    }()
    
    private lazy var lineView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.gray03.color
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
    
    public override func prepareForReuse() {
        lineView.isHidden = false
        schoolNameLabel.font = UIFont.customFont(forTextStyle: .callout, weight: .regular)
    }
    
    private func configUserInterface() {
        self.selectionStyle = .none
        
        contentView.addSubview(schoolNameLabel)
        contentView.addSubview(schoolAddressLabel)
        contentView.addSubview(lineView)
    }
    
    private func configLayout() {
        schoolNameLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(11)
        }
        
        schoolAddressLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(schoolNameLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().offset(-10)
        }
        
        lineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    public func fontChange(schoolData: SchoolData?, isBold: Bool) {
        guard let schoolData = schoolData else { return }
        schoolNameLabel.text = schoolData.schoolName
        schoolNameLabel.font = isBold ? UIFont.customFont(forTextStyle: .callout, weight: .bold) : UIFont.customFont(forTextStyle: .callout, weight: .regular)
        schoolAddressLabel.text = schoolData.schoolLocation
    }
    
    public func hiddenLineView(row: Int, lastIndex: Int) {
        if row == lastIndex {
            lineView.isHidden = true
        }
    }
}

extension SearchSchoolResultTableViewCell: Reusable { }
