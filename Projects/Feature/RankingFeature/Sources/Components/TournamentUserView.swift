//
//  TournamentUserView.swift
//  RankingFeature
//
//  Created by phang on 6/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

protocol TournamentUserViewDelegate: AnyObject {
    func didTapPlusButton()
    func didTapSelectButton()
}

final class TournamentUserView: UIView {
    let colors: [CGColor] = [
        UIColor.black.withAlphaComponent(0.5).cgColor,
        UIColor.black.withAlphaComponent(0).cgColor
    ]
    let width = ViewValues.height * 0.35
    let height = ViewValues.height * 0.35 * 0.86
    var image: UIImage?
    weak var delegate: TournamentUserViewDelegate?
    
    // MARK: - Private properties
    private lazy var bottomGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0,
                             y: height / 2,
                             width: width,
                             height: height / 2)
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0.5, y: 1.0)
        layer.endPoint = CGPoint(x: 0.5, y: 0.0)
        layer.locations = [0.0, 0.44, 1.0]
        return layer
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.addSublayer(bottomGradientLayer)
        return imageView
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.plusIcon.image, for: .normal)
        button.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button.layer.cornerRadius = ViewValues.defaultRadius
        let blurEffectView = makeBlur(to: button)
        button.addSubview(blurEffectView)
        return button
    }()
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("선택 하기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: .highlighted)
        button.titleLabel?.font = .customFont(forTextStyle: .footnote, weight: .regular)
        button.backgroundColor = DesignSystemAsset.mainColor.color
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    // MARK: - Life Cycle
    init(
        frame: CGRect,
        image: UIImage,
        delegate: TournamentUserViewDelegate
    ) {
        self.image = image
        self.delegate = delegate
        super.init(frame: frame)
        configUserInterface()
        configButtonShadow()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.backgroundColor = UIColor.white
        self.clipsToBounds = true
        self.layer.cornerRadius = ViewValues.defaultRadius
        
        addSubview(imageView)
        addSubview(plusButton)
        addSubview(selectButton)
    }
    
    private func configButtonShadow() {
        plusButton.addDropYShadow(width: 42,
                                  height: 36)
        selectButton.addDropYShadow(width: width - 84,
                                    height: 36)
//        selectButton.addInnerXYShadow()
    }
    
    private func setupActions() {
        plusButton.addTarget(self,
                             action: #selector(didTapPlusButton(_: )),
                             for: .touchUpInside)
        selectButton.addTarget(self,
                               action: #selector(didTapSelectButton(_: )),
                               for: .touchUpInside)
    }
    
    private func makeBlur<T: UIView>(to view: T) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.8
        return blurEffectView
    }
    
    // MARK: - Actions
    @objc private func didTapPlusButton(_ sender: UIButton) {
        // TODO: - 유저 프로필로 이동
    }
    
    @objc private func didTapSelectButton(_ sender: UIButton) {
        delegate?.didTapSelectButton()
    }
}

// MARK: - Extensions here
extension TournamentUserView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        plusButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.equalTo(42)
            make.height.equalTo(36)
        }
        
        selectButton.snp.makeConstraints { make in
            make.leading.equalTo(plusButton.snp.trailing).offset(10)
            make.bottom.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(36)
        }
    }
}

extension UIButton {
    func addDropYShadow(width: Double, height: Double) {
        let renderRect = CGRect(x: 0,
                                y: bounds.height + 1,
                                width: width,
                                height: height)
        layer.shadowPath = UIBezierPath(roundedRect: renderRect,
                                        cornerRadius: layer.cornerRadius).cgPath
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
//    func addDropYShadow() {
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.25
//        self.layer.shadowRadius = 4
//        self.layer.shadowOffset = CGSize(width: 0, height: 4)
//    }
    
    func addInnerXYShadow() {
    }
}
