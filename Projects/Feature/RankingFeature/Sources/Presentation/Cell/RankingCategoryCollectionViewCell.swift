//
//  RankingCategoryCollectionViewCell.swift
//  RankingFeature
//
//  Created by 김명현 on 6/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import Domain
import UIKit

protocol RankingCategoryCollectionViewCellDelegate: AnyObject {
    func didTapVoteButton(category: String)
}

final class RankingCategoryCollectionViewCell: UICollectionViewCell {
    weak var delegate: RankingCategoryCollectionViewCellDelegate?
    var category: String?
    var winner: TournamentWinnerData?
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.badge3.image
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    private lazy var voteButton: UIButton = {
        let button = UIButton(type: .system)
        // TODO: - 투표를 이미 했다면, "결과 확인하기" 로 버튼 Text 변경되도록 수정 필요
        button.setTitle("투표 참여하기", for: .normal)
        button.titleLabel?.font = .customFont(forTextStyle: .title3, weight: .regular)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.tintColor = UIColor.white
        button.layer.cornerRadius = ViewValues.defaultRadius
        button.addTarget(self,
                         action: #selector(didTapVoteButton),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var winnerBackgroundView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        view.layer.cornerRadius = 15
        
        return view
    }()
    
    private lazy var crownImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.crownWhiteIcon.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var winnerLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = .customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUserInterface() {
        contentView.layer.cornerRadius = ViewValues.defaultRadius
        contentView.clipsToBounds = true
        
        contentView.addSubview(imageView)
        contentView.addSubview(voteButton)
        contentView.addSubview(winnerBackgroundView)
        
        winnerBackgroundView.addSubview(crownImageView)
        winnerBackgroundView.addSubview(winnerLabel)
    }
    
    private func configLayout() {
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        voteButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().offset(-22)
            make.height.equalTo(50)
        }
        
        winnerBackgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(
                (winnerLabel.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: winnerLabel.font!]).width + 53)
            make.height.equalTo(34)
        }
        
        crownImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(5)
            make.width.height.equalTo(24)
        }
        
        winnerLabel.snp.makeConstraints { make in
            make.leading.equalTo(crownImageView.snp.trailing)
            make.trailing.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(24)
        }
    }
    
    func setProperty(
        delegate: RankingCategoryCollectionViewCellDelegate,
        category: String,
        winner: TournamentWinnerData?
    ) {
        self.delegate = delegate
        self.category = category
        self.winner = winner
        
        winnerLabel.text = "\(winner?.round ?? 0)회차 우승자"
        
        configLayout()
    }
    
    // 투표하기 버튼, 우승자 라벨 가시성 함수
    func chooseCellUI(index: Int) {
        switch index {
        case 0:
            voteButton.isHidden = false
            
            winnerBackgroundView.isHidden = true
            crownImageView.isHidden = true
            winnerLabel.isHidden = true
        default:
            voteButton.isHidden = true
            
            winnerBackgroundView.isHidden = false
            crownImageView.isHidden = false
            winnerLabel.isHidden = false
        }
    }
    
    @objc private func didTapVoteButton() {
        // TODO: - 투표를 이미 했다면, 현재 진행중인 투표 현황을 볼 수 있도록 RankingResult 로 이동
        // 투표 안했을 경우, 아래 로직 수행
        guard let category = category else { return }
        delegate?.didTapVoteButton(category: category)
    }
}

extension RankingCategoryCollectionViewCell: Reusable { }
