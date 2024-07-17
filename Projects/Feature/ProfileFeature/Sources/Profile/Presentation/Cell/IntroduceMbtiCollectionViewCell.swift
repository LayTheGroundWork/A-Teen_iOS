//
//  IntroduceMbtiCollectionViewCell.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

final class IntroduceMbtiCollectionViewCell: UICollectionViewCell {
    private var viewModel: IntroduceViewModel?
    
    // MARK: - Private properties
    private lazy var mbtiLabel: UILabel = {
        let label = UILabel()
        label.text = "당신의 mbti가 무엇인가요?"
        label.textColor = DesignSystemAsset.gray02.color
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    private lazy var mbtiCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(
            width: (ViewValues.width - 48) / 2,
            height: 79)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IntroduceMbtiButtonCollectionViewCell.self, forCellWithReuseIdentifier: IntroduceMbtiButtonCollectionViewCell.reuseIdentifier)
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
        contentView.addSubview(mbtiLabel)
        contentView.addSubview(mbtiCollectionView)
    }
    
    private func configLayout() {
        mbtiLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalToSuperview()
        }
        
        mbtiCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(mbtiLabel.snp.bottom).offset(42)
            make.bottom.equalToSuperview()
        }
    }
}

// MARK: - Properties
extension IntroduceMbtiCollectionViewCell {
    public func setProperties(viewModel: IntroduceViewModel) {
        self.viewModel = viewModel
        
        viewModel.changeMbti = viewModel.myMbti
    }
}

// MARK: - UICollectionViewDataSource
extension IntroduceMbtiCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: IntroduceMbtiButtonCollectionViewCell.reuseIdentifier,
            for: indexPath) as? IntroduceMbtiButtonCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.setProperties(
            alphabet: viewModel?.mbtiExplain[indexPath.row].0 ?? "",
            text: viewModel?.mbtiExplain[indexPath.row].1 ?? "")
        
        if viewModel?.myMbti.contains(viewModel?.mbtiExplain[indexPath.row].0 ?? "") ?? false {
            cell.selectCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.mbtiExplain.count ?? 8
    }
}

// MARK: - UICollectionViewDelegate
extension IntroduceMbtiCollectionViewCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.changeMyMbti(index: indexPath.item) { clearCellIndex in
            guard let cell = collectionView.cellForItem(at: indexPath) as? IntroduceMbtiButtonCollectionViewCell else { return }
            guard let anotherCell = collectionView.cellForItem(
                at: IndexPath(
                    item: clearCellIndex,
                    section: 0)) as? IntroduceMbtiButtonCollectionViewCell else { return }
            
            cell.selectCell()
            anotherCell.clearCell()
        }
    }
}

extension IntroduceMbtiCollectionViewCell: Reusable { }

