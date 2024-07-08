//
//  ProfileViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol ProfileViewControllerCoordinator: AnyObject {
    func didTabSettingButton()
}

public final class ProfileViewController: UIViewController {
    // MARK: - Private properties
    private let userName: String
    private let userImage: UIImage
    private let userSchoolName: String
    private let userAge: Int
    private let userLinks: [String]
    private let userMBTI: String
    private let userIntroduce: String
    private let userQuestions: [String: String]
    
    private weak var coordinator: ProfileViewControllerCoordinator?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.white
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "\(userName) 님\n오늘도 좋은 하루 보내세요!"
        label.textColor = UIColor.black
        label.font = .customFont(forTextStyle: .callout, weight: .bold)
        label.numberOfLines = 2

        if let text = label.text {
            let attributeString = NSMutableAttributedString(string: text)
            attributeString.addAttribute(.foregroundColor,
                                         value: DesignSystemAsset.mainColor.color,
                                         range: (text as NSString).range(of: "\(userName)"))
            label.attributedText = attributeString
        }
        return label
    }()
    
    private lazy var updateImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("사진 수정", for: .normal)
        button.setTitleColor(DesignSystemAsset.gray01.color, for: .normal)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: .highlighted)
        button.titleLabel?.font = .customFont(forTextStyle: .footnote, weight: .regular)
        button.isEnabled = true
        return button
    }()
    
    private lazy var userImageContainerView: UIView = {
        let containerView = UIView()
        containerView.addDropYShadow(width: ViewValues.width * 0.2,
                                     height: ViewValues.width * 0.2 * 1.16,
                                     color: UIColor.black,
                                     opacity: 0.25,
                                     radius: 10,
                                     offset: CGSize(width: 2, height: 4))
        return containerView
    }()
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = userImage
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var userInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.gray03.color
        view.clipsToBounds = true
        view.layer.cornerRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.text = userSchoolName
        label.textColor = UIColor.black
        label.font = .customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "\(userAge)세"
        label.textColor = DesignSystemAsset.gray01.color
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var infoSettingButton: UIButton = {
        let button = UIButton()
        // TODO: - 디자인 확정이 나지 않아 SFSymbol 사용 중 : 추후 변경 예정
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = DesignSystemAsset.gray01.color
        button.isEnabled = true
        return button
    }()
    
    private lazy var badgeButtonContainerView: UIView = {
        let view = UIView()
        view.addDropYShadow(width: (ViewValues.width - 48) * 0.5,
                              height: 97,
                              color: UIColor.black,
                              opacity: 0.25,
                              radius: 10,
                              offset: CGSize(width: 2, height: 4))
        return view
    }()
    
    private lazy var badgeButton: CustomProfileBadgeButton = {
        let button = CustomProfileBadgeButton(
            frame: .zero,
            title: "뱃지",
            count: "10개",
            imageType: .badge)
        button.layer.cornerRadius = ViewValues.defaultRadius
        button.clipsToBounds = true
        return button
    }()
    
    private lazy var tournamentButtonContainerView: UIView = {
        let view = UIView()
        view.addDropYShadow(width: (ViewValues.width - 48) * 0.5,
                              height: 97,
                              color: UIColor.black,
                              opacity: 0.25,
                              radius: 10,
                              offset: CGSize(width: 2, height: 4))
        return view
    }()
    
    private lazy var tournamentButton: CustomProfileBadgeButton = {
        let button = CustomProfileBadgeButton(
            frame: .zero,
            title: "Teen",
            count: "5월 2주차 우승",
            imageType: .tournament)
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    private lazy var badgeAndTournamentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [badgeButtonContainerView, tournamentButtonContainerView])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = ViewValues.defaultSpacing
        return stack
    }()
    
    private lazy var divider1 = CustomDivider()
    
    private lazy var linkTitle: UILabel = {
        let label = UILabel()
        label.text = "내 링크"
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var linkRightButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.rightGrayIcon.image, for: .normal)
        button.tintColor = DesignSystemAsset.gray01.color
        return button
    }()
    
    private lazy var linkView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.gray03.color
        view.clipsToBounds = true
        view.layer.cornerRadius = ViewValues.defaultRadius
        // TODO: - 링크 개수에 맞게 버튼 만들어서 sub 에 넣어주기
        return view
    }()
    
    private lazy var linkEmptyText: UILabel = {
        let label = UILabel()
        label.text = "등록된 링크가 없습니다."
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        return label
    }()
    
    private lazy var divider2 = CustomDivider()
    
    private lazy var introduceTitle: UILabel = {
        let label = UILabel()
        label.text = "자기 소개"
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var introduceRightButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.rightGrayIcon.image, for: .normal)
        button.tintColor = DesignSystemAsset.gray01.color
        return button
    }()
    
    private lazy var introduceMBTIView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var introduceMBTI: UILabel = {
        let label = UILabel()
        label.text = userMBTI
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        return label
    }()
    
    private lazy var introduceText: UILabel = {
        let label = UILabel()
        label.text = userIntroduce
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var introduceEmptyText: UILabel = {
        let label = UILabel()
        label.text = "등록된 소개글이 없습니다."
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        return label
    }()
    
    private lazy var divider3 = CustomDivider()
    
    private lazy var questionTitle: UILabel = {
        let label = UILabel()
        label.text = "10문 10답"
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        label.textColor = UIColor.black
        return label
    }()
    
    private lazy var questionRightButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.rightGrayIcon.image, for: .normal)
        button.tintColor = DesignSystemAsset.gray01.color
        return button
    }()
    
    private lazy var questionView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.gray03.color
        view.clipsToBounds = true
        view.layer.cornerRadius = ViewValues.defaultRadius
        // TODO: - 질문/답변 개수에 맞도록..
        return view
    }()
    
    private lazy var questionEmptyText: UILabel = {
        let label = UILabel()
        label.text = "등록된 문답이 없습니다."
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        return label
    }()
    
    private lazy var bottomSpacer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterfaceAndLayout()
        setupActions()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        guard let coordinator = coordinator else { return }
        self.navigationItem.titleView =  CustomNaviView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: ViewValues.width,
                height: 40
            ),
            delegate: coordinator
        )
    }
    
    public init(
        userName: String = "김 에스더",
        userImage: UIImage = DesignSystemAsset.blackGlass.image,
        userSchoolName: String = "서울 중학교",
        userAge: Int = 17,
        userLinks: [String] = ["instagram.link", "instagram.link"],
        userMBTI: String = "INFJ",
        userIntroduce: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        userQuestions: [String: String] = [:],
        coordinator: ProfileViewControllerCoordinator
    ) {
        self.userName = userName
        self.userImage = userImage
        self.userSchoolName = userSchoolName
        self.userAge = userAge
        self.userLinks = userLinks
        self.userMBTI = userMBTI
        self.userIntroduce = userIntroduce
        self.userQuestions = userQuestions
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterfaceAndLayout() {
        view.backgroundColor = UIColor.white
        
        addScrollView()
        
        view.layoutIfNeeded()
        scrollView.contentSize = CGSize(width: view.frame.width,
                                        height: contentView.recursiveUnionInDepthFor(view: self.contentView).height)
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        addContentView()
    }
    
    private func addContentView() {
        scrollView.addSubview(contentView)

        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.bottom.trailing.equalTo(scrollView.frameLayoutGuide)
        }
        
        addContentViewComponents()
    }
    
    private func addContentViewComponents() {
        // 유저 이름, 사진 수정 버튼, 사진
        addUserComponent()
        // 학교, 나이, 수정
        addUserInfoComponent()
        // 배지, TEEN
        addUserBadgeComponent()
        // 내 링크
        addLinkComponent()
        // 자기 소개
        addIntroduceComponent()
        // 10문 10답
        addQuestionComponent()
        //
        addBottomSpacer()
    }
    
    private func addUserComponent() {
        contentView.addSubview(userNameLabel)
        contentView.addSubview(updateImageButton)
        contentView.addSubview(userImageContainerView)
        userImageContainerView.addSubview(userImageView)
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        updateImageButton.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        userImageContainerView.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.top)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.equalTo(ViewValues.width * 0.2)
            make.height.equalTo(userImageView.snp.width).multipliedBy(1.16)
        }
        
        userImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func addUserInfoComponent() {
        contentView.addSubview(userInfoView)
        userInfoView.addSubview(schoolLabel)
        userInfoView.addSubview(ageLabel)
        userInfoView.addSubview(infoSettingButton)
        
        userInfoView.snp.makeConstraints { make in
            make.top.equalTo(userImageView.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        schoolLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(schoolLabel.snp.bottom).offset(2)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        infoSettingButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.height.equalTo(24)
        }
    }
    
    private func addUserBadgeComponent() {
        badgeButtonContainerView.addSubview(badgeButton)
        tournamentButtonContainerView.addSubview(tournamentButton)
        
        badgeButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tournamentButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.addSubview(badgeAndTournamentStack)
        
        badgeAndTournamentStack.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(97)
        }
    }
    
    private func addLinkComponent() {
        contentView.addSubview(divider1)
        contentView.addSubview(linkTitle)
        contentView.addSubview(linkRightButton)
        if userLinks.count == 0 {
            contentView.addSubview(linkEmptyText)
        } else {
            contentView.addSubview(linkView)
        }
        
        divider1.snp.makeConstraints { make in
            make.top.equalTo(badgeAndTournamentStack.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview()
        }
        
        linkTitle.snp.makeConstraints { make in
            make.top.equalTo(divider1.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        linkRightButton.snp.makeConstraints { make in
            make.centerY.equalTo(linkTitle.snp.centerY)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.height.equalTo(24)
        }
        
        if userLinks.count == 0 {
            linkEmptyText.snp.makeConstraints { make in
                make.top.equalTo(linkTitle.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            }
        } else {
            linkView.snp.makeConstraints { make in
                make.top.equalTo(linkTitle.snp.bottom).offset(22)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                // TODO: - 삭제 예정
                make.height.equalTo(100)
            }
        }
    }
    
    private func addIntroduceComponent() {
        contentView.addSubview(divider2)
        contentView.addSubview(introduceTitle)
        contentView.addSubview(introduceRightButton)
        contentView.addSubview(introduceMBTIView)
        introduceMBTIView.addSubview(introduceMBTI)
        if userIntroduce == "" {
            contentView.addSubview(introduceEmptyText)
        } else {
            contentView.addSubview(introduceText)
        }
        
        divider2.snp.makeConstraints { make in
            if userLinks.count == 0 {
                make.top.equalTo(linkEmptyText.snp.bottom).offset(40)
            } else {
                make.top.equalTo(linkView.snp.bottom).offset(40)
            }
            make.leading.trailing.equalToSuperview()
        }
        
        introduceTitle.snp.makeConstraints { make in
            make.top.equalTo(divider2.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        introduceRightButton.snp.makeConstraints { make in
            make.centerY.equalTo(introduceTitle.snp.centerY)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        introduceMBTIView.snp.makeConstraints { make in
            make.top.equalTo(introduceTitle.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        introduceMBTI.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.equalToSuperview().offset(23)
            make.bottom.equalToSuperview().offset(-5)
            make.trailing.equalToSuperview().offset(-23)
        }
        
        if userIntroduce == "" {
            introduceEmptyText.snp.makeConstraints { make in
                make.top.equalTo(introduceMBTIView.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            }
        } else {
            introduceText.snp.makeConstraints { make in
                make.top.equalTo(introduceMBTIView.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            }
        }
    }
    
    private func addQuestionComponent() {
        contentView.addSubview(divider3)
        contentView.addSubview(questionTitle)
        contentView.addSubview(questionRightButton)
        if userQuestions.count == 0 {
            contentView.addSubview(questionEmptyText)
        } else {
            contentView.addSubview(questionView)
        }
        
        divider3.snp.makeConstraints { make in
            if userIntroduce == "" {
                make.top.equalTo(introduceEmptyText.snp.bottom).offset(40)
            } else {
                make.top.equalTo(introduceText.snp.bottom).offset(40)
            }
            make.leading.trailing.equalToSuperview()
        }
        
        questionTitle.snp.makeConstraints { make in
            make.top.equalTo(divider3.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }

        questionRightButton.snp.makeConstraints { make in
            make.centerY.equalTo(questionTitle.snp.centerY)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }

        if userQuestions.count == 0 {
            questionEmptyText.snp.makeConstraints { make in
                make.top.equalTo(questionTitle.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            }
        } else {
            questionView.snp.makeConstraints { make in
                make.top.equalTo(questionTitle.snp.bottom).offset(22)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                // TODO: - 삭제 예정
                make.height.equalTo(100)
            }
        }
    }
    
    private func addBottomSpacer() {
        contentView.addSubview(bottomSpacer)
        
        bottomSpacer.snp.makeConstraints { make in
            if userQuestions.count == 0 {
                make.top.equalTo(questionEmptyText.snp.bottom)
            } else {
                make.top.equalTo(questionEmptyText.snp.bottom)
            }
            make.width.equalTo(ViewValues.width)
            make.height.equalTo(40)
        }
    }

    private func setupActions() {
        updateImageButton.addTarget(
            self,
            action: #selector(clickUpdateImageButton(_:)),
            for: .touchUpInside)
        infoSettingButton.addTarget(
            self,
            action: #selector(clickSettingsButton(_:)),
            for: .touchUpInside)
        badgeButton.addTarget(
            self,
            action: #selector(clickBadgeButton(_:)),
            for: .touchUpInside)
        tournamentButton.addTarget(
            self,
            action: #selector(clickTournamentButton(_:)),
            for: .touchUpInside)
        linkRightButton.addTarget(
            self,
            action: #selector(clickMoreLinkButton(_:)),
            for: .touchUpInside)
        introduceRightButton.addTarget(
            self,
            action: #selector(clickMoreIntroduceButton(_:)),
            for: .touchUpInside)
        questionRightButton.addTarget(
            self,
            action: #selector(clickMoreQuestionButton(_:)),
            for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func clickUpdateImageButton(_ sender: UIButton) {
        print("사진 수정 버튼 클릭")
    }
    
    @objc private func clickSettingsButton(_ sender: UIButton) {
        print("세팅 아이콘 버튼 클릭")
    }
    
    @objc private func clickBadgeButton(_ sender: UIButton) {
        print("배지 버튼 클릭")
    }
    
    @objc private func clickTournamentButton(_ sender: UIButton) {
        print("토너먼트 버튼 클릭")
    }
    
    @objc private func clickMoreLinkButton(_ sender: UIButton) {
        print("내 링크 > 버튼 클릭")
    }
    
    @objc private func clickMoreIntroduceButton(_ sender: UIButton) {
        print("자기 소개 > 버튼 클릭")
    }
    
    @objc private func clickMoreQuestionButton(_ sender: UIButton) {
        print("10문 10답 > 버튼 클릭")
    }
}

// MARK: - Extensions here
