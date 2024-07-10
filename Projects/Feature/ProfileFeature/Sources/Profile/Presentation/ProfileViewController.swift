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
    
    let questionList: [Question] = [
        .init(
            title: "Lorem ipsum dolor sit amet?",
            text: """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            """),
        .init(
            title: "Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet?",
            text: """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            """),
    ]
    
    var backgroundViewHeightAnchor: Constraint?
    var informationViewHeightAnchor: Constraint?
    var linkBackViewHeightAnchor: Constraint?
    var introduceViewHeightAnchor: Constraint?
    var questionViewHeightAnchor: Constraint?
    var questionTextViewHeightAnchor: Constraint?
    
    private weak var coordinator: ProfileViewControllerCoordinator?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.systemBackground
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        return scrollView
    }()
    
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var informationView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
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
            attributeString.addAttribute(
                .foregroundColor,
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
        containerView.addDropYShadow(
            width: ViewValues.width * 0.2,
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
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .callout, weight: .regular)
        return label
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.text = "\(userAge)세"
        label.textColor = DesignSystemAsset.gray01.color
        label.textAlignment = .left
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
        view.addDropYShadow(
            width: (ViewValues.width - 48) * 0.5,
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
        view.addDropYShadow(
            width: (ViewValues.width - 48) * 0.5,
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
    
    private lazy var linkBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var linkTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "내 링크"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
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
    
    private lazy var linkEmptyTextLabel: UILabel = {
        let label = UILabel()
        label.text = "등록된 링크가 없습니다."
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        return label
    }()
    
    private lazy var divider2 = CustomDivider()
    
    private lazy var introduceView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var introduceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "자기 소개"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = .customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    private lazy var introduceRightButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.rightGrayIcon.image, for: .normal)
        button.tintColor = DesignSystemAsset.gray01.color
        return button
    }()
    
    private lazy var introduceMbtiView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var introduceMbtiLabel: UILabel = {
        let label = UILabel()
        label.text = userMBTI
        label.textColor = DesignSystemAsset.gray02.color
        label.textAlignment = .center
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var introduceTextLabel: UILabel = {
        let label = UILabel()
        label.text = userIntroduce
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var introduceEmptyTextLabel: UILabel = {
        let label = UILabel()
        label.text = "등록된 소개글이 없습니다."
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        return label
    }()
    
    private lazy var divider3 = CustomDivider()
    
    private lazy var questionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        return view
    }()
    
    private lazy var questionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "10문 10답"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    private lazy var questionRightButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.rightGrayIcon.image, for: .normal)
        button.tintColor = DesignSystemAsset.gray01.color
        return button
    }()
    
    private lazy var questionTextView: CustomQuestionView = {
        let view = CustomQuestionView(frame: .zero, questionList: self.questionList)
        return view
    }()
    
    private lazy var questionEmptyTextLabel: UILabel = {
        let label = UILabel()
        label.text = "등록된 문답이 없습니다."
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        return label
    }()
    
    lazy var moreBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.gray03.color
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        return view
    }()
    
    lazy var moreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.moreIcon.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("펼쳐서 보기", for: .normal)
        button.setTitleColor(DesignSystemAsset.gray02.color, for: .normal)
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return button
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
        coordinator: ProfileViewControllerCoordinator
    ) {
        self.userName = userName
        self.userImage = userImage
        self.userSchoolName = userSchoolName
        self.userAge = userAge
        self.userLinks = userLinks
        self.userMBTI = userMBTI
        self.userIntroduce = userIntroduce
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
    }
    
    private func addScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in            
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        addBackgroundView()
        
        self.view.layoutIfNeeded()
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.backgroundView.frame.height)
    }
    
    private func addBackgroundView() {
        scrollView.addSubview(backgroundView)

        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(self.scrollView.frameLayoutGuide)
            self.backgroundViewHeightAnchor = make.height.equalTo(self.view.frame.height).constraint
        }
        
        addBackgroudViewComponents()
        
        self.view.layoutIfNeeded()
        
        self.backgroundViewHeightAnchor?.update(offset: self.informationView.frame.height + self.linkBackView.frame.height + self.introduceView.frame.height + self.questionView.frame.height + 21)
    }
    
    private func addBackgroudViewComponents() {
        // 유저 이름, 사진 수정 버튼, 사진, 학교, 나이, 수정, 배지, TEEN
        addInfomationViewComponent()
        // 내 링크
        addLinkComponent()
        // 자기 소개
        addIntroduceComponent()
        // 10문 10답
        addQuestionComponent()
    }
    
    private func addInfomationViewComponent() {
        backgroundView.addSubview(informationView)
        
        informationView.addSubview(userImageContainerView)
        informationView.addSubview(userNameLabel)
        informationView.addSubview(updateImageButton)
        
        userImageContainerView.addSubview(userImageView)
        
        informationView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            self.informationViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        userImageContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.equalTo(ViewValues.width * 0.2)
            make.height.equalTo(userImageView.snp.width).multipliedBy(1.16)
        }
        
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(userImageContainerView.snp.leading).offset(-ViewValues.defaultPadding)
        }
        
        updateImageButton.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.bottom.equalTo(userImageContainerView.snp.bottom)
            make.width.equalTo(49)
        }
        
        userImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addUserInfoComponent()
    }
    
    private func addUserInfoComponent() {
        informationView.addSubview(userInfoView)
        
        userInfoView.addSubview(infoSettingButton)
        userInfoView.addSubview(schoolLabel)
        userInfoView.addSubview(ageLabel)
        
        userInfoView.snp.makeConstraints { make in
            make.top.equalTo(userImageContainerView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(74)
        }
        
        infoSettingButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.height.equalTo(24)
        }
        
        schoolLabel.snp.makeConstraints { make in
            make.bottom.equalTo(userInfoView.snp.centerY).offset(-1)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(infoSettingButton.snp.leading).offset(-ViewValues.defaultPadding)
        }
        
        ageLabel.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.centerY).offset(1)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(infoSettingButton.snp.leading).offset(-ViewValues.defaultPadding)
        }
        
        addUserBadgeComponent()
    }
    
    private func addUserBadgeComponent() {
        informationView.addSubview(badgeAndTournamentStack)
        
        badgeButtonContainerView.addSubview(badgeButton)
        tournamentButtonContainerView.addSubview(tournamentButton)
        
        badgeButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tournamentButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        badgeAndTournamentStack.snp.makeConstraints { make in
            make.top.equalTo(userInfoView.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(97)
        }
        
        self.view.layoutIfNeeded()
        informationViewHeightAnchor?.update(
            offset: userImageContainerView.frame.height + userInfoView.frame.height + badgeAndTournamentStack.frame.height + 95)
    }
    
    private func addLinkComponent() {
        backgroundView.addSubview(divider1)
        backgroundView.addSubview(linkBackView)
        
        linkBackView.addSubview(linkRightButton)
        linkBackView.addSubview(linkTitleLabel)
        
        if userLinks.count == 0 {
            linkBackView.addSubview(linkEmptyTextLabel)
        } else {
            linkBackView.addSubview(linkView)
        }
        
        divider1.snp.makeConstraints { make in
            make.top.equalTo(informationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        linkBackView.snp.makeConstraints { make in
            make.top.equalTo(divider1.snp.bottom)
            make.leading.trailing.equalToSuperview()
            self.linkBackViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        linkRightButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(39)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.height.equalTo(24)
        }
        
        linkTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(39)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(linkRightButton.snp.leading).offset(-ViewValues.defaultPadding)
            make.height.equalTo(24)
        }
        
        if userLinks.count == 0 {
            linkEmptyTextLabel.snp.makeConstraints { make in
                make.top.equalTo(linkTitleLabel.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            }
            
            self.view.layoutIfNeeded()
            
            self.linkBackViewHeightAnchor?.update(
                offset: linkTitleLabel.frame.height + linkEmptyTextLabel.frame.height + 88)
            
        } else {
            linkView.snp.makeConstraints { make in
                make.top.equalTo(linkTitleLabel.snp.bottom).offset(22)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                // TODO: - 삭제 예정
                make.height.equalTo(100)
            }
            
            self.view.layoutIfNeeded()
            
            self.linkBackViewHeightAnchor?.update(
                offset: linkTitleLabel.frame.height + linkView.frame.height + 100)
        }
    }
    
    private func addIntroduceComponent() {
        backgroundView.addSubview(divider2)
        backgroundView.addSubview(introduceView)
        
        introduceView.addSubview(introduceRightButton)
        introduceView.addSubview(introduceTitleLabel)
        introduceView.addSubview(introduceMbtiView)
        
        if userIntroduce == "" {
            introduceView.addSubview(introduceEmptyTextLabel)
        } else {
            introduceView.addSubview(introduceTextLabel)
        }
        
        introduceMbtiView.addSubview(introduceMbtiLabel)
        
        divider2.snp.makeConstraints { make in
            make.top.equalTo(linkBackView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        introduceView.snp.makeConstraints { make in
            make.top.equalTo(divider2.snp.bottom)
            make.leading.trailing.equalToSuperview()
            self.introduceViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        introduceRightButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(39)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.height.equalTo(24)
        }
        
        introduceTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(39)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(introduceRightButton.snp.leading).offset(-ViewValues.defaultPadding)
            make.height.equalTo(24)
        }
        
        introduceMbtiView.snp.makeConstraints { make in
            make.top.equalTo(introduceTitleLabel.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.width.equalTo(74)
            make.height.equalTo(26)
        }
        
        introduceMbtiLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if userIntroduce == "" {
            introduceEmptyTextLabel.snp.makeConstraints { make in
                make.top.equalTo(introduceMbtiView.snp.bottom).offset(7)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            }
            
            self.view.layoutIfNeeded()
            
            self.introduceViewHeightAnchor?.update(
                offset: introduceTitleLabel.frame.height + introduceMbtiView.frame.height + introduceEmptyTextLabel.frame.height + 102)
        } else {
            introduceTextLabel.snp.makeConstraints { make in
                make.top.equalTo(introduceMbtiView.snp.bottom).offset(7)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            }
            
            self.view.layoutIfNeeded()
            
            self.introduceViewHeightAnchor?.update(
                offset: introduceTitleLabel.frame.height + introduceMbtiView.frame.height + introduceTextLabel.frame.height + 102)
        }
    }
    
    private func addQuestionComponent() {
        backgroundView.addSubview(divider3)
        backgroundView.addSubview(questionView)
        
        questionView.addSubview(questionRightButton)
        questionView.addSubview(questionTitleLabel)
        
        if questionList.count == 0 {
            questionView.addSubview(questionEmptyTextLabel)
        } else {
            questionView.addSubview(questionTextView)
        }
        
        divider3.snp.makeConstraints { make in
            make.top.equalTo(introduceView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        questionView.snp.makeConstraints { make in
            make.top.equalTo(self.divider3.snp.bottom)
            make.leading.trailing.equalToSuperview()
            self.questionViewHeightAnchor = make.height.equalTo(0).constraint
        }

        questionRightButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(39)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.width.height.equalTo(24)
        }
        
        questionTitleLabel.snp.makeConstraints { make in
            //피그마 높이 왜 뒤죽박죽임...? 일단 위에랑 똑같이 해놨음
            make.top.equalToSuperview().offset(39)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(introduceRightButton.snp.leading).offset(-ViewValues.defaultPadding)
            make.height.equalTo(24)
        }

        if questionList.count == 0 {
            questionEmptyTextLabel.snp.makeConstraints { make in
                make.top.equalTo(questionTitleLabel.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            }
            
            self.view.layoutIfNeeded()

            self.questionViewHeightAnchor?.update(offset: questionTitleLabel.frame.height + questionEmptyTextLabel.frame.height + 129)
        } else {
            self.view.layoutIfNeeded()
            
            let height = questionTextView.oneTitleLabel.frame.height + questionTextView.oneTextLabel.frame.height + questionTextView.twoTitleLabel.frame.height + questionTextView.twoTextLabel.frame.height
            
            questionTextView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                make.top.equalTo(self.questionTitleLabel.snp.bottom).offset(22)
                if self.questionList.count > 2 {
                    self.questionTextViewHeightAnchor = make.height.equalTo(height + 44).constraint
                } else {
                    self.questionTextViewHeightAnchor = make.height.equalTo(height + 59).constraint
                }
            }
            
            self.view.layoutIfNeeded()
            
            if self.questionList.count > 2 {
                self.questionViewHeightAnchor?.update(offset: questionTitleLabel.frame.height + questionTextView.frame.height + 210)
                
                addMoreBackgroundViewComponentView()
            } else {
                self.questionViewHeightAnchor?.update(offset: questionTitleLabel.frame.height + questionTextView.frame.height + 130)
            }
        }
    }
    
    private func addMoreBackgroundViewComponentView() {
        questionView.addSubview(moreBackgroundView)
        
        moreBackgroundView.addSubview(moreImageView)
        moreBackgroundView.addSubview(moreButton)
        
        moreBackgroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.questionTextView.snp.bottom)
            make.height.equalTo(80)
        }
        
        moreImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(3)
            make.height.equalTo(15)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.moreImageView.snp.bottom).offset(13)
            make.width.equalTo(65)
            make.height.equalTo(17)
        }
    }
    
    private func addAddBackgroundComponentView() {
        questionView.addSubview(moreBackgroundView)
        
        moreBackgroundView.addSubview(moreImageView)
        moreBackgroundView.addSubview(moreButton)
        
        moreBackgroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.questionTextView.snp.bottom)
            make.height.equalTo(80)
        }
        
        moreImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            make.width.equalTo(3)
            make.height.equalTo(15)
        }
        
        moreButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.moreImageView.snp.bottom).offset(13)
            make.width.equalTo(65)
            make.height.equalTo(17)
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
        moreButton.addTarget(self, action: #selector(clickMoreBottomButton(_:)), for: .touchUpInside)
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
    
    @objc private func clickMoreBottomButton(_ sender: UIButton) {
        moreButtonAnimation(sender)
    }

}

