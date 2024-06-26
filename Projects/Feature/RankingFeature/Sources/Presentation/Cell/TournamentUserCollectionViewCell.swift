//
//  TournamentUserCollectionViewCell.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

final class TournamentUserCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    private lazy var AUserView = TournamentUserView(frame: .zero,
                                                    image: DesignSystemAsset.dressGlass.image,
                                                    delegate: self)
    
    private lazy var BUserView = TournamentUserView(frame: .zero,
                                                    image: DesignSystemAsset.skyGlass.image,
                                                    delegate: self)
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.backgroundColor = .black
        
        contentView.addSubview(AUserView)
        contentView.addSubview(BUserView)
    }
    
    private func configLayout() {
        AUserView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.height.equalTo(ViewValues.height * 0.35)
            make.width.equalTo(BUserView.height).multipliedBy(0.86)
        }
        
        BUserView.snp.makeConstraints { make in
            make.top.equalTo(AUserView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(AUserView.height)
            make.width.equalTo(AUserView.width)
        }
    }
    
//    public func setProperties(
//        delegate: TournamentUserCollectionViewCellDelegate
//    ) {
//        self.delegate = delegate
//    }
    
    // MARK: - Actions
    
}

// MARK: - Extensions here
extension TournamentUserCollectionViewCell: Reusable { }

extension TournamentUserCollectionViewCell: TournamentUserViewDelegate {
    func didTapPlusButton() {
        // TODO: - 프로필로 이동
    }
    
    func didTapSelectButton() {
//        delegate?.didTapSelectButton()
    }
}
