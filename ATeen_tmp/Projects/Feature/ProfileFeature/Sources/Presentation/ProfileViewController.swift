//
//  ProfileViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import SnapKit

import UIKit

public protocol ProfileViewControllerCoordinator: AnyObject {
    func didTabSettingButton()
}

public final class ProfileViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var coordinator: ProfileViewControllerCoordinator?

    lazy var settingButton: UIButton = {
        let button = UIButton()
        button.setTitle("setting", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(clickButton(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    public init(coordinator: ProfileViewControllerCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(settingButton)
        
        settingButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(100)
        }
    }
    
    // MARK: - Actions
    @objc func clickButton(_ sender: UIButton) {
        self.coordinator?.didTabSettingButton()
    }
    
}

// MARK: - Extensions here