// MARK: - Animation
extension ProfileViewController {
    func moreButtonAnimation(_ sender: UIButton) {
        if sender.titleLabel?.text == "펼쳐서 보기" {
            UIView.animate(withDuration: 0.3, delay: 0, options: .showHideTransitionViews) {
                self.questionTextViewHeightAnchor?.update(offset: self.questionTextView.recursiveUnionInDepthFor(view: self.questionTextView).height + 15)
                
                self.view.layoutIfNeeded()
                self.questionViewHeightAnchor?.update(offset: self.questionTitleLabel.frame.height + self.questionTextView.frame.height + 210)
                
                self.view.layoutIfNeeded()
                self.backgroundViewHeightAnchor?.update(offset: self.informationView.frame.height + self.linkBackView.frame.height + self.introduceView.frame.height + self.questionView.frame.height + 21)
                
                self.view.layoutIfNeeded()
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.backgroundView.frame.height)
                
                sender.setTitle("접기", for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .showHideTransitionViews) {
                self.view.layoutIfNeeded()
                let originHeight = self.questionTextView.oneTitleLabel.frame.height + self.questionTextView.oneTextLabel.frame.height + self.questionTextView.twoTitleLabel.frame.height + self.questionTextView.twoTextLabel.frame.height + 44

                self.questionTextViewHeightAnchor?.update(offset: originHeight)
                
                self.view.layoutIfNeeded()
                self.questionViewHeightAnchor?.update(offset: self.questionTitleLabel.frame.height + self.questionTextView.frame.height + 210)
                
                self.view.layoutIfNeeded()
                self.backgroundViewHeightAnchor?.update(offset: self.informationView.frame.height + self.linkBackView.frame.height + self.introduceView.frame.height + self.questionView.frame.height + 21)
                
                self.view.layoutIfNeeded()
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.backgroundView.frame.height)
                
                sender.setTitle("펼쳐서 보기", for: .normal)
            }
        }
    }
}
