//
//  SelectCategoryPhotoViewController.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol SelectCategoryPhotoViewControllerCoordinator: AnyObject {
    func didFinishFlow()
    func didSelect(image: UIImage)
}

final class SelectCategoryPhotoViewController: UIViewController {
    // MARK: - Public properties
    let selectImage: UIImage
    
    // MARK: - Private properties
    private let coordinator: SelectCategoryPhotoViewControllerCoordinator?
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = UIColor.white
        return button
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = selectImage
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setTitle("등록 완료", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = DesignSystemAsset.mainColor.color
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout, weight: .regular)
        button.layer.cornerRadius = 20
        return button
    }()
    
    // MARK: - Life Cycle
    init(
        selectImage: UIImage,
        coordinator: SelectCategoryPhotoViewControllerCoordinator
    ) {
        self.selectImage = selectImage
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        setButtonActions()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.black
        view.addSubview(cancelButton)
        view.addSubview(photoImageView)
        view.addSubview(checkButton)
    }
    
    private func configLayout() {
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalTo(ViewValues.width)
        }
        
        checkButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-70)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.equalTo(116)
            make.height.equalTo(50)
        }
    }
    
    private func setButtonActions() {
        cancelButton.addTarget(self, action: #selector(didSelectCancelButton(_:)), for: .touchUpInside)
        checkButton.addTarget(self, action: #selector(didSelectCheckButton(_:)), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc func didSelectCancelButton(_ sender: UIButton) {
        coordinator?.didFinishFlow()
    }
    
    @objc func didSelectCheckButton(_ sender: UIButton) {
        coordinator?.didSelect(image: selectImage)
        //self.navigationController?.popViewController(animated: true)
    }
}
