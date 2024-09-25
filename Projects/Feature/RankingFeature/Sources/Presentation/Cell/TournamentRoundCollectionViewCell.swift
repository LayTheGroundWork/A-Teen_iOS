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
    private func scrollToPage(at index: Int) {
        let indexPath = IndexPath(item: 0, section: index - 1)
        collectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: false)
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

extension TournamentRoundCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? TournamentUserCollectionViewCell else { return }
        
        cell.startAnimation()
    }
}

extension TournamentRoundCollectionViewCell: TournamentUserCollectionViewCellDelegate {
    func didTapSelectButton(tag: Int) {
        guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: currentMatch - 1)) as? TournamentUserCollectionViewCell else {
            return
        }
        
        cell.selectAnimation(tag: tag) {
            if self.currentMatch == self.round?.matches {
                self.currentMatch = 1
                self.scrollToPage(at: self.currentMatch)
                self.roundDelegate?.nextRound()
            } else {
                self.currentMatch += 1
                self.scrollToPage(at: self.currentMatch)
                UIView.animate(withDuration: 0.25) { [weak self] in
                    guard let self = self else { return }
                    
                    progressView.setProgress(
                        progressView.progress + (self.round?.progress ?? 0),
                        animated: true)
                }
            }
        }
    }
}

extension TournamentRoundCollectionViewCell: Reusable { }
