//
//  IntroduceViewController.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Combine
import Common
import DesignSystem
import UIKit

public protocol IntroduceViewControllerCoordinator: AnyObject {
    func didTabBackButton()
    func configTabbarState(view: ProfileFeatureViewNames)
}

public final class IntroduceViewController: UIViewController {
    // MARK: - Private properties
    private weak var coordinator: IntroduceViewControllerCoordinator?
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: DesignSystemAsset.leftArrowIcon.image,
            style: .done,
            target: self,
            action: #selector(clickBackButton(_:)))
        button.tintColor = UIColor.black
        return button
    }()

//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .horizontal
//        layout.itemSize = CGSize(width: ViewValues.width,
//                                 height: ViewValues.height - 80)
//        let collectionView = UICollectionView(frame: .zero,
//                                              collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor.black
//        collectionView.contentInsetAdjustmentBehavior = .never
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.isScrollEnabled = false
//        collectionView.isPagingEnabled = true
//        collectionView.register(TournamentRoundCollectionViewCell.self,
//                                forCellWithReuseIdentifier: TournamentRoundCollectionViewCell.reuseIdentifier)
//        collectionView.register(TournamentEndCollectionViewCell.self,
//                                forCellWithReuseIdentifier: TournamentEndCollectionViewCell.reuseIdentifier)
//        collectionView.delegate = self
//        collectionView.dataSource = self
//        return collectionView
//    }()
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.configTabbarState(view: .introduce)
    }
    
    public init(
        coordinator: IntroduceViewControllerCoordinator
    ) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.systemBackground
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func configLayout() {
        
    }
    
    // MARK: - Actions
    @objc private func clickBackButton(_ sender: UIBarButtonItem) {
        coordinator?.didTabBackButton()
    }
}
