//
//  LinksDialogViewController.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol LinksDialogViewControllerCoordinator: AnyObject {
    func didFinish()
}

protocol LinksDialogViewControllerDelegate {
    func didTabAddLinkButton()
    func updateCloseButton(isCheck: Bool)
    func updateDialogHeight()
}

final class LinksDialogViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel: ProfileViewModel
    private weak var coordinator: LinksDialogViewControllerCoordinator?
    
    private var currentCollectionViewIndex: Int = 0
    
    private var dialogViewHeightAnchor: Constraint?
    private var collectionViewHeigthAnchor: Constraint?
    
    private lazy var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 링크"
        label.textColor = UIColor.black
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .bold)
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        // 수정사항 있으면 체크 image 로 업데이트
        button.setImage(DesignSystemAsset.xMarkIcon.image, for: .normal)
        button.addTarget(self, action: #selector(clickCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.leftArrowIcon.image, for: .normal)
        button.isHidden = true
        button.isEnabled = false
        button.addTarget(self, action: #selector(clickBackButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var linksCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: ViewValues.width - 32,
                                 height: 100) // height 임시 값
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(LinksCollectionViewCell.self, forCellWithReuseIdentifier: LinksCollectionViewCell.reuseIdentifier)
        collectionView.register(AddLinkCollectionViewCell.self, forCellWithReuseIdentifier: AddLinkCollectionViewCell.reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()

    init(
        viewModel: ProfileViewModel,
        coordinator: LinksDialogViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(dialogView)

        dialogView.addSubview(backButton)
        dialogView.addSubview(titleLabel)
        dialogView.addSubview(closeButton)
        dialogView.addSubview(linksCollectionView)
    }
    
    private func configLayout() {
        dialogView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.centerY.equalToSuperview()
            self.dialogViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(24)
        }
        
        closeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(24)
        }
        
        linksCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
            self.collectionViewHeigthAnchor = make.height.equalTo(0).constraint
        }
        
        changeViewHeight()
    }
    
    private func changeViewHeight() {
        view.layoutIfNeeded()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
            
        switch currentCollectionViewIndex {
        case 0:
            layout.itemSize = CGSize(
                width: Int(ViewValues.width) - 32,
                height: viewModel.userLinks.count * 34 + 69)
            
            linksCollectionView.collectionViewLayout = layout
            
            collectionViewHeigthAnchor?.update(
                offset: viewModel.userLinks.count * 34 + 69)
            
            self.linksCollectionView.reloadData()
            
            view.layoutIfNeeded()
            
            self.dialogViewHeightAnchor?.update(
                offset: self.titleLabel.frame.height + self.linksCollectionView.frame.height + 40)
            //
            updateCloseButton(isXmark: true, isCheck: false)
            //
            updateBackButton(isHidden: true)
        case 1:
            layout.itemSize = CGSize(
                width: Int(ViewValues.width) - 32,
                height: 88 + 16 + 40)
            
            linksCollectionView.collectionViewLayout = layout
            
            collectionViewHeigthAnchor?.update(
                offset: 88 + 16 + 40)
            
            self.linksCollectionView.reloadData()
            
            view.layoutIfNeeded()
            
            self.dialogViewHeightAnchor?.update(
                offset: self.titleLabel.frame.height + self.linksCollectionView.frame.height + 40)
            //
            updateCloseButton(isXmark: false, isCheck: false)
            //
            updateBackButton(isHidden: false)
        default:
            break
        }
    }
    
    private func updateCloseButton(isXmark: Bool, isCheck: Bool) {
        if isXmark {
            // x 버튼
            closeButton.setImage(DesignSystemAsset.xMarkIcon.image, for: .normal)
        } else if isCheck {
            // 눌리는 체크버튼
            closeButton.setImage(DesignSystemAsset.checkIcon.image, for: .normal)
        } else {
            // 안눌리는 체크버튼
            closeButton.setImage(DesignSystemAsset.grayCheckIcon.image, for: .normal)
        }
    }
    
    private func updateBackButton(isHidden: Bool) {
        backButton.isHidden = isHidden
        backButton.isEnabled = !isHidden
    }
    
    // MARK: - Actions
    @objc private func clickCloseButton(_ sender: UIButton) {
        switch currentCollectionViewIndex {
        case 0:
            coordinator?.didFinish()
        case 1:
            if let addLinkCell = linksCollectionView.visibleCells.first as? AddLinkCollectionViewCell,
               let linkText = addLinkCell.linkTextField.text,
               let linkTitle = addLinkCell.linkTitleTextField.text {
                viewModel.userLinks.append(
                    (link: linkText, title: linkTitle == "" ? nil : linkTitle)
                )
            }

            clickBackButton(UIButton())
        default:
             break
        }
    }
    
    @objc private func clickBackButton(_ sender: UIButton) {
        currentCollectionViewIndex -= 1
        
        linksCollectionView.visibleCells.forEach { cell in
            if let addLinkCell = cell as? AddLinkCollectionViewCell {
                addLinkCell.clearAllTextFields()
            }
        }
                
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            changeViewHeight()
            view.layoutIfNeeded()
        } completion: { [weak self] _ in
            guard let self = self else { return }
            
            self.linksCollectionView.visibleCells.forEach { cell in
                if let linksCell = cell as? LinksCollectionViewCell {
                    linksCell.linkTableView.reloadData()
                }
            }
        }
        
        linksCollectionView.reloadData()

        scrollToPage(at: currentCollectionViewIndex)
    }
    
    private func scrollToPage(at index: Int, animated: Bool = true) {
        let indexPath = IndexPath(item: 0, section: index)
        linksCollectionView.scrollToItem(at: indexPath,
                                    at: .centeredHorizontally,
                                    animated: animated)
    }
}

// MARK: - UICollectionViewDataSource
extension LinksDialogViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        1
    }
    
    public func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        2
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: LinksCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? LinksCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.setProperties(delegate: self, viewModel: self.viewModel)
            return cell
        case 1:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: AddLinkCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? AddLinkCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.setProperties(delegate: self, viewModel: self.viewModel)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

// MARK: - Delegate
extension LinksDialogViewController: UICollectionViewDelegate { }

extension LinksDialogViewController: LinksDialogViewControllerDelegate {
    func didTabAddLinkButton() {
        currentCollectionViewIndex += 1

        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            changeViewHeight()
            view.layoutIfNeeded()
        }

        scrollToPage(at: currentCollectionViewIndex)
    }
    
    func updateCloseButton(isCheck: Bool) {
        updateCloseButton(isXmark: false, isCheck: isCheck)
    }
    
    func updateDialogHeight() {
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            changeViewHeight()
            view.layoutIfNeeded()
        }
    }
}
