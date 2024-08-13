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
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(
            width: ViewValues.selectCatogoryCellWidth,
            height: ViewValues.selectCategoryCellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
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
        
        if viewModel?.category == viewModel?.categoryExplain[indexPath.row] {
            cell.selectCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.categoryExplain.count ?? 6
    }
}

// MARK: - UICollectionViewDelegate
extension SelectCategoryCollectionViewCell: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.changeCategory(index: indexPath.item) {
            guard let cell = collectionView.cellForItem(at: indexPath) as? CategoryButtonCollectionViewCell else { return }
            print("셀 색상 변경")
            cell.selectCell()
            
            (0..<collectionView.numberOfItems(inSection: indexPath.section))
                .filter { $0 != indexPath.item }
                .compactMap { collectionView.cellForItem(at: IndexPath(item: $0, section: indexPath.section)) as? CategoryButtonCollectionViewCell }
                .forEach { $0.clearCell() }
            
            delegate?.updateNextButtonState(true)
        }
    }
}

extension SelectCategoryCollectionViewCell: Reusable { }
