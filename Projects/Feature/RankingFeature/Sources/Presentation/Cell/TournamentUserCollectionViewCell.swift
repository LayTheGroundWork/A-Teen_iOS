//
//  TournamentUserCollectionViewCell.swift
//  RankingFeature
//
//  Created by phang on 6/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

protocol TournamentUserCollectionViewCellDelegate: AnyObject {
    func didTapSelectButton(tag: Int)
}

final class TournamentUserCollectionViewCell: UICollectionViewCell {
    weak var delegate: TournamentUserCollectionViewCellDelegate?
    
    var aUserViewLeadingConstraint: Constraint?
    var aUserViewWidthConstraint: Constraint?
    var aUserViewHeightConstraint: Constraint?
    
    var bUserViewTrailingConstraint: Constraint?
    var bUserViewWidthConstraint: Constraint?
    var bUserViewHeightConstraint: Constraint?
    
    let originHeight = ViewValues.height * 0.35
    
    // MARK: - Private properties
    private lazy var aUserView = TournamentUserView(frame: .zero,
                                                    tag: 0,
                                                    image: DesignSystemAsset.badge2.image,
                                                    delegate: self)
    
    private lazy var bUserView = TournamentUserView(frame: .zero,
                                                    tag: 1,
                                                    image: DesignSystemAsset.badge6.image,
                                                    delegate: self)
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
        configLayout()
        prepareAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        prepareAnimation()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.backgroundColor = .black
        
        contentView.addSubview(aUserView)
        contentView.addSubview(bUserView)
    }
    
    private func configLayout() {
        aUserView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            self.aUserViewLeadingConstraint = make.leading.equalToSuperview().offset(ViewValues.defaultPadding).constraint
            self.aUserViewHeightConstraint = make.height.equalTo(originHeight).constraint
            self.aUserViewWidthConstraint = make.width.equalTo(originHeight * 0.86).constraint
        }
        
        bUserView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            self.bUserViewTrailingConstraint = make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding).constraint
            self.bUserViewHeightConstraint = make.height.equalTo(originHeight).constraint
            self.bUserViewWidthConstraint = make.width.equalTo(originHeight * 0.86).constraint
        }
    }
    
    // MARK: - animation
    func prepareAnimation() {
        aUserView.isHidden = false
        bUserView.isHidden = false
        
        aUserViewHeightConstraint?.update(offset: originHeight)
        aUserViewWidthConstraint?.update(offset: originHeight * 0.86)
        aUserViewLeadingConstraint?.update(offset: ViewValues.width)
        
        bUserViewHeightConstraint?.update(offset: originHeight)
        bUserViewWidthConstraint?.update(offset: originHeight * 0.86)
        bUserViewTrailingConstraint?.update(offset: -ViewValues.width)
        
        self.aUserView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 9)
        self.bUserView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 9)
        
        self.layoutIfNeeded()
    }
    
    func startAnimation() {
        UIView.animate(
            withDuration: 0.7,
            delay: 0,
            usingSpringWithDamping: 0.7,
            initialSpringVelocity: 0
        ) {
            self.aUserViewLeadingConstraint?.update(offset: ViewValues.defaultPadding)
            self.bUserViewTrailingConstraint?.update(offset: -ViewValues.defaultPadding)
            
            self.aUserView.transform = CGAffineTransform.identity
            self.bUserView.transform = CGAffineTransform.identity
            self.layoutIfNeeded()
        }
    }
    
    func selectAnimation(
        tag: Int,
        completion: @escaping () -> Void
    ) {
        UIView.animate(
            withDuration: 1,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0
        ) {
            let changeWidth = ViewValues.width - 32
            
            switch tag {
            case 0:
                self.aUserViewHeightConstraint?.update(offset: changeWidth * 1.16)
                self.aUserViewWidthConstraint?.update(offset: changeWidth)
                
                self.bUserViewTrailingConstraint?.update(offset: -ViewValues.width * 1.2)
            case 1:
                self.bUserViewHeightConstraint?.update(offset: changeWidth * 1.16)
                self.bUserViewWidthConstraint?.update(offset: changeWidth)
                
                self.aUserViewLeadingConstraint?.update(offset: ViewValues.width * 1.2)
            default:
                break
            }
            self.layoutIfNeeded()
        }
        
        UIView.animate(
            withDuration: 1,
            delay: 1,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0
        ) {
            switch tag {
            case 0:
                self.aUserView.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 9)
                self.aUserViewLeadingConstraint?.update(offset: ViewValues.width * 1.2)
            case 1:
                self.bUserView.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 9)
                self.bUserViewTrailingConstraint?.update(offset: -ViewValues.width * 1.2)
            default:
                break
            }
            self.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}

// MARK: - Extensions here
extension TournamentUserCollectionViewCell: Reusable { }

// MARK: - Extensions here
extension TournamentUserCollectionViewCell: TournamentUserCollectionViewCellDelegate {
    func didTapSelectButton(tag: Int) {
        delegate?.didTapSelectButton(tag: tag)
    }
}
