//
//  SNSBottomSheetViewController.swift
//  ProfileDetailFeature
//
//  Created by 강치우 on 8/9/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit
import SnapKit

final class SNSBottomSheetViewController: UIViewController {
    // MARK: - Private properties
    private let linkList: [LinkItem]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LinkItemCell.self, forCellReuseIdentifier: "LinkItemCell")
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    // MARK: - Life Cycle
    init(linkList: [LinkItem]) {
        self.linkList = linkList
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUserInterface()
        configLayout()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
    }
    
    private func configLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension SNSBottomSheetViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return linkList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LinkItemCell", for: indexPath) as! LinkItemCell
        let linkItem = linkList[indexPath.row]
        let isLastCell = indexPath.row == linkList.count - 1
        cell.configure(with: linkItem, showDivider: !isLastCell)
        return cell
    }
    
    // MARK: 셀 선택 시 호출
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = linkList[indexPath.row]
        if let url = URL(string: selectedItem.link) {
            UIApplication.shared.open(url)
        }
    }
}
