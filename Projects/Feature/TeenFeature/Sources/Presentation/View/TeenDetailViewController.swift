//
//  TeenDetailViewController.swift
//  TeenFeature
//
//  Created by 최동호 on 7/16/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol TeenDetailViewControllerCoordinator: AnyObject {
    func didTapBackButton()
    func didSelectTeenImage(
        frame: CGRect,
        teen: TodayTeen)
    func didSelectTeenChattingButton()
    func didSelectMenuButton(popoverPosition: CGRect)
    func configTabbarState(view: TeenFeatureViewNames)
}

public final class TeenDetailViewController: UIViewController {
    // MARK: - Public properties

    // MARK: - Private properties
    private let viewModel: TeenDetailViewModel
    private weak var coordinator: TeenDetailViewControllerCoordinator?

    private var selectedLabelText: String?

    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(
            image: DesignSystemAsset.leftArrowIcon.image,
            style: .plain,
            target: self,
            action: #selector(didSelectBackButton))

        button.tintColor = UIColor.black
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = (selectedLabelText ?? AppLocalized.teenDetailTextLabel).replacingOccurrences(of: "\n", with: " ")
        label.textColor = UIColor.black
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TeenTableViewCell.self, forCellReuseIdentifier: TeenTableViewCell.reuseIdentifier)

        return tableView
    }()

    // MARK: - Life Cycle
    init(
        viewModel: TeenDetailViewModel,
        coordinator: TeenDetailViewControllerCoordinator,
        selectedLabelText: String?
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.selectedLabelText = selectedLabelText
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()

        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTableView(_:)),
                                               name: .completeLogin,
                                               object: nil)
        
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }

    public override func viewWillAppear(_ animated: Bool) {
        coordinator?.configTabbarState(view: .teenDetail)
    }

    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.systemBackground

        navigationItem.leftBarButtonItem = backButton
        navigationItem.titleView = titleLabel
        
        self.view.addSubview(tableView)

    }

    private func configLayout() {
        self.tableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
        }
    }

    // MARK: - Actions
    @objc private func didSelectBackButton(_ sender: UIButton) {
        coordinator?.didTapBackButton()
    }

    @objc private func updateTableView(_ notification: Notification) {
        print("11")
        tableView.reloadData()
    }
}

// MARK: - Extensions here
extension TeenDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.teenList.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TeenTableViewCell.reuseIdentifier,
                for: indexPath) as? TeenTableViewCell
        else {
            return UITableViewCell()
        }

        cell.selectionStyle = .none

        cell.setCell(teen: viewModel.getTeenItemTeenViewModel(row: indexPath.row))

        cell.chatButtonAction = { [weak self] in
            guard let self = self else { return }
            self.coordinator?.didSelectTeenChattingButton()
        }

        cell.heartButtonAction = { [weak self] in
            guard let self = self else { return }
            self.viewModel.didSelectTeenHeartButton()
        }
        cell.menuButtonAction = { [weak self] in
            guard let self = self else { return }

            cell.layoutIfNeeded()
            guard let mainView = tableView.superview,
                  let appView = mainView.superview
            else { return }

            let cellPosition = cell.convert(cell.bounds, to: appView)
            let menuButtonPosition = CGRect(
                x: cellPosition.maxX,
                y: cellPosition.minY,
                width: cellPosition.width,
                height: cellPosition.height)
            self.coordinator?.didSelectMenuButton(popoverPosition: menuButtonPosition)
        }
        return cell

    }
}

extension TeenDetailViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cellClicked = tableView.cellForRow(at: indexPath),
              let frame = cellClicked.superview?.convert(
                CGRect(
                    x: 16,
                    y: cellClicked.frame.origin.y,
                    width: cellClicked.frame.width - 32,
                    height: cellClicked.frame.height),
                to: nil)
        else { return }

        coordinator?.didSelectTeenImage(
            frame: frame,
            teen: viewModel.getTeenItemTeenViewModel(row: indexPath.row))
    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        ViewValues.anotherTeenImageHeight
    }
}

extension TeenDetailViewController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
