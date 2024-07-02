//
//  RankingSectorTableViewCell.swift
//  week4_ciu
//
//  Created by 강치우 on 6/13/24.
//

import UIKit
import SnapKit
import Common
import DesignSystem

public final class RankingSectorTableViewCell: UITableViewCell {
    var sector: String?
    weak var delegate: RankingViewControllerCoordinator?

    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 208, height: 242)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SectorCollectionViewCell.self, forCellWithReuseIdentifier: SectorCollectionViewCell.reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUserInterface() {
        contentView.addSubview(collectionView)
    }
    
    private func configLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}

extension RankingSectorTableViewCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SectorCollectionViewCell.reuseIdentifier, for: indexPath) as? SectorCollectionViewCell else { return UICollectionViewCell() }
        
        if indexPath.item == 0 {
            cell.winnerBackgroundView.isHidden = true
            cell.winnerLabel.isHidden = true
            cell.voteButton.isHidden = false
        } else {
            cell.winnerBackgroundView.isHidden = false
            cell.winnerLabel.isHidden = false
            cell.voteButton.isHidden = true
        }
        cell.delegate = delegate
        cell.sector = sector
       return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}

extension RankingSectorTableViewCell: UICollectionViewDelegate {
    public func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        // 첫번째 셀은 투표하기 버튼 외에는 화면 이동 X
        guard indexPath.item != 0 else { return }
        // 나머지 셀 : RankingResult 이동
        delegate?.didTapRankingCollectionViewCell(sector: sector ?? "")
    }
}

extension RankingSectorTableViewCell: Reusable { }
