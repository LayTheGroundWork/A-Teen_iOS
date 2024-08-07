//
//  SelectCategoryCollectionViewCell.swift
//  LoginFeature
//
//  Created by 최동호 on 8/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

protocol SelectCategoryCollectionViewCellDelegate: AnyObject {
    func updateNextButtonState(_ state: Bool)
}

final class SelectCategoryCollectionViewCell: UICollectionViewCell {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var delegate: SelectCategoryCollectionViewCellDelegate?
    private var viewModel: SignUpViewModel?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.selectCategoryTitle
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.categoryMaximumText
        label.textAlignment = .left
        label.textColor = DesignSystemAsset.gray01.color
        label.numberOfLines = 0
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(
            width: (ViewValues.width / 2) - 24,
            height: 90)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(
            CategoryButtonCollectionViewCell.self,
            forCellWithReuseIdentifier: CategoryButtonCollectionViewCell.reuseIdentifier
        )

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
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(categoryCollectionView)
    }
    
    private func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
        
        categoryCollectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(31)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    func setProperties(
        delegate: SelectCategoryCollectionViewCellDelegate,
        viewModel: SignUpViewModel
    ) {
        self.delegate = delegate
        self.viewModel = viewModel
    }
    
}

// MARK: - UICollectionViewDataSource
extension SelectCategoryCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CategoryButtonCollectionViewCell.reuseIdentifier,
            for: indexPath) as? CategoryButtonCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.setProperties(
            text: viewModel?.categoryExplain[indexPath.row].rawValue ?? ""
        )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.categoryExplain.count ?? 6
    }
}

// MARK: - UICollectionViewDelegate
extension SelectCategoryCollectionViewCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.changeCategory(index: indexPath.item) { clearCellIndex in
            guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryButtonCollectionViewCell else { return }
            guard let anotherCell = collectionView.cellForItem(
                at: IndexPath(
                    item: clearCellIndex,
                    section: 0)) as? CategoryButtonCollectionViewCell else { return }
            anotherCell.clearCell()
            cell.selectCell()
            delegate?.updateNextButtonState(true)
        }
    }
}

extension SelectCategoryCollectionViewCell: Reusable { }
