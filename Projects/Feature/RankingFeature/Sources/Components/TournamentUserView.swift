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

final class TournamentUserView: UIView {
    let colors: [CGColor] = [
        UIColor.black.withAlphaComponent(0.5).cgColor,
        UIColor.black.withAlphaComponent(0).cgColor
    ]
    let width = ViewValues.height * 0.35 * 0.86
    let height = ViewValues.height * 0.35
    var image: UIImage?
    weak var delegate: TournamentUserCollectionViewCellDelegate?
    
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
    
    private lazy var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("투표 하기", for: .normal)
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
        delegate: TournamentUserCollectionViewCellDelegate
    ) {
        self.image = image
        self.delegate = delegate
        super.init(frame: frame)
        configUserInterface()
        configShadow()
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
        addSubview(selectButton)
    }
    
    private func configShadow() {
        selectButton.addDropYShadow(width: width - 32,
                                    height: 36,
                                    color: UIColor.black,
                                    opacity: 0.25,
                                    radius: 4,
                                    offset: CGSize(width: 0, height: 4))
//        selectButton.addInnerXYShadowToButton()
    }
    
    private func setupActions() {
        selectButton.addTarget(self,
                               action: #selector(didTapSelectButton(_: )),
                               for: .touchUpInside)
    }
    
    // MARK: - Actions    
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
        
        selectButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.bottom.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(36)
        }
    }
}
