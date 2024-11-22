//
//  SettingsViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol SettingsViewControllerCoordinator: AnyObject {
    func didTapBackButton()
    func didTapLogOut()
    func didTapVideoPlayType()
    func didTapService()
    func didTapInformation()
    func didTapInquire()
    func didTapVersion()
}

final class SettingsViewController: UIViewController {
    private let headerList = ["서비스 설정", "정보"]
    private let viewModel: SettingsViewModel
    private weak var coordinator: SettingsViewControllerCoordinator?
    
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: DesignSystemAsset.leftArrowIcon.image,
            style: .done,
            target: self,
            action: #selector(clickBackButton(_:)))
        button.tintColor = UIColor.black
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "설정"
        label.textColor = UIColor.black
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    private lazy var settingsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    init(
        viewModel: SettingsViewModel,
        coordinator: SettingsViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.systemBackground
        
        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleLabel
        
        view.addSubview(settingsTableView)
    }
    
    private func configLayout() {
        settingsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc private func clickBackButton(_ sender: UIBarButtonItem) {
        coordinator?.didTapBackButton()
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 6
        default:
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as? SettingsTableViewCell
        else {
            return UITableViewCell()
        }
        cell.setProperties(
            viewModel: viewModel,
            indexPath: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 2:
                coordinator?.didTapVideoPlayType()
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0:
                coordinator?.didTapService()
            case 1:
                coordinator?.didTapInformation()
            case 2:
                coordinator?.didTapInquire()
            case 3:
                coordinator?.didTapVersion()
            case 4:
                coordinator?.didTapLogOut()
            case 5:
                // TODO: 회원 탈퇴 로직
                coordinator?.didTapLogOut()
            default:
                break
            }
        default:
            break
        }
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        54
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        section == 0 ? 35 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .systemBackground
        
        let titleLabel = UILabel()
        titleLabel.text = headerList[section]
        titleLabel.font = .customFont(forTextStyle: .headline, weight: .bold)
        titleLabel.textColor = .black
        
        headerView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.trailing.equalToSuperview().inset(ViewValues.defaultPadding)
            make.height.equalTo(21)
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        switch section {
        case 0:
            let footerView = UIView()
            footerView.backgroundColor = .white
            
            let lineView = UIView()
            lineView.backgroundColor = DesignSystemAsset.gray04.color

            footerView.addSubview(lineView)
            
            lineView.snp.makeConstraints { make in
                make.leading.trailing.bottom.equalToSuperview()
                make.height.equalTo(7)
            }
            return footerView
        default:
            return nil
        }
    }
}
