//
//  TeenViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import SnapKit

import UIKit

public protocol TeenViewControllerCoordinator: AnyObject {
    func didSelectTeenCategory()
    func configTabbarState(view: TeenFeatureViewNames)
}

public final class TeenViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private var viewModel: TeenViewModel
    private weak var coordinator: TeenViewControllerCoordinator?
    
    private lazy var teenButton: UIButton = {
        let button = UIButton()
        button.setTitle("button", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    
    // MARK: - Life Cycle
    init(
        viewModel: TeenViewModel,
        coordinator: TeenViewControllerCoordinator?
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        setButtonActions()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        coordinator?.configTabbarState(view: .teen)
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.view.backgroundColor = UIColor.systemBackground
        self.view.addSubview(teenButton)
    }
    
    private func configLayout() {
        self.teenButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
    
    private func setButtonActions() {
        teenButton.addTarget(self, action: #selector(selectTeenButton(_:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func selectTeenButton(_ sender: UIButton) {
        self.coordinator?.didSelectTeenCategory()
    }
 
}

// MARK: - Extensions here

