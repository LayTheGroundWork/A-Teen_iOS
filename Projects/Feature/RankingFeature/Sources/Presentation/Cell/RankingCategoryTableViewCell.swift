//
//  RankingCategoryTableViewCell.swift
//  week4_ciu
//
//  Created by 강치우 on 6/13/24.
//

import SnapKit

import Common
import Domain
import DesignSystem
import UIKit

protocol RankingCategoryTableViewCellDelegate: AnyObject {
    func didTapVoteButton(category: String)
    func didTapRankingCollectionViewCell(
        category: String,
        round: Int,
        tournamentNo: Int)
}

public final class RankingCategoryTableViewCell: UITableViewCell {
    weak var delegate: RankingCategoryTableViewCellDelegate?
    var tournamentListInCategory: TournamentSearchData?
    
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
        collectionView.register(RankingCategoryCollectionViewCell.self, forCellWithReuseIdentifier: RankingCategoryCollectionViewCell.reuseIdentifier)
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
    
    func setProperty(
        delegate: RankingCategoryTableViewCellDelegate,
        tournamentListInCategory: TournamentSearchData
    ) {
        self.delegate = delegate
        self.tournamentListInCategory = tournamentListInCategory
        
        self.tournamentListInCategory?.winner.sort { $0.round > $1.round }
    }
}

extension RankingCategoryTableViewCell: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankingCategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? RankingCategoryCollectionViewCell,
              let tournamentListInCategory = tournamentListInCategory
        else { return UICollectionViewCell() }
        
        cell.chooseCellUI(index: indexPath.item)
        cell.setProperty(
            delegate: self,
            category: tournamentListInCategory.category,
            winner: indexPath.item == 0 ? nil : tournamentListInCategory.winner[indexPath.item - 1])
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (tournamentListInCategory?.winner.count ?? 0) + 1
    }
}

extension RankingCategoryTableViewCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let tournamentListInCategory = tournamentListInCategory,
              indexPath.item != 0
        else { return }
        delegate?.didTapRankingCollectionViewCell(
            category: tournamentListInCategory.category,
            round: tournamentListInCategory.winner[indexPath.item - 1].round,
            tournamentNo: tournamentListInCategory.winner[indexPath.item - 1].tournamentNo)
    }
}

extension RankingCategoryTableViewCell: RankingCategoryCollectionViewCellDelegate {
    func didTapVoteButton(category: String) {
        delegate?.didTapVoteButton(category: category)
    }
}

extension RankingCategoryTableViewCell: Reusable { }
