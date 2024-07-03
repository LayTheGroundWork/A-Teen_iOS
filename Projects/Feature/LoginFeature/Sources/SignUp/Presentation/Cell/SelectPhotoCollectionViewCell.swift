//
//  SelectPhotoCollectionViewCell.swift
//  LoginFeature
//
//  Created by 노주영 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

final class SelectPhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    private var coordinator: SignUpViewControllerCoordinator?
    private var viewModel: SignUpViewModel?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.insertMediaText
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.maxInsertMediaCountText
        label.textAlignment = .left
        label.textColor = DesignSystemAsset.gray01.color
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: ViewValues.selectPhotoCellWidth, height: ViewValues.cellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
       
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
        contentView.addSubview(collectionView)
    }
    
    private func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(titleLabel.snp.bottom).offset(6)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(subTitleLabel.snp.bottom).offset(31)
        }
    }

    // MARK: - Actions
    func setProperties(coordinator: SignUpViewControllerCoordinator?, viewModel: SignUpViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
    }
}

// MARK: - UICollectionViewDataSource
extension SelectPhotoCollectionViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = viewModel?.selectPhotoAsset.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell,
            let viewModel = viewModel
        else { return UICollectionViewCell() }
        cell.setProperties(viewModel: viewModel)
        cell.setCellCustom(item: indexPath.item)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SelectPhotoCollectionViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel?.requestAuthorization { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                coordinator?.didSelectCell(item: indexPath.item)
            case .failure:
                return
            }
        }
    }
}

extension SelectPhotoCollectionViewCell: Reusable { }