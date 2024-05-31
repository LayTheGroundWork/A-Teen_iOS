//
//  PhoneNumberViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import SnapKit

import UIKit

protocol PhoneNumberViewControllerCoordinator: AnyObject {
    func didFinish()
    func didSelectCertificateButton()
    func didSelectNextButton()
}

final class PhoneNumberViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var coordinator: PhoneNumberViewControllerCoordinator?
    
    // 뒤로 가기 버튼
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "leftArrowIcon"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(didSelectBackButton(_:)))
        button.tintColor = .black
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle(AppLocalized.nextButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    // MARK: - Life Cycle
    init(coordinator: PhoneNumberViewControllerCoordinator) {
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
        navigationItem.leftBarButtonItem = backButton

    }
    
    private func configLayout() {
        
    }
    
    
    private func setupActions() {
        nextButton.addTarget(self,
                             action: #selector(didSelectNextButton(_: )),
                             for: .touchUpInside)
    }
    // MARK: - Actions
    
    @objc private func didSelectCertificateButton(_ sender: UIButton) {
        
    }
    
    @objc private func didSelectNextButton(_ sender: UIButton) {
        
    }
    
    @objc private func didSelectBackButton(_ sender: UIBarButtonItem) {
        coordinator?.didFinish()
    }
}

// MARK: - Extensions here

