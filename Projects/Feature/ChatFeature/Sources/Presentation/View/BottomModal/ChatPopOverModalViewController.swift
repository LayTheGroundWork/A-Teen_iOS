//
//  ChatPopOverModalViewController.swift
//  ChatFeature
//
//  Created by 김명현 on 8/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import SnapKit
import UIKit

public final class ChatPopOverModalViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatPopOverModalTableViewCell.self, forCellReuseIdentifier: ChatPopOverModalTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = DesignSystemAsset.backgroundColor.color
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    private lazy var swipeIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = DesignSystemAsset.backgroundColor.color
        view.layer.cornerRadius = ViewValues.defaultRadius
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        configUserInterface()
        configLayout()
    }
    
    private func configUserInterface() {
        view.addSubview(swipeIndicator)
        view.addSubview(tableView)
    }
    
    private func configLayout() {
        swipeIndicator.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.equalTo(40)
            make.height.equalTo(5)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(swipeIndicator.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ChatPopOverModalViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatPopOverModalTableViewCell.reuseIdentifier, for: indexPath) as? ChatPopOverModalTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.row == 0 {
            cell.configure(with: AppLocalized.reportButton, image: DesignSystemAsset.reportIcon.image)
        } else if indexPath.row == 1 {
            cell.configure(with:  AppLocalized.blockButton, image: DesignSystemAsset.blockIcon.image)
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            print("신고하기")
            dismiss(animated: true, completion: nil)
        } else if indexPath.row == 1 {
            print("차단하기")
            dismiss(animated: true, completion: nil)
        }
    }
}

extension ChatRoomViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ChatPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
