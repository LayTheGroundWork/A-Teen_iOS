//
//  AlbumViewController.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import FeatureDependency
import Photos
import UIKit

final class AlbumViewController: UIViewController {
    // MARK: - Private properties
    private let viewModel = AlbumViewModel()
    private weak var coordinator: AlbumViewControllerCoordinator?
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = UIColor.white
        button.addTarget(self, action: #selector(didSelectCancelButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var explanationLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.accessMediaText
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.customFont(forTextStyle: .caption2, weight: .regular)
        return label
    }()
    
    private lazy var photoButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppLocalized.photo, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = DesignSystemAsset.mainColor.color
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        button.isSelected = true
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didSelectChangeButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var videoButton: UIButton = {
        let button = UIButton()
        button.setTitle(AppLocalized.video, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .gray
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        button.isSelected = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(didSelectChangeButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 16
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.itemSize = CGSize(width: ViewValues.cellWidth, height: ViewValues.cellWidth)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .black
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AlbumCollectionViewCell.self, forCellWithReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    // MARK: - Life Cycle
    
    public init(coordinator: AlbumViewControllerCoordinator) {
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
        
        loadAlbums(mediaType: .image) { [weak self] in
            self?.loadImages()
        }
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.navigationController?.navigationBar.isHidden = true
        
        view.backgroundColor = .black
        
        view.addSubview(cancelButton)
        view.addSubview(explanationLabel)
        view.addSubview(photoButton)
        view.addSubview(videoButton)
        view.addSubview(collectionView)
    }
    
    private func configLayout() {
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        
        explanationLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(cancelButton.snp.bottom).offset(22)
            make.height.equalTo(15)
        }
        
        photoButton.snp.makeConstraints { make in
            make.trailing.equalTo(self.view.snp.centerX).offset(-8)
            make.top.equalTo(explanationLabel.snp.bottom).offset(20)
            make.width.equalTo(98)
            make.height.equalTo(39)
        }
        
        videoButton.snp.makeConstraints { make in
            make.leading.equalTo(self.view.snp.centerX).offset(8)
            make.top.equalTo(explanationLabel.snp.bottom).offset(20)
            make.width.equalTo(98)
            make.height.equalTo(39)
        }
        
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(photoButton.snp.bottom).offset(27)
        }
    }
    
    // MARK: - Actions
    @objc func didSelectChangeButton(_ sender: UIButton) {
        switch sender {
        case photoButton:
            photoButton.isSelected = true
            photoButton.backgroundColor = DesignSystemAsset.mainColor.color
            
            videoButton.isSelected = false
            videoButton.backgroundColor = UIColor.gray
            
            loadAlbums(mediaType: .image) { [weak self] in
                self?.loadImages()
            }
            
        case videoButton:
            photoButton.isSelected = false
            photoButton.backgroundColor = UIColor.gray
            
            videoButton.isSelected = true
            videoButton.backgroundColor = DesignSystemAsset.mainColor.color
            loadAlbums(mediaType: .video) { [weak self] in
                self?.loadImages()
            }
            
        default:
            break
        }
    }
    
    private func loadAlbums(
        mediaType: MediaType,
        completion: @escaping () -> Void
    ) {
        viewModel.loadAlbums(mediaType: mediaType) {
            completion()
        }
    }
    
    private func loadImages() {
        viewModel.loadAsset {
            self.collectionView.reloadData()
        }
    }
    
    @objc func didSelectCancelButton(_ sender: UIButton) {
        coordinator?.didFinishFlow()
    }
}

extension AlbumViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.photos.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier, for: indexPath) as? AlbumCollectionViewCell
        else { return UICollectionViewCell() }
        
        viewModel.fetchImage(
            item: indexPath.item,
            size: CGSize(width: ViewValues.cellWidth, height: ViewValues.cellWidth),
            contentMode: .aspectFill,
            version: .current
        ) { [weak cell] asset, image in
            cell?.setImage(
                info: .init(
                    phAsset: asset,
                    image: image,
                    avAsset: nil,
                    avAudio: nil))
        }
        
        return cell
    }
}

extension AlbumViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.showSpinner(color: UIColor.white)
        
        if self.videoButton.isSelected {
            viewModel.fetchVideo(
                phAsset: viewModel.photos[indexPath.item].phAsset,
                size: CGSize(width: ViewValues.width, height: ViewValues.height / 2)
            ) { asset, _ in
                DispatchQueue.main.async {
                    guard let asset = asset else { return }
                    self.hideSpinner()
                    self.coordinator?.didSelectVideo(asset: asset)
                }
            }
        } else {
            viewModel.fetchImage(
                item: indexPath.item,
                size: CGSize(width: ViewValues.width, height: ViewValues.height),
                contentMode: .default,
                version: .current
            ) { _, image in
                DispatchQueue.main.async {
                    self.hideSpinner()
                    self.coordinator?.didSelectPhoto(selectImage: image)
                }
            }
        }
    }
}

extension AlbumViewController: SpinnerDisplayable { }
