//
//  LinksCollectionViewCell.swift
//  ProfileFeature
//
//  Created by phang on 7/15/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import DesignSystem
import Common
import UIKit

final class LinksCollectionViewCell: UICollectionViewCell {
    // MARK: - Private properties
    private var delegate: LinksDialogViewControllerDelegate?
    private var viewModel: ProfileViewModel?
    private var linkTableViewHeightAnchor: Constraint?

    private lazy var linkAddButton: CustomLinkAddButton = {
        let button = CustomLinkAddButton()
        button.addTarget(self, action: #selector(clickLinkAddButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var linkTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LinkTableViewCell.self,
                           forCellReuseIdentifier: LinkTableViewCell.reuseIdentifier)
        return tableView
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.addSubview(linkAddButton)
        contentView.addSubview(linkTableView)
    }
    
    private func configLayout() {
        linkAddButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(22)
            make.height.equalTo(40)
            make.width.equalTo(
                (self.linkAddButton.customtextLabel.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: self.linkAddButton.customtextLabel.font!]).width + 50
            )
        }
        
        linkTableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(linkAddButton.snp.bottom).offset(7)
            self.linkTableViewHeightAnchor = make.height.equalTo(0).constraint
        }
    }
    
    private func changeViewHeight() {
        guard let userLinks = viewModel?.userLinks else { return }

        self.linkTableViewHeightAnchor?.update(offset: userLinks.count * 34)
    }
    
    func setProperties(
        delegate: LinksDialogViewControllerDelegate,
        viewModel: ProfileViewModel
    ) {
        self.delegate = delegate
        self.viewModel = viewModel
        
        changeViewHeight()
        updateLinkAddButton()
    }
    
    // MARK: - Actions
    @objc private func clickLinkAddButton(_ sender: UIButton) {
        delegate?.didTabAddLinkButton()
    }
    
    private func updateLinkAddButton() {
        guard let userLinks = viewModel?.userLinks else { return }
        
        if userLinks.count == 3 {
            linkAddButton.plusImageView.image = DesignSystemAsset.plusGray03Icon.image
            linkAddButton.customtextLabel.textColor = DesignSystemAsset.gray03.color
        } else if userLinks.count < 3 {
            self.linkAddButton.plusImageView.image = DesignSystemAsset.plusGray01Icon.image
            self.linkAddButton.customtextLabel.textColor = DesignSystemAsset.gray02.color
        }
    }
}

// MARK: - UITableViewDataSource
extension LinksCollectionViewCell: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(
                withIdentifier: LinkTableViewCell.reuseIdentifier,
                for: indexPath) as? LinkTableViewCell,
            let viewModel = viewModel
        else {
            return UITableViewCell()
        }
        
        cell.setLink(link: viewModel.userLinks[indexPath.row].link,
                     title: viewModel.userLinks[indexPath.row].title)
        
        cell.deleteButtonAction = { [self] in
            viewModel.userLinks.remove(at: indexPath.row)
            
            self.linkTableView.reloadData()
            
            self.changeViewHeight()
            
            self.updateLinkAddButton()

            self.delegate?.updateDialogHeight()
        }
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        viewModel?.userLinks.count ?? 0
    }
}

// MARK: - UITableViewDelegate
extension LinksCollectionViewCell: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        34
    }
}

// MARK: - Reusable
extension LinksCollectionViewCell: Reusable { }
