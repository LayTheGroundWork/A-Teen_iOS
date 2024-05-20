//
//  PostDetailViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/20/24.
//

import UIKit

protocol PostDetailViewControllerCoordinator: AnyObject {
    func didTapPhotoButton()
    func didTapMoreDetailButton()
    func didTapSourceButton()
}

final class PostDetailViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private let photosButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Photos"
        button.configuration = configuration
        return button
    }()
    
    private let moreDetailButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "More detail"
        button.configuration = configuration
        return button
    }()
    
    private let sourceButton: UIButton = {
        let button = UIButton(type: .system)
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Source"
        button.configuration = configuration
        return button
    }()
    
    private weak var coordinator: PostDetailViewControllerCoordinator?
    
    // MARK: - Life Cycle
    init(coordinator: PostDetailViewControllerCoordinator) {
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
        
        let stackView = UIStackView(arrangedSubviews: [photosButton, moreDetailButton, sourceButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        view.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        configAction()
    }
    
    // MARK: - Actions
    private func configAction() {
        let photosAction = UIAction { [weak self] _ in
            self?.coordinator?.didTapPhotoButton()
        }
        photosButton.addAction(photosAction, for: .touchUpInside)
        
        let moreDetailAction = UIAction { [weak self] _ in
            self?.coordinator?.didTapMoreDetailButton()
        }
        moreDetailButton.addAction(moreDetailAction, for: .touchUpInside)
        
        let sourceAction = UIAction { [weak self] _ in
            self?.coordinator?.didTapSourceButton()
        }
        sourceButton.addAction(sourceAction, for: .touchUpInside)
    }
    
}

// MARK: - Extensions here

