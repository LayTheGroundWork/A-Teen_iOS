//
//  EditMyPhotoViewController.swift
//  ProfileFeature
//
//  Created by 최동호 on 8/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol EditMyPhotoViewControllerCoordinator: AnyObject {
    func didTabBackButton()
    func configTabbarState(view: ProfileFeatureViewNames)
}

final class EditMyPhotoViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var coordinator: EditMyPhotoViewControllerCoordinator?
    
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
        label.text = AppLocalized.editMyPhotoTitle
        label.textColor = UIColor.black
        
        return label
    }()
    
    private lazy var photoGuideLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.photoGuideTextLabel
        label.textColor = DesignSystemAsset.gray01.color
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.itemSize = CGSize(width: ViewValues.editMyPhotoCollectionViewCellWidth, height: ViewValues.editMyPhotoCollectionViewCellHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var completeButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle(AppLocalized.completeEdit, for: .normal)
        button.setTitle(AppLocalized.completeEdit, for: .disabled)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(DesignSystemAsset.gray02.color, for: .disabled)
        button.backgroundColor = DesignSystemAsset.gray03.color
        button.layer.cornerRadius = ViewValues.defaultRadius
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        setButtonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.configTabbarState(view: .editPhoto)
    }
    
    init(coordinator: EditMyPhotoViewControllerCoordinator) {
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
        
        view.addSubview(photoGuideLabel)
        view.addSubview(completeButton)
        view.addSubview(collectionView)
    }
    
    private func configLayout() {
        photoGuideLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        completeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalTo(ViewValues.defaultButtonWidth)
            make.height.equalTo(ViewValues.defaultButtonHeight)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(photoGuideLabel.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(completeButton.snp.top).offset(-ViewValues.defaultPadding)
        }
    }
    
    private func setButtonActions() {
        
    }
    
    // MARK: - Actions
    @objc private func didSelectBackButton(_ sender: UIButton) {
        coordinator?.didTabBackButton()
    }
    
}

// MARK: - UICollectionViewDataSource
extension EditMyPhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier, for: indexPath) as? PhotoCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        let itemIndex = indexPath.item
        let maxPhotoCount = 10
        
        cell.setCellCustom(item: itemIndex)

        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegate
extension EditMyPhotoViewController: UICollectionViewDelegate {
    
}
