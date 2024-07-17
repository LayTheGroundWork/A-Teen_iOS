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
    private var viewModel: IntroduceViewModel
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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "자기소개 정보 수정"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(
            width: ViewValues.width,
            height: 430)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.register(IntroduceMbtiCollectionViewCell.self,
                                forCellWithReuseIdentifier: IntroduceMbtiCollectionViewCell.reuseIdentifier)
        collectionView.register(IntroduceWritingCollectionViewCell.self,
                                forCellWithReuseIdentifier: IntroduceWritingCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var nextAndSaveButton: UIButton = {
        let button = UIButton()
        button.setTitle("건너뛰기", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.titleLabel?.font = .customFont(forTextStyle: .subheadline, weight: .regular)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(clickNextAndSaveButton(_:)), for: .touchUpInside)
        return button
    }()
    
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
        viewModel: IntroduceViewModel,
        coordinator: IntroduceViewControllerCoordinator
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
        view.backgroundColor = UIColor.systemBackground
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.leftBarButtonItem = backButton
        
        view.addSubview(titleLabel)
        view.addSubview(nextAndSaveButton)
        view.addSubview(collectionView)
    }
    
    private func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(13)
        }
        
        nextAndSaveButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-48)
            make.width.equalTo(116)
            make.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.height.equalTo(430)
        }
    }
    
    // MARK: - Actions
    @objc private func clickBackButton(_ sender: UIBarButtonItem) {
        if nextAndSaveButton.titleLabel?.text == "건너뛰기" {
            coordinator?.didTabBackButton()
        } else {
            nextAndSaveButton.setTitle("건너뛰기", for: .normal)
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    @objc private func clickNextAndSaveButton(_ sender: UIBarButtonItem) {
        if nextAndSaveButton.titleLabel?.text == "건너뛰기" {
            nextAndSaveButton.setTitle("완료", for: .normal)
            collectionView.scrollToItem(at: IndexPath(item: 0, section: 1), at: .centeredHorizontally, animated: true)
        } else {
            //TODO: 서버 저장 로직
            coordinator?.didTabBackButton()     //일단 첨으로 가게 해놨음
        }
    }
}

// MARK: - UICollectionViewDataSource
extension IntroduceViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IntroduceMbtiCollectionViewCell.reuseIdentifier,
                for: indexPath) as? IntroduceMbtiCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.setProperties(viewModel: viewModel)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: IntroduceWritingCollectionViewCell.reuseIdentifier,
                for: indexPath) as? IntroduceWritingCollectionViewCell
            else {
                return UICollectionViewCell()
            }
//            cell.setProperties(round: currentRound)
//            cell.delegate = coordinator
//            cell.roundDelegate = self
            return cell
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
}
