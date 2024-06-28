//
//  TournamentRoundCollectionViewCell.swift
//  RankingFeature
//
//  Created by phang on 6/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import UIKit

protocol TournamentRoundCollectionViewCellDelegate: AnyObject {
    func nextRound()
}

final class TournamentRoundCollectionViewCell: UICollectionViewCell {
    weak var delegate: TournamentViewControllerCoordinator?
    weak var roundDelegate: TournamentRoundCollectionViewCellDelegate?
    
    // MARK: - Private properties
    private var round: TournamentRound?
    private var currentMatch: Int = 1
    
    private lazy var roundLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = .customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = DesignSystemAsset.gray03.color
        view.progressTintColor = DesignSystemAsset.mainColor.color
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: ViewValues.width,
                                 height: (ViewValues.height * 0.35 * 2) + 10)
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.black
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.register(TournamentUserCollectionViewCell.self,
                                forCellWithReuseIdentifier: TournamentUserCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
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
        contentView.backgroundColor = UIColor.black
        
        contentView.addSubview(roundLabel)
        contentView.addSubview(progressView)
        contentView.addSubview(collectionView)
    }
    
    private func configLayout() {
        roundLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide.snp.top).offset(6)
            make.leading.trailing.equalToSuperview()
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(roundLabel.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    public func setProperties(round: TournamentRound) {
        self.round = round
        
        roundLabel.text = round.rawValue
        progressView.progress = round.progress
    }
    
    // MARK: - Actions
    private func scrollToPage(at index: Int, animated: Bool = true) {
        let indexPath = IndexPath(item: 0, section: index - 1)
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: animated)
    }
}

// MARK: - Extensions here
extension TournamentRoundCollectionViewCell: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        1
    }
    
    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        round?.matches ?? 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TournamentUserCollectionViewCell.reuseIdentifier,
            for: indexPath) as? TournamentUserCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        return cell
    }
}

extension TournamentRoundCollectionViewCell: UICollectionViewDelegate { }

extension TournamentRoundCollectionViewCell: TournamentUserCollectionViewCellDelegate {
    func didTapPlusButton() {
        // TODO: - 프로필 이동
        print("프로필로 이동")
    }
    
    func didTapSelectButton() {
        if currentMatch == round?.matches {
            currentMatch = 1
            scrollToPage(at: currentMatch, animated: false)
            roundDelegate?.nextRound()
        } else {
            currentMatch += 1
            scrollToPage(at: currentMatch)
//            progressView.setProgress(progressView.progress + (round?.progress ?? 0),
//                                     animated: true)
            UIView.animate(withDuration: 0.25) { [self] in
                progressView.setProgress(
                    progressView.progress + (self.round?.progress ?? 0),
                    animated: true)
            }
            collectionView.reloadData()
        }
    }
}

extension TournamentRoundCollectionViewCell: Reusable { }
