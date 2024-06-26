//
//  TournamentUserCollectionViewCell.swift
//  RankingFeature
//
//  Created by phang on 6/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

final class TournamentUserCollectionViewCell: UICollectionViewCell {
    let width = UIScreen.main.bounds.height * 0.35 * 0.86
    let height = UIScreen.main.bounds.height * 0.35

    // MARK: - Private properties
    private lazy var AUserView = TournamentUserView(frame: .zero,
                                                    width: width,
                                                    height: height,
                                                    image: DesignSystemAsset.dressGlass.image,
                                                    delegate: self)
    
    private lazy var BUserView = TournamentUserView(frame: .zero,
                                                    width: width,
                                                    height: height,
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
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
        
        BUserView.snp.makeConstraints { make in
            make.top.equalTo(AUserView.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.equalTo(width)
            make.height.equalTo(height)
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
