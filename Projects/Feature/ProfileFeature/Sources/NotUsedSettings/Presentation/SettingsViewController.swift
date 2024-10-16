//
//  SettingsViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import UIKit

public protocol SettingsViewControllerCoordinator: AnyObject {
    func didSelectCell(settingsViewNavigation: SettingsViewNavigation)
}

final class SettingsViewController: UITableViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private let viewModel: SettingsViewModel
    private weak var coordinator: SettingsViewControllerCoordinator?
    
    // MARK: - Life Cycle
    init(
        viewModel: SettingsViewModel,
        coordinator: SettingsViewControllerCoordinator? = nil
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configTableView()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.systemBackground
    }
    
    private func configTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
        tableView.backgroundColor = UIColor.systemGroupedBackground
    }
    
    // MARK: - Actions
}

// MARK: - DataSource
extension SettingsViewController {
    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel.settingsCount
    }
    
    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let viewModel = viewModel.getItemSettingsViewModel(row: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "id", for: indexPath)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = viewModel.title
        contentConfiguration.image = UIImage(systemName: viewModel.icon)
        cell.contentConfiguration = contentConfiguration
        cell.selectionStyle = .none
        
        return cell
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        let navigation = viewModel.cellSelected(row: indexPath.row)
        coordinator?.didSelectCell(settingsViewNavigation: navigation)
    }
}
