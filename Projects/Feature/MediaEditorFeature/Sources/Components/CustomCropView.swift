//
//  CustomCropView.swift
//  MediaEditorFeature
//
//  Created by 노주영 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import UIKit

final class CustomCropView: UIView {
    let imageSize: CGSize
    
    private lazy var firstLineView: UIView = makeLineView()
    
    private lazy var secondLineView: UIView = makeLineView()
    
    private lazy var thirdLineView: UIView = makeLineView()
    
    private lazy var fourthLineView: UIView = makeLineView()
    
    init(frame: CGRect, imageSize: CGSize) {
        self.imageSize = imageSize
        super.init(frame: frame)
        
        self.linesChangeState(isCropping: true)
        
        self.addSubview(firstLineView)
        self.addSubview(secondLineView)
        self.addSubview(thirdLineView)
        self.addSubview(fourthLineView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func linesChangeState(isCropping: Bool) {
        if isCropping {
            UIView.animate(withDuration: 0.2, delay: 0) {
                self.firstLineView.isHidden = false
                self.secondLineView.isHidden = false
                self.thirdLineView.isHidden = false
                self.fourthLineView.isHidden = false
            }
        } else {
            UIView.animate(withDuration: 0.2, delay: 0) {
                self.firstLineView.isHidden = true
                self.secondLineView.isHidden = true
                self.thirdLineView.isHidden = true
                self.fourthLineView.isHidden = true
            }
        }
    }
    
    private func makeLineView() -> UIView {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }
}

// MARK: - Layout
extension CustomCropView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let width = self.bounds.size.width
        let height = self.bounds.size.height
        
        firstLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalToSuperview().offset(height / 3)
        }
        
        secondLineView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(self.firstLineView.snp.centerY).offset(height / 3)
        }
        
        thirdLineView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(0.5)
            make.leading.equalToSuperview().offset(width / 3)
        }
        
        fourthLineView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.width.equalTo(0.5)
            make.leading.equalTo(self.thirdLineView.snp.centerX).offset(width / 3)
        }
    }
}
