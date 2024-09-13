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
    func didTapBackButton()
    func didTapOptionButton()
    func didTapOperatingPolicyButton()
}

public final class ChatRoomViewController: UIViewController {
    // MARK: - Private properties
    var userMessageArray: [ChatMessageModel] = []
    var partnerMessageArray: [ChatMessageModel] = []
    var partnerName: String
    var showChatHeader = false
    weak var coordinator: ChatRoomViewControllerCoordinator?
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    private lazy var chatRoomTableViewHeader: ChatHeaderView = {
        let headerView = ChatHeaderView(reuseIdentifier: ChatHeaderView.reuseIdentifier)
        headerView.configure(headerType: .today)
        
        return headerView
    }()
    
    private lazy var chatRoomTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.register(PartnerChatMessageTableViewCell.self, forCellReuseIdentifier: PartnerChatMessageTableViewCell.reuseIdentifier)
        tableView.register(UserChatMessageTableViewCell.self, forCellReuseIdentifier: UserChatMessageTableViewCell.reuseIdentifier)
        tableView.register(ChatRoomWarningTableViewCell.self, forCellReuseIdentifier: ChatRoomWarningTableViewCell.reuseIdentifier)
        
        return tableView
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
    
    // MARK: - Life Cycle
    public init(partnerName: String, coordinator: ChatRoomViewControllerCoordinator) {
        self.partnerName = partnerName
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.chatPartnerNameLabel.text = partnerName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        configUserInterface()
        configLayout()
        setupActions()
    }
    

    
    // MARK: - Helpers
    public override func viewWillAppear(_ animated: Bool) {
        coordinator?.configTabbarState(view: .chatRoom)
    }
    
    private func configUserInterface() {
        view.addSubview(chatRoomTableView)
        view.addSubview(headerBackground)
        view.addSubview(messageTextViewBackground)
        chatRoomTableView.addSubview(chatRoomTableViewHeader)
        headerBackground.addSubview(chatPartnerNameLabel)
        headerBackground.addSubview(backButton)
        headerBackground.addSubview(moreOptionsButton)
        messageTextViewBackground.addSubview(messageSendButton)
        messageTextViewBackground.addSubview(messageTextView)
    }
    
    private func configLayout() {
        chatRoomTableView.snp.makeConstraints { make in
            make.top.equalTo(headerBackground.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(messageTextView.snp.top).offset(-20)
        }
        
        headerBackground.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(ViewValues.height * 0.13)
        }
        
        messageTextViewBackground.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-54)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(48)
        }
        
        chatRoomTableViewHeader.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        chatPartnerNameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.centerX.equalToSuperview()
            make.height.equalTo(28)
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ViewValues.height * 0.07)
            make.leading.equalToSuperview().offset(21)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
        moreOptionsButton.snp.makeConstraints { make in
            make.centerY.equalTo(backButton)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(40)
            make.height.equalTo(40)
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
    
    private func scrollToBottom() {
        let lastSection = chatRoomTableView.numberOfSections - 1
        let lastRow = chatRoomTableView.numberOfRows(inSection: lastSection) - 1
        
        if lastSection >= 0 && lastRow >= 0 {
            let indexPath = IndexPath(row: lastRow, section: lastSection)
            chatRoomTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        }
    }
    
    // MARK: - Actions
    @objc func tappedBackButton(_ sender: UIButton) {
        coordinator?.didTapBackButton()
    }
    
    @objc func tappedMoreOptionsButton(_ sender: UIButton) {
        coordinator?.didTapOptionButton()
    }
    
    @objc func tappedMessageSendButton(_ sender: UIButton) {
        guard let text = messageTextView.text, !text.isEmpty else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let currentTime = dateFormatter.string(from: Date())
        
        // 채팅입력 시간 전 채팅과 같으면 timeLabel 출력x
        if let lastMessage = userMessageArray.last, lastMessage.time == currentTime {
            userMessageArray[userMessageArray.count - 1].isHiddenTimeLabel = true
        }
        
        let newMessage = ChatMessageModel(text: text, messageType: .user, time: currentTime)
        userMessageArray.append(newMessage)
        
        UIView.setAnimationsEnabled(false)
        
        // 테이블 뷰 업데이트
        let newIndexPath = IndexPath(row: userMessageArray.count - 1, section: 1)
        chatRoomTableView.insertRows(at: [newIndexPath], with: .none)
        chatRoomTableView.reloadData()
        scrollToBottom()
        
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

// MARK: - Extensions here
extension ChatRoomViewController: UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2  // 경고문 섹션과 채팅 메시지 섹션
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1  // 경고문 섹션
        case 1:
            return userMessageArray.count + partnerMessageArray.count // 채팅 메시지 섹션
        default:
            return 0
        }
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell 분기처리
        switch indexPath.section {
        case 0:
            // 경고문 셀 처리
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ChatRoomWarningTableViewCell.reuseIdentifier,
                for: indexPath
            ) as? ChatRoomWarningTableViewCell else { return UITableViewCell() }
            
            cell.operatingPolicyButtonButtonAction = { [weak self] in
                guard let self = self else { return }
                self.coordinator?.didTapOperatingPolicyButton()
            }
            
            cell.selectionStyle = .none
            cell.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 150)
            cell.layoutIfNeeded()
            
            return cell
            
        case 1:
            // 채팅 메시지 셀 처리
            let message = userMessageArray[indexPath.row]
            
            if message.messageType == .user {
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: UserChatMessageTableViewCell.reuseIdentifier,
                    for: indexPath
                ) as? UserChatMessageTableViewCell else { return UITableViewCell() }
                cell.setMessage(message.text,
                                message.time,
                                message.isHiddenTimeLabel)
                cell.selectionStyle = .none
                
                return cell
            } else {
                let message = partnerMessageArray[indexPath.row]
                
                guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: PartnerChatMessageTableViewCell.reuseIdentifier,
                    for: indexPath
                ) as? PartnerChatMessageTableViewCell else { return UITableViewCell() }
                
                let isHiddenProfileImage = indexPath.row > 0 &&
                partnerMessageArray[indexPath.row - 1].messageType == .partner &&
                partnerMessageArray[indexPath.row - 1].time == message.time
                
                cell.setMessage(message.text,
                                time: message.time,
                                isHiddenTimeLabel: message.isHiddenTimeLabel,
                                isHiddenProfileImage: isHiddenProfileImage)
                
                cell.selectionStyle = .none
                
                return cell
            }
            
        default:
            return UITableViewCell()
        }
    }
}


extension ChatRoomViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150 // 경고 셀의 높이
        }
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // tableView 헤더 설정
        guard let chatHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: ChatHeaderView.reuseIdentifier) as? ChatHeaderView else {
            return UIView()
        }
        chatHeader.configure(headerType: .today)
        return chatHeader
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // chatRoomWarningTableViewCell 밑에서부터 채팅Cell 나와야해서 높이 조절
        return section == 0 ? 30 : 90
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
        // textView 길이 길어져서 줄바꿈 됐을때 textView 크기 늘어남
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

extension UIButton {
    // 버튼 언더라인 만들기
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttribute(.underlineStyle,
                                      value: NSUnderlineStyle.single.rawValue,
                                      range: NSRange(location: 0, length: title.count)
        )
        setAttributedTitle(attributedString, for: .normal)
    }
}

