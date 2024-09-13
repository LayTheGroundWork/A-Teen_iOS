//
//  MyBadgeViewController.swift
//  ProfileFeature
//
//  Created by 노주영 on 9/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol MyBadgeViewControllerCoordinator: AnyObject {
    func didTabBackButton()
    func configTabbarState(view: ProfileFeatureViewNames)
    func didSelectCell(badge: Badge)
}

final class MyBadgeViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel: MyBadgeViewModel
    private weak var coordinator: MyBadgeViewControllerCoordinator?
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: DesignSystemAsset.leftArrowIcon.image,
            style: .plain,
            target: self,
            action: #selector(didSelectBackButton))

        button.tintColor = UIColor.black
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.myBadgeTitle
        label.textColor = UIColor.black
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 46, left: 16, bottom: 16, right: 16)
        layout.minimumLineSpacing = 46
        layout.minimumInteritemSpacing = 24
        layout.itemSize = CGSize(width: ViewValues.myBadgeCollectionViewCellwidth, height: ViewValues.myBadgeCollectionViewCellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MyBadgeCollectionViewCell.self, forCellWithReuseIdentifier: MyBadgeCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.configTabbarState(view: .another)
    }
    
    init(
        viewModel: MyBadgeViewModel,
        coordinator: MyBadgeViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleLabel

        view.addSubview(collectionView)
    }
    
    private func configLayout() {
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }

    // MARK: - Actions
    @objc private func didSelectBackButton(_ sender: UIButton) {
        coordinator?.didTabBackButton()
    }
}

// MARK: - UICollectionViewDataSource
extension MyBadgeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.badgeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyBadgeCollectionViewCell.reuseIdentifier, for: indexPath) as? MyBadgeCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.setProperties(badge: viewModel.badgeList[indexPath.item].type)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension MyBadgeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinator?.didSelectCell(badge: viewModel.badgeList[indexPath.item])
    }
}
