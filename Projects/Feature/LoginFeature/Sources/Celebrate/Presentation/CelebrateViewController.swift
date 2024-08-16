//
//  CelebrateViewController.swift
//  LoginFeature
//
//  Created by 최동호 on 8/10/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol CelebrateViewControllerCoordinator: AnyObject {
    func didFinish()
}

public final class CelebrateViewController: UIViewController {
    // MARK: - Private properties
    private weak var coordinator: CelebrateViewControllerCoordinator?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        label.text = AppLocalized.celebrateTitle
        label.textAlignment = .center
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 10)
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle(AppLocalized.startButton, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    // MARK: - Life Cycle
    public init(coordinator: CelebrateViewControllerCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true

        configUserInterface()
        configLayout()
        setButtonActions()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        view.addSubview(titleLabel)
        view.addSubview(startButton)
    }
    
    private func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(111)
            make.centerX.equalToSuperview()
        }
        
        startButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-50)
            make.height.equalTo(50)
        }
    }
    
    private func setButtonActions() {
        startButton.addTarget(self,
                              action: #selector(didSelectStartButton(_:)),
                              for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func didSelectStartButton(_ sender: UIButton) {
        coordinator?.didFinish()
    }
}

// MARK: - Extensions here
