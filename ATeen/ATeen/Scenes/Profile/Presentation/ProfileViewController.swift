//
//  ProfileViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import UIKit

protocol ProfileViewControllerCoordinator: AnyObject {
    func didTabSettingButton()
}

final class ProfileViewController: UIViewController {
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
    init(coordinator: ProfileViewControllerCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(settingButton)
        
        settingButton.centerXY()
        settingButton.setWidthConstraint(with: 200)
        settingButton.setHeightConstraint(with: 100)
    }
    
    // MARK: - Actions
    @objc func clickButton(_ sender: UIButton) {
        self.coordinator?.didTabSettingButton()
    }
    
}

// MARK: - Extensions here

