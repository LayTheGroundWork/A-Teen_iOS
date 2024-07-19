//
//  ViewController.swift
//  ChatingFeature
//
//  Created by 김명현 on 7/28/24.
//

import AlertFeature
import Common
import DesignSystem
import UIKit
import SnapKit

final class MainChatViewController: UIViewController {
    private var chatRooms = ["강치우", "노주영", "이창준", "최동호"]
    private var filteredChatRooms:[String] = []
    private var deleteIndexPath: IndexPath?
    
    
    private lazy var chatTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(ChatRoomCell.self, forCellReuseIdentifier: ChatRoomCell.reuseIdentifier)
        
        return tableView
    }()
    
    private lazy var searchTextField: UITextField = {
        var textField = UITextField()
        textField.placeholder = "친구를 검색해보세요"
        textField.layer.cornerRadius = 12
        textField.backgroundColor = UIColor.systemGray5
        textField.delegate = self
        textField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 24))
        
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 13, y: 0, width: 24, height: 24)
        
        paddingView.addSubview(imageView)
        
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    private lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "Chat"
        title.font = .systemFont(ofSize: 18, weight: .bold)
        
        return title
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        filteredChatRooms = chatRooms
        configUserInterFace()
        configLayout()
    }
    
    private func configUserInterFace() {
        view.addSubview(chatTableView)
        view.addSubview(searchTextField)
        view.addSubview(titleLabel)
        
    }
    
    private func configLayout() {
        chatTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(20)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
    }
    
    @objc func searchTextChanged() {
        if let searchText = searchTextField.text, !searchText.isEmpty {
            filteredChatRooms = chatRooms.filter { $0.contains(searchText) }
        } else {
            filteredChatRooms = chatRooms
        }
        chatTableView.reloadData()
    }
}

extension MainChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredChatRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ChatRoomCell.reuseIdentifier,
            for: indexPath
        ) as? ChatRoomCell else { return UITableViewCell() }
        if indexPath.row < filteredChatRooms.count {
            let name = filteredChatRooms[indexPath.row]
            cell.configure(name)
            
        }
        return cell
    }
}

extension MainChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let leaveAction = UIContextualAction(style: .destructive, title: "") { (action, view, completionHandler) in
            // trailingSwipeButton 눌렀을때 액션
            self.showLeaveAlert()
            completionHandler(true)
        }
        self.deleteIndexPath = indexPath
        
        let leaveButtonView = LeaveButtonView(frame: CGRect(x: 0, y: 0, width: 80, height: 85))
        leaveAction.backgroundColor = .white
        leaveAction.image = leaveButtonView.asImage()
        
        let configuration = UISwipeActionsConfiguration(actions: [leaveAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoomVC = ChatRoomViewController()
        let name = filteredChatRooms[indexPath.row]
        
        chatRoomVC.partnerName = name
        navigationController?.pushViewController(chatRoomVC, animated: true)
    }
    
    private func showLeaveAlert() {
        let alertVC = TwoButtonDialogViewController(
            dialogTitle: "채팅방에서 나가시겠습니까?",
            titleColor: .black,
            titleNumberOfLine: 1,
            titleFont: UIFont.systemFont(ofSize: 16,weight: .bold),
            dialogMessage: nil,
            messageColor: .gray,
            messageNumberOfLine: 2,
            messageFont: UIFont.systemFont(ofSize: 14),
            leftButtonText: "취소",
            leftButtonColor: .gray,
            rightButtonText: "나가기",
            rightButtonColor: .red,
            coordinator: self)
    }
}

extension MainChatViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
}

extension MainChatViewController: AlertViewControllerCoordinator {
    func didSelectButton() {
        dismiss(animated: true)
    }
    
    func didSelectSecondButton() {
        guard let indexPath = deleteIndexPath else { return }
        let nameToRemove = filteredChatRooms[indexPath.row]
        
        if let indexInChatRooms = chatRooms.firstIndex(of: nameToRemove) {
            chatRooms.remove(at: indexInChatRooms)
        }
        
        filteredChatRooms.remove(at: indexPath.row)
        chatTableView.deleteRows(at: [indexPath], with: .automatic)
        
        dismiss(animated: true)
    }
}



