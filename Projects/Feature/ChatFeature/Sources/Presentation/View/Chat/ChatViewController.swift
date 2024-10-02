//
//  ChatViewController.swift
//  ChatingFeature
//
//  Created by 김명현 on 7/28/24.
//

import Common
import DesignSystem
import UIKit

public protocol ChatViewControllerCoordinator: AnyObject {
    func configTabbarState(view: ChatFeatureViewNames)
    func didTapCell(userID: ChatModel)
    func didTapLeaveButton(for indexPath: IndexPath)
}

public protocol ChatViewControllerDelegate: AnyObject {
    func updateChatList()
}

public final class ChatViewController: UIViewController {
    // MARK: - Private properties
    public var selectIndexPath: IndexPath?
    private var viewModel: ChatViewModel
    private weak var coordinator: ChatViewControllerCoordinator?
    
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
    public init(coordinator: ChatViewControllerCoordinator, viewModel: ChatViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
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
    
    // MARK: - Helpers
    private func configUserInterFace() {
        view.addSubview(chatTableView)
        view.addSubview(searchTextField)
        view.addSubview(titleLabel)
    }
    
    private func configLayout() {
        chatTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).offset(ViewValues.height * 0.01)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().offset(-85)
        }
        
        searchTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(ViewValues.height * 0.04)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ViewValues.height * 0.07)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
    }
    
    public func leaveChatRoom(at indexPath: IndexPath) {
        let chatRoomRemove = viewModel.filteredChatRooms[indexPath.row]
        
        if let indexInChatRooms = viewModel.chatRooms.firstIndex(where: { $0.name == chatRoomRemove.name }) {
            viewModel.chatRooms.remove(at: indexInChatRooms)
        }
        viewModel.filteredChatRooms.remove(at: indexPath.row)
        chatTableView.deleteRows(at: [indexPath], with: .automatic)
        print(viewModel.filteredChatRooms.count)
        selectIndexPath = nil
    }
    
    // MARK: - Actions
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
extension ChatViewController: UITableViewDataSource {
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

extension ChatViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        85
    }
    
    public func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let leaveAction = UIContextualAction(style: .destructive, title: "") { [weak self] (action, view, completionHandler) in
            // trailing Swipe Button 눌렀을때 action
            self?.selectIndexPath = indexPath
            self?.coordinator?.didTapLeaveButton(for: indexPath)
            
            completionHandler(true)
        }
        self.selectIndexPath = indexPath
        
        let leaveButtonView = LeaveButtonView(frame: CGRect(x: 0, y: 0, width: 100, height: 85))
        
        leaveAction.image = leaveButtonView.asImage()
        leaveAction.backgroundColor = .white
        
        let configuration = UISwipeActionsConfiguration(actions: [leaveAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.didTapCell(userID: viewModel.chatRooms[indexPath.row])
    }
}

// MARK: - Extensions here
extension ChatViewController: UITextFieldDelegate {
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.placeholder = ""
    }
}




