//
//  TrimVideoViewController.swift
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

public protocol TrimVideoViewControllerCoordinator: AnyObject {
    func didSelectCheckButton(asset: AVAsset, isPossible: Bool)
    func didFinish()
}

final class TrimVideoControlViewController: UIViewController {
    // MARK: - Private properties
    private let asset: AVAsset?
    private var soundButtonToggleValue: Bool = true
    private var timeObserverToken: Any?
    private weak var coordinator: TrimVideoViewControllerCoordinator?
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didSelectCancelButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var soundButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "speaker.wave.2"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didSelectSoundButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var checkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "checkmark"), for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(didSelectCheckButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var videoBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
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
    
    private lazy var leadingTrimLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    private lazy var slash: UILabel = {
        let label = UILabel()
        label.text = "/"
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var trailingTrimLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .white
        label.textAlignment = .right
        return label
    }()
    
    private lazy var trimmingStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [leadingTrimLabel, slash, trailingTrimLabel])
        stackView.alignment = .fill
        stackView.spacing = UIStackView.spacingUseSystem
        return stackView
    }()
    
    private lazy var trimmer: VideoTrimmer = {
        let trimmer = VideoTrimmer()
        trimmer.minimumDuration = CMTime(seconds: 1, preferredTimescale: 600)
        trimmer.addTarget(self, action: #selector(didBeginTrimming(_:)), for: VideoTrimmer.didBeginTrimming)
        trimmer.addTarget(self, action: #selector(didEndTrimming(_:)), for: VideoTrimmer.didEndTrimming)
        trimmer.addTarget(self, action: #selector(selectedRangeDidChanged(_:)), for: VideoTrimmer.selectedRangeChanged)
        trimmer.addTarget(self, action: #selector(didBeginScrubbing(_:)), for: VideoTrimmer.didBeginScrubbing)
        trimmer.addTarget(self, action: #selector(didEndScrubbing(_:)), for: VideoTrimmer.didEndScrubbing)
        trimmer.addTarget(self, action: #selector(progressDidChanged(_:)), for: VideoTrimmer.progressChanged)
        return trimmer
    }()
    
    // MARK: - Life Cycle
    init(
        asset: AVAsset,
        coordinator: TrimVideoViewControllerCoordinator
    ) {
        self.asset = asset
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        removePlayerObservers()
        playerLayer.player = nil
        trimmer.removeFromSuperview()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        setAssets()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .black
        view.addSubview(cancelButton)
        view.addSubview(soundButton)
        view.addSubview(checkButton)
        view.addSubview(videoBackgroundView)
        view.addSubview(trimmer)
        view.addSubview(trimmingStackView)
    }
    
    private func configLayout() {
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
        }

        checkButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
        
        soundButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.trailing.equalTo(checkButton.snp.leading).offset(-16)
            make.width.height.equalTo(24)
        }
        
        videoBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.equalTo(view.safeAreaLayoutGuide.snp.width)
        }
        
        trimmer.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-70)
            make.height.equalTo(50)
        }
        
        trimmingStackView.snp.makeConstraints { make in
            make.bottom.equalTo(trimmer.snp.top).offset(-16)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setAssets() {
        trimmer.asset = asset
        
        updatePlayerAsset()
        updateTrimLabel()
        
        // 동영상의 프레임 속도
        let nominalFrameRate = asset?.tracks(withMediaType: .video).first?.nominalFrameRate ?? 30
        let interval = CMTime(seconds: 1 / Double(nominalFrameRate), preferredTimescale: 600)
        
        self.timeObserverToken = playerLayer.player?.addPeriodicTimeObserver(
            forInterval: interval,
            queue: .main
        ) { [weak self] _ in
            guard let self = self else { return }
            
            self.trimmer.progress = CMTimeAdd(self.trimmer.progress, interval)
            
            if let player = playerLayer.player, player.rate != 0 {
                if self.trimmer.progress <= self.trimmer.selectedRange.end {
                    leadingTrimLabel.text = self.trimmer.progress.displayString
                } else {
                    player.pause()
                    leadingTrimLabel.text = self.trimmer.selectedRange.end.displayString
                }
            }
        }
    }
    
    private func updateTrimLabel() {
        leadingTrimLabel.text = trimmer.selectedRange.start.displayString
        
        trailingTrimLabel.text = trimmer.selectedRange.end.displayString
   
        playerLayer.player?.seek(to: trimmer.selectedRange.start, toleranceBefore: .zero, toleranceAfter: .zero)
        
    }
    
    private func updateScrubbingLabel(state: String) {
        let time = CMTimeSubtract(trimmer.progress, trimmer.selectedRange.start)
        leadingTrimLabel.text = time.displayString
        
        switch state {
        case "begin":
            playerLayer.player?.pause()
        case "change":
            playerLayer.player?.seek(to: time, toleranceBefore: .zero, toleranceAfter: .zero)
        default:
            break
        }
    }
    
    private func updatePlayerAsset() {
        guard let asset = asset else { return }
        
        let outputRange = trimmer.trimmingState == .none ? trimmer.selectedRange : asset.fullRange
        let trimmedAsset = asset.trimmedComposition(outputRange)
        let time = trimmer.selectedRange.start
        trimmer.progress = time
        
        if trimmedAsset != playerLayer.player?.currentItem?.asset {
            if playerLayer.player == nil {
                playerLayer.player = AVPlayer(playerItem: AVPlayerItem(asset: trimmedAsset))
                playerLayer.player?.play()
            } else {
                DispatchQueue.main.async { [weak self] in
                    self?.playerLayer.player?.seek(
                        to: time,
                        toleranceBefore: .zero,
                        toleranceAfter: .zero,
                        completionHandler: { _ in
                            self?.playerLayer.player?.play()
                        })
                }
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.playerLayer.player?.seek(
                    to: time,
                    toleranceBefore: .zero,
                    toleranceAfter: .zero,
                    completionHandler: { _ in
                        self?.playerLayer.player?.play()
                    })
            }
        }
    }
    
    private func removePlayerObservers() {
        if let token = timeObserverToken {
            playerLayer.player?.removeTimeObserver(token)
            timeObserverToken = nil
        }
    }
    
    private func trimVideoAsset() -> AVAsset {
        guard let asset = asset else { return AVAsset() }
        
        let composition = AVMutableComposition()
        
        let startTime = trimmer.selectedRange.start
        let endTime = trimmer.selectedRange.end
        let timeRange = CMTimeRange(start: startTime, end: endTime)
        
        let videoTrackComposition = composition.addMutableTrack(withMediaType: .video, preferredTrackID: kCMPersistentTrackID_Invalid)
        let audioTrackComposition = composition.addMutableTrack(withMediaType: .audio, preferredTrackID: kCMPersistentTrackID_Invalid)
        
        do {
            switch soundButtonToggleValue {
            case true:
                try videoTrackComposition?.insertTimeRange(timeRange, of: asset.tracks(withMediaType: .video)[0], at: .zero)
                
                if let audioTrack = asset.tracks(withMediaType: .audio).first {
                    try audioTrackComposition?.insertTimeRange(timeRange, of: audioTrack, at: .zero)
                } else {
                    audioTrackComposition?.insertEmptyTimeRange(CMTimeRangeMake(start: .zero, duration: asset.duration))
                }
                return composition
                
            case false:
                try videoTrackComposition?.insertTimeRange(timeRange, of: asset.tracks(withMediaType: .video)[0], at: .zero)
                return composition

            }
        } catch {
            print("Error: \(error.localizedDescription)")
            return asset
        }
    }
    
    private func checkVideoTime(startTime: CMTime, endTime: CMTime) -> Bool {
        let timeRange = CMTimeRange(start: startTime, end: endTime)
        let tenSeconds = CMTime(seconds: 10, preferredTimescale: timeRange.duration.timescale)
        
        return timeRange.duration < tenSeconds
    }
    
    // MARK: - Action
    @objc private func didBeginTrimming(_ sender: VideoTrimmer) {
        updateTrimLabel()
        updatePlayerAsset()
    }
    
    @objc private func didEndTrimming(_ sender: VideoTrimmer) {
        updateTrimLabel()
        updatePlayerAsset()
    }
    
    @objc private func selectedRangeDidChanged(_ sender: VideoTrimmer) {
        playerLayer.player?.pause()
        updateTrimLabel()
    }
    
    @objc private func didBeginScrubbing(_ sender: VideoTrimmer) {
        updateScrubbingLabel(state: "begin")
    }
    
    @objc private func didEndScrubbing(_ sender: VideoTrimmer) {
        self.playerLayer.player?.play()
    }
    
    @objc private func progressDidChanged(_ sender: VideoTrimmer) {
        updateScrubbingLabel(state: "change")
    }
    
    @objc func didSelectCancelButton(_ sender: UIButton) {
        coordinator?.didFinish()
    }
    
    @objc func didSelectSoundButton(_ sender: UIButton) {
        switch soundButtonToggleValue {
        case true:
            soundButton.setImage(UIImage(systemName: "speaker.slash"), for: .normal)
            playerLayer.player?.isMuted = true
            soundButtonToggleValue.toggle()
        case false:
            soundButton.setImage(UIImage(systemName: "speaker.wave.2"), for: .normal)
            playerLayer.player?.isMuted = false
            soundButtonToggleValue.toggle()
            
        }
    }
    
    @objc func didSelectCheckButton(_ sender: UIButton) {
        playerLayer.player?.pause()
        
        coordinator?.didSelectCheckButton(
            asset: trimVideoAsset(),
            isPossible: checkVideoTime(
                startTime: trimmer.selectedRange.start,
                endTime: trimmer.selectedRange.end
            )
        )
    }
}
