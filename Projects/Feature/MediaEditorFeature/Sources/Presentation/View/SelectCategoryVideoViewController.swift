//
//  SelectCategoryVideoViewController.swift
//  MediaEditorFeature
//
//  Created by 최동호 on 7/2/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import AVKit
import Common
import DesignSystem
import UIKit

public protocol SelectCategoryVideoViewControllerCoordinator: AnyObject {
    func didFinishFlow()
    func didSelect(avAsset: AVAsset)
}

final class SelectCategoryVideoViewController: UIViewController {
    // MARK: - Private properties
    private let asset: AVAsset?
    private let coordinator: SelectCategoryVideoViewControllerCoordinator?
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = UIColor.white
        return button
    }()
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var videoBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black
        view.layer.addSublayer(playerLayer)
        return view
    }()
    
    private lazy var playerLayer: AVPlayerLayer = {
        let playerLayer = AVPlayerLayer()
        let size = CGSize(width: ViewValues.width, height: ViewValues.height / 2)
        playerLayer.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        playerLayer.videoGravity = .resizeAspect
        return playerLayer
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
        asset: AVAsset,
        coordinator: SelectCategoryVideoViewControllerCoordinator
    ) {
        self.asset = asset
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        playerLayer.player = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        setButtonActions()
        updatePlayerAsset()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .black
        view.addSubview(cancelButton)
        view.addSubview(videoBackgroundView)
        view.addSubview(checkButton)
    }
    
    private func configLayout() {
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }
        
        videoBackgroundView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(ViewValues.width)
            make.height.equalTo(ViewValues.width * 1.16)
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
    
    private func makeCategoryButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.textColor = UIColor.white
        button.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        button.layer.cornerRadius = 20
        return button
    }
    
    private func makeHorizontalStackView(buttons: [UIButton]) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }
    
    private func updatePlayerAsset() {
        guard let asset = asset else { return }
        
        let player = AVPlayer(playerItem: AVPlayerItem(asset: asset))
        playerLayer.player = player
        player.play()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: player.currentItem)
    }
    
    // MARK: - Actions
    @objc private func playerItemDidReachEnd(notification: Notification) {
        playerLayer.player?.seek(to: .zero)
        playerLayer.player?.play()
    }
    
    @objc func didSelectCancelButton(_ sender: UIButton) {
        coordinator?.didFinishFlow()
    }
    
    @objc func didSelectCheckButton(_ sender: UIButton) {
        guard let asset = asset else { return }
        coordinator?.didSelect(avAsset: asset)
    }
}
