//
//  CustomLineView.swift
//  HiProject
//
//  Created by 노주영 on 5/28/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

final class CustomLineView: UIView {
    
    lazy var firstColorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.mainColor.color
        return view
    }()
    
    lazy var secondColorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.mainColor.color
        return view
    }()
    
    lazy var thirdColorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.mainColor.color
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(firstColorLineView)
        self.addSubview(thirdColorLineView)
        self.addSubview(secondColorLineView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Layout
extension CustomLineView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        firstColorLineView.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(ViewValues.componentPickerWidth - 20)
        }
        
        thirdColorLineView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalToSuperview()
            make.width.equalTo(ViewValues.componentPickerWidth - 10)
        }
        
        secondColorLineView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(firstColorLineView.snp.trailing).offset(20)
            make.trailing.equalTo(thirdColorLineView.snp.leading).offset(-20)
        }
    }
}



