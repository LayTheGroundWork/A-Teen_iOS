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
    let width = ViewValues.height * 0.35 * 0.86
    let height = ViewValues.height * 0.35
    var image: UIImage?
    weak var delegate: TournamentUserCollectionViewCellDelegate?
    
    // MARK: - Private properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
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
        tag: Int,
        image: UIImage,
        delegate: TournamentUserCollectionViewCellDelegate
    ) {
        self.image = image
        self.delegate = delegate
        super.init(frame: frame)
        
        self.tag = tag
        
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
    }
    
    private func setupActions() {
        selectButton.addTarget(self,
                               action: #selector(didTapSelectButton(_: )),
                               for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func didTapSelectButton(_ sender: UIButton) {
        delegate?.didTapSelectButton(tag: self.tag)
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
