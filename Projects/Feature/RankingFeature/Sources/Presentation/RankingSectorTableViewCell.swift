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

class RankingSectorTableViewCell: UITableViewCell {
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
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
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

extension RankingSectorTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
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

       return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
}

extension RankingSectorTableViewCell: Reusable { }
