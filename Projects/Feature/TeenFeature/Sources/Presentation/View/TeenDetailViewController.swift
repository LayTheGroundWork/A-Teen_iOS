//
//  TeenDetailViewController.swift
//  TeenFeature
//
//  Created by 최동호 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import UIKit

final class TeenDetailViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        setButtonActions()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
    }
    
    private func configLayout() {
        
    }
    
    private func setButtonActions() {
        
    }
    
    // MARK: - Actions
    
}

// MARK: - Extensions here
