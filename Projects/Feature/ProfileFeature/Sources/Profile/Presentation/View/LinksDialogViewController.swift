//
//  LinksDialogViewController.swift
//  ProfileFeature
//
//  Created by 노주영 on 7/11/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol LinksDialogViewControllerCoordinator: AnyObject {
    func didFinish()
}

final class LinksDialogViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel: ProfileViewModel
    private weak var coordinator: LinksDialogViewControllerCoordinator?
    
    var dialogViewHeightAnchor: Constraint?
    var linkTableViewHeightAnchor: Constraint?
    
    private lazy var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var xmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.xMarkIcon.image, for: .normal)
        button.addTarget(self, action: #selector(clickCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 링크"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .bold)
        return label
    }()
    
    private lazy var linkAddButton: CustomLinkAddButton = {
        let button = CustomLinkAddButton()
        button.addTarget(self, action: #selector(clickLinkAddButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var linkTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LinkTableViewCell.self, forCellReuseIdentifier: LinkTableViewCell.reuseIdentifier)
        return tableView
    }()

    init(
        viewModel: ProfileViewModel,
        coordinator: LinksDialogViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        view.addSubview(dialogView)
        
        dialogView.addSubview(xmarkButton)
        dialogView.addSubview(titleLabel)
        dialogView.addSubview(linkAddButton)
        dialogView.addSubview(linkTableView)
    }
    
    private func configLayout() {
        dialogView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.centerY.equalToSuperview()
            self.dialogViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        xmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
            make.trailing.equalTo(xmarkButton.snp.leading).offset(-20)
            make.height.equalTo(24)
        }
        
        linkAddButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp.bottom).offset(22)
            make.height.equalTo(40)
            make.width.equalTo(
                (self.linkAddButton.customTextLabel.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: self.linkAddButton.customTextLabel.font!]).width + 50
            )
        }
        
        linkTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(linkAddButton.snp.bottom).offset(7)
            self.linkTableViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        changeViewHeight()
    }
    
    func changeViewHeight() {
        self.view.layoutIfNeeded()
        
        self.linkTableViewHeightAnchor?.update(offset: self.viewModel.userLinks.count * 34)
        
        self.view.layoutIfNeeded()
        
        if viewModel.userLinks.isEmpty {
            self.dialogViewHeightAnchor?.update(
                offset: self.titleLabel.frame.height + self.linkAddButton.frame.height + self.linkTableView.frame.height + 62)
        } else {
            self.dialogViewHeightAnchor?.update(
                offset: self.titleLabel.frame.height + self.linkAddButton.frame.height + self.linkTableView.frame.height + 69)
        }
    }
    
    // MARK: - Actions
    @objc private func clickCloseButton(_ sender: UIButton) {
        coordinator?.didFinish()
    }
    
    @objc private func clickLinkAddButton(_ sender: UIButton) {
        if viewModel.userLinks.count < 3 {
            viewModel.userLinks.append("blog.link")
            
            linkTableView.reloadData()
            
            changeViewHeight()
            
            if viewModel.userLinks.count == 3 {
                linkAddButton.plusImageView.image = DesignSystemAsset.plusGray03Icon.image
                linkAddButton.customTextLabel.textColor = DesignSystemAsset.gray03.color
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension LinksDialogViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LinkTableViewCell.reuseIdentifier,
                for: indexPath) as? LinkTableViewCell
        else {
            return UITableViewCell()
        }
        
        cell.setLink(link: viewModel.userLinks[indexPath.row])
        
        cell.deleteButtonAction = { [self] in
            self.viewModel.userLinks.remove(at: indexPath.row)
            self.linkTableView.reloadData()
            
            self.changeViewHeight()
            
            if self.viewModel.userLinks.count < 3{
                self.linkAddButton.plusImageView.image = DesignSystemAsset.plusGray01Icon.image
                self.linkAddButton.customTextLabel.textColor = DesignSystemAsset.gray02.color
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.userLinks.count
    }
}

// MARK: - UITableViewDelegate
extension LinksDialogViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        34
    }
}
