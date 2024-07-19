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

public protocol MainChatViewControllerCoordinator: AnyObject {
    func configTabbarState(view: ChatFeatureViewNames)
    func navigateToChatRoom(chatRoom: ChatModel)
}

public final class MainChatViewController: UIViewController {
    // MARK: - Private properties
    private var viewModel = ChatViewModel()
    private var deleteIndexPath: IndexPath?
    private weak var coordinator: MainChatViewControllerCoordinator?
    
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
    
    // MARK: - Life Cycle
    
    public init(coordinator: MainChatViewControllerCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        
        viewModel.filteredChatRooms = viewModel.chatRooms
        configUserInterFace()
        configLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coordinator?.configTabbarState(view: .main)
        navigationController?.isNavigationBarHidden = true
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
            make.bottom.equalToSuperview().offset(-85)
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
    
    private func navigateToChatRoom(chatRoom: ChatModel) {
        coordinator?.navigateToChatRoom(chatRoom: chatRoom)
    }
    
    @objc func searchTextChanged() {
        if let searchText = searchTextField.text, !searchText.isEmpty {
            viewModel.filteredChatRooms = viewModel.chatRooms.filter { $0.name.contains(searchText) }
        } else {
            viewModel.filteredChatRooms = viewModel.chatRooms
        }
        chatTableView.reloadData()
    }
}

// MARK: - Extensions here
extension MainChatViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredChatRooms.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ChatRoomCell.reuseIdentifier,
            for: indexPath
        ) as? ChatRoomCell else { return UITableViewCell() }
        if indexPath.row < viewModel.filteredChatRooms.count {
            let chatRoom = viewModel.filteredChatRooms[indexPath.row]
            cell.configure(chatRoom)
        }
        return cell
    }
}

extension MainChatViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
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
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoomVC = ChatRoomViewController()
        let chatRoom = viewModel.filteredChatRooms[indexPath.row]
        
        chatRoomVC.partnerName = chatRoom.name
        chatRoomVC.coordinator = coordinator
        navigateToChatRoom(chatRoom: chatRoom)
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
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true, completion: nil)
    }
}

extension MainChatViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
}

extension MainChatViewController: AlertViewControllerCoordinator {
    public func didSelectButton() {
        dismiss(animated: true)
    }
    
    public func didSelectSecondButton() {
        guard let indexPath = deleteIndexPath else { return }
        let chatRoomRemove = viewModel.filteredChatRooms[indexPath.row]
        
        if let indexInChatRooms = viewModel.chatRooms.firstIndex(where: { $0.name == chatRoomRemove.name }) {
            viewModel.chatRooms.remove(at: indexInChatRooms)
        }
        viewModel.filteredChatRooms.remove(at: indexPath.row)
        chatTableView.deleteRows(at: [indexPath], with: .automatic)
        
        dismiss(animated: true)
    }
}



