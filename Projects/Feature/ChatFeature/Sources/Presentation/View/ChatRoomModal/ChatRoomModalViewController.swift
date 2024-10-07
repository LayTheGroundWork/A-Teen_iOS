//
//  ChatPopOverModalViewController.swift
//  ChatFeature
//
//  Created by 김명현 on 8/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import FeatureDependency
import SnapKit
import UIKit

public protocol ChatRoomModalViewControllerCoordinator: AnyObject {
    func didTapLeaveButton()
    func didTapReportButton()
    func didFinish()
}

public final class ChatRoomModalViewController: UIViewController {
    // MARK: - Private properties
    weak var coordinator: ChatRoomModalViewControllerCoordinator?
    private var modalViewHeightAnchor: Constraint?
    
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
        tableView.isUserInteractionEnabled = true
        
        return tableView
    }()
    
    private lazy var modalView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.backgroundColor.color
        view.layer.cornerRadius = ViewValues.defaultRadius
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private lazy var swipeIndicator: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    // MARK: - Life Cycle
    public init(
        coordinator: ChatRoomModalViewControllerCoordinator
    ) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        modalPresentationStyle = .custom
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configUserInterface()
        configLayout()
        configTapGesture()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        animateView()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.layer.cornerRadius = ViewValues.defaultRadius
        
        view.addSubview(modalView)
        modalView.addSubview(swipeIndicator)
        modalView.addSubview(tableView)
    }
    
    private func configLayout() {
        modalView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            
            self.modalViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
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
    
    private func configTapGesture() {
        //탭 제스처
        let handleGesture = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
            modalView.addGestureRecognizer(handleGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectBackView(_:)))
        view.addGestureRecognizer(tapGesture)
        
        let modalTapGesture = UITapGestureRecognizer(target: self, action: #selector(didSelectTouchView(_:)))
        modalView.addGestureRecognizer(modalTapGesture)
        
        let tableViewTap = UITapGestureRecognizer(target: self, action: #selector(handleTableViewTap(_:)))
        tableViewTap.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tableViewTap)
    }
    
    func animateView() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .showHideTransitionViews) {
            self.modalViewHeightAnchor?.update(offset: 260)
            
            self.view.layoutIfNeeded()
        }
    }
    
    func closeAnimation() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .showHideTransitionViews) {
            self.modalViewHeightAnchor?.update(offset: 0)
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.coordinator?.didFinish()
        }
    }
    
    // MARK: - Actions
    @objc func didSelectTouchView(_ sender: Any) {
        self.modalView.endEditing(true)
    }
    
    @objc func didSelectBackView(_ sender: Any) {
        closeAnimation()
    }
    
    @objc func handleTableViewTap(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: tableView)
        if let indexPath = tableView.indexPathForRow(at: location) {
            // 셀을 탭한 경우 테이블 뷰의 기본 동작을 수행
            tableView(tableView, didSelectRowAt: indexPath)
        } else {
            // 셀 외의 영역을 탭한 경우 모달을 닫음
            closeAnimation()
        }
    }
    
    @objc private func handleGesture(_ sender: UIPanGestureRecognizer) {
        // 스와이프 제스쳐로 modal dismiss
        let translation = sender.translation(in: modalView)
        
        switch sender.state {
        case .changed:
            if translation.y > 0 {
                modalView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended:
            if translation.y > 60 {
                closeAnimation()
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.modalView.transform = .identity
                }
            }
        default:
            break
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
                coordinator?.didTapReportButton()
            } else if indexPath.row == 1 {
                print("차단하기")
            }
        } else if indexPath.section == 1 {
            coordinator?.didTapLeaveButton()
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
            cell.configure(title: AppLocalized.exitChatRoom, image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), color: .red)
        }
        
        return cell
    }
}
