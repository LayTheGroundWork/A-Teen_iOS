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

public protocol ChatRoomModalViewControllerCoordinator: AnyObject {
    func didFinish()
}

public final class ChatRoomModalViewController: UIViewController {
    // MARK: - Private properties
    weak var coordinator: ChatRoomModalViewControllerCoordinator?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChatRoomModalTableViewCell.self, forCellReuseIdentifier: ChatRoomModalTableViewCell.reuseIdentifier)
        tableView.backgroundColor = DesignSystemAsset.backgroundColor.color
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = UIColor.lightGray.withAlphaComponent(0.5)
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = ViewValues.defaultRadius
        tableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
        tableView.sectionHeaderHeight = 5
        tableView.sectionFooterHeight = 10
        
        return tableView
    }()
    
    private lazy var swipeIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    // MARK: - Life Cycle
    public init(coordinator: ChatRoomModalViewControllerCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = DesignSystemAsset.backgroundColor.color
        view.layer.cornerRadius = ViewValues.defaultRadius
        
        configUserInterface()
        configLayout()
    }
    
    // MARK: - Helpers
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
            make.top.equalTo(swipeIndicator.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

// MARK: - Extensions here
extension ChatRoomModalViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                print("신고하기")
            } else if indexPath.row == 1 {
                print("차단하기")
            }
        } else if indexPath.section == 1 {
            print("방나가기")
            coordinator?.didFinish()
            dismiss(animated: true, completion: nil)
        }
    }
}

extension ChatRoomModalViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 1
    }
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatRoomModalTableViewCell.reuseIdentifier, for: indexPath) as? ChatRoomModalTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                cell.configure(title: AppLocalized.reportButton, image: DesignSystemAsset.reportIcon.image, color: .black)
            } else if indexPath.row == 1 {
                cell.configure(title: AppLocalized.blockButton, image: DesignSystemAsset.blockIcon.image, color: .black)
            }
        } else if indexPath.section == 1 {
            cell.configure(title: "채팅방 나가기", image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), color: .red)
        }
        
        return cell
    }
}

extension ChatRoomModalViewController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ChatRoomPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
