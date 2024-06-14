//
//  UserConfigurationViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/21/24.
//

import UIKit

public protocol UserConfigurationViewControllerCoordinator: AnyObject {
    func didSelectAvatarButton()
    func didFinishFlow()
}

public final class UserConfigurationViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var coordinator: UserConfigurationViewControllerCoordinator?
    
    // MARK: - Life Cycle
    init(coordinator: UserConfigurationViewControllerCoordinator) {
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
        
        let avatarButton = UIBarButtonItem(
            image: UIImage(systemName: "person"),
            primaryAction: avatarAction())
        
        navigationItem.rightBarButtonItem = avatarButton
        
        let closeButton = UIBarButtonItem(
            systemItem: .close,
            primaryAction: closeFlowAction())
        
        navigationItem.leftBarButtonItem = closeButton
    }
    
    // MARK: - Actions
    func avatarAction() -> UIAction{
        UIAction { [weak self] _ in
            self?.coordinator?.didSelectAvatarButton()
        }
    }
    
    func closeFlowAction() -> UIAction {
        UIAction { [weak self] _ in
            self?.coordinator?.didFinishFlow()
        }
    }
    
}

// MARK: - Extensions here

