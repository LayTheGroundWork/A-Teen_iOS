//
//  ChatRoomViewController.swift
//  ChatingFeature
//
//  Created by 김명현 on 7/10/24.
//

import Common
import DesignSystem
import UIKit

public protocol ChatRoomViewControllerCoordinator: AnyObject {
    func configTabbarState(view: ChatFeatureViewNames)
    func didFinish()
    func presentChatRoomModal()
}

public final class ChatRoomViewController: UIViewController {
    var chatMessageArray: [ChatMessageModel] = []
    var partnerName: String
    var showChatHeader = false
    weak var coordinator: ChatRoomViewControllerCoordinator?
    
    public init(partnerName: String, coordinator: ChatRoomViewControllerCoordinator) {
        self.partnerName = partnerName
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.chatPartnerNameLabel.text = partnerName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    private lazy var chatPartnerNameLabel: UILabel = {
        let label = UILabel()
        label.text = partnerName
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        return label
    }()
    
    private lazy var headerBackground: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.mainColor.color
        view.layer.cornerRadius = 25
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.15
        view.layer.shadowOffset = CGSize(width: 4, height: 4)
        view.layer.shadowRadius = 4
        
        return view
    }()
    
    private lazy var moreOptionsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    private lazy var messageTextViewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 12
        
        return view
    }()
    
    private lazy var messageTextView: UITextView = {
        let textView = UITextView()
        textView.text = "메세지를 입력해보세요"
        textView.layer.cornerRadius = 12
        textView.backgroundColor = .clear
        textView.textContainerInset = UIEdgeInsets(top: 15, left: 15, bottom: 10, right: 15)
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.textColor = .placeholderText
        textView.isScrollEnabled = false
        textView.delegate = self
        return textView
    }()
    
    private lazy var messageSendButton: CustomSendButton = {
        let button = CustomSendButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 12
        return button
    }()
    
    private lazy var chatRoomTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(PartnerChatMessageViewCell.self, forCellReuseIdentifier: PartnerChatMessageViewCell.reuseIdentifier)
        tableView.register(UserChatMessageViewCell.self, forCellReuseIdentifier: UserChatMessageViewCell.reuseIdentifier)
        tableView.register(ChatHeaderView.self, forHeaderFooterViewReuseIdentifier: ChatHeaderView.reuseIdentifier)
        
        return tableView
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        setupActions()
        configUserInterface()
        configLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        coordinator?.configTabbarState(view: .chatRoom)
    }
    
    private func configUserInterface() {
        view.addSubview(chatRoomTableView)
        view.addSubview(headerBackground)
        view.addSubview(messageTextViewBackground)
        messageTextViewBackground.addSubview(messageTextView)
        messageTextViewBackground.addSubview(messageSendButton)
        headerBackground.addSubview(chatPartnerNameLabel)
        headerBackground.addSubview(backButton)
        headerBackground.addSubview(moreOptionsButton)
    }
    
    private func configLayout() {
        chatRoomTableView.snp.makeConstraints { make in
            make.top.equalTo(headerBackground.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(messageTextView.snp.top)
        }
        
        headerBackground.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(120)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(70)
            make.leading.equalToSuperview().offset(21)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        chatPartnerNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
        }
        
        messageTextViewBackground.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-54)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(48)
        }
        
        messageSendButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-25)
            make.width.equalTo(79)
            make.height.equalTo(28)
        }
        
        messageTextView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview()
            make.trailing.equalTo(messageSendButton.snp.leading)
            make.height.greaterThanOrEqualTo(48)
        }
        
        moreOptionsButton.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(40)
            make.height.equalTo(40)
        }
    }
    
    private func setupActions() {
        backButton.addTarget(self,
                             action: #selector(tappedBackButton(_:)),
                             for: .touchUpInside)
        
        moreOptionsButton.addTarget(self,
                                    action: #selector(tappedMoreOptionsButton(_:)),
                                    for: .touchUpInside)
        
        messageSendButton.addTarget(self,
                                    action: #selector(tappedMessageSendButton(_:)),
                                    for: .touchUpInside)
    }
    
    private func updateSendButtonState() {
        if messageTextView.text.isEmpty || messageTextView.text == "메세지를 입력해보세요" {
            messageSendButton.backgroundColor = .gray
            messageSendButton.isEnabled = false
        } else {
            messageSendButton.backgroundColor = DesignSystemAsset.mainColor.color
            messageSendButton.isEnabled = true
        }
    }
    
    @objc func tappedBackButton(_ sender: UIButton) {
        coordinator?.didFinish()
    }
    
    @objc func tappedMoreOptionsButton(_ sender: UIButton) {
        coordinator?.presentChatRoomModal()
    }
    
    @objc func tappedMessageSendButton(_ sender: UIButton) {
        guard let text = messageTextView.text, !text.isEmpty else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: Date())
        
        if let lastMessage = chatMessageArray.last, lastMessage.time == currentTime {
            chatMessageArray[chatMessageArray.count - 1].isHiddenTimeLabel = true
        }
        
        let newMessage = ChatMessageModel(text: text, messageType: .user, time: currentTime)
        chatMessageArray.append(newMessage)
        chatRoomTableView.reloadData()
        messageTextView.text = ""
        
        showChatHeader = true
        
        // 늘어난 textView 원래크기로 초기화
        UIView.animate(withDuration: 0.2) {
            self.messageTextViewBackground.snp.updateConstraints { make in
                make.height.equalTo(48)
            }
            self.updateSendButtonState()
        }
    }
}

extension ChatRoomViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        chatMessageArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell 분기처리
        let message = chatMessageArray[indexPath.row]
        
        if message.messageType == .user {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: UserChatMessageViewCell.reuseIdentifier,
                for: indexPath
            ) as? UserChatMessageViewCell else { return UITableViewCell() }
            cell.setMessage(message.text, message.time, message.isHiddenTimeLabel)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: PartnerChatMessageViewCell.reuseIdentifier,
                for: indexPath
            ) as? PartnerChatMessageViewCell else { return UITableViewCell() }
            cell.setMessage(message.text, message.time, message.isHiddenTimeLabel)
            return cell
        }
    }
    
}

extension ChatRoomViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let chatHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChatHeaderView.reuseIdentifier) as? ChatHeaderView else {
            return UIView()
        }
        chatHeader.configure(headerType: .today)
        return chatHeader
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return showChatHeader ? 50 : 0
    }
}

extension ChatRoomViewController: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        // textView 타이핑 시 placeHolder 제거
        if textView.textColor == .placeholderText {
            textView.text = nil
            textView.textColor = .label
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        // textView placeHolder가 없어서 이렇게 사용
        if textView.text.isEmpty {
            textView.text = "메세지를 입력해보세요"
            textView.textColor = .placeholderText
        }
        
    }
    
    public func textViewDidChange(_ textView: UITextView) {
        let size = CGSize(width: textView.frame.width, height: .infinity)
        let estimatedSize = textView.sizeThatFits(size)
        
        UIView.animate(withDuration: 0.2) {
            self.messageTextViewBackground.snp.updateConstraints { make in
                make.height.equalTo(max(estimatedSize.height, 48))
            }
            self.view.layoutIfNeeded()
            self.updateSendButtonState()
        }
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // 300자 이상 제한
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        return newText.count <= 300
    }
}



