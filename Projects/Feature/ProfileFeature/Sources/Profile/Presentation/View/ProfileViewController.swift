//
//  ProfileViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/23/24.
//

import SnapKit

import Common
import DesignSystem
import Domain
import UIKit

public protocol ProfileViewControllerCoordinator: AnyObject {
    func didTabSettingButton()
    func didTabEditMyPhotoButton()
    func didTabEditUserNameButton()
    func didTabSchoolButton()
    func didTabBadgeButton()
    func didTabLinkButton()
    func didTabIntroduceButton()
    func didTabQuestionButton()
    func configTabbarState(view: ProfileFeatureViewNames)
}

public protocol ProfileViewControllerDelegate: AnyObject {
    func didTabBackButtonFromLinksDialogViewController()
    func didTabBackButtonFromQuestionsViewController(user: MyPageData)
}

public final class ProfileViewController: UIViewController {
    // MARK: - Private properties
    var backgroundViewHeightAnchor: Constraint?
    var informationViewHeightAnchor: Constraint?
    var linkBackViewHeightAnchor: Constraint?
    var introduceViewHeightAnchor: Constraint?
    var questionViewHeightAnchor: Constraint?
    var questionTextViewHeightAnchor: Constraint?
    
    private var viewModel: ProfileViewModel
    private weak var coordinator: ProfileViewControllerCoordinator?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.systemBackground
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = true
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 80, right: 0)
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
        label.text = "\(viewModel.user.nickName) 님\n오늘도 좋은 하루 보내세요!"
        label.textColor = UIColor.black
        label.font = .customFont(forTextStyle: .body, weight: .bold)
        label.numberOfLines = 2

        if let text = label.text {
            let attributeString = NSMutableAttributedString(string: text)
            attributeString.addAttribute(
                .foregroundColor,
                value: DesignSystemAsset.mainColor.color,
                range: (text as NSString).range(of: "\(viewModel.user.nickName)"))
            label.attributedText = attributeString
        }
        return label
    }()
    
    private lazy var editImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("사진 수정", for: .normal)
        button.setTitleColor(DesignSystemAsset.gray01.color, for: .normal)
        button.setTitleColor(UIColor.black.withAlphaComponent(0.2), for: .highlighted)
        button.titleLabel?.font = .customFont(forTextStyle: .footnote, weight: .regular)
        button.isEnabled = true
        return button
    }()
    
    private lazy var editUserNameButton: UIButton = {
        let button = UIButton()
        button.setTitle("닉네임 수정", for: .normal)
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
        // TODO: 나중에 이미지 url로 바꾸기
        imageView.image = DesignSystemAsset.blackGlass.image
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private lazy var schoolButton: CustomSchoolButton = {
        let button = CustomSchoolButton(
            frame: .zero,
            schoolName: viewModel.user.schoolName,
            age: viewModel.getUserAge())
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
        view.backgroundColor = UIColor.clear
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
    
    private lazy var linkView: CustomLinkView = {
        let view = CustomLinkView(frame: .zero, linkList: viewModel.filterLinks)
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
        view.backgroundColor = UIColor.clear
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
        view.backgroundColor = DesignSystemAsset.gray03.color
        view.clipsToBounds = true
        view.layer.cornerRadius = 10
        return view
    }()
    
    private lazy var introduceMbtiLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.user.mbti
        label.textColor = DesignSystemAsset.gray02.color
        label.textAlignment = .center
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var introduceTextLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.user.introduction
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
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private lazy var questionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "자문자답"
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
        let view = CustomQuestionView(frame: .zero, questionList: viewModel.user.questions)
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
        viewModel.getMyPageData { [weak self] result in
            guard let self = self else { return }
            if result {
                DispatchQueue.main.async {
                    self.configUserInterfaceAndLayout()
                    self.setupActions()
                }
            }
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        guard let coordinator = coordinator else { return }
        coordinator.configTabbarState(view: .profile)
        self.navigationItem.titleView = CustomNaviView(
            frame: CGRect(x: 0, y: 0, width: ViewValues.width, height: 40
            ),
            delegate: coordinator
        )
    }
    
    public init(
        viewModel: ProfileViewModel,
        coordinator: ProfileViewControllerCoordinator
    ) {
        self.viewModel = viewModel
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
        informationView.addSubview(editImageButton)
        informationView.addSubview(editUserNameButton)
        
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
        
        editImageButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.bottom.equalTo(userImageContainerView.snp.bottom)
            make.width.equalTo(49)
        }
        
        editUserNameButton.snp.makeConstraints { make in
            make.leading.equalTo(editImageButton.snp.trailing).offset(13)
            make.bottom.equalTo(userImageContainerView.snp.bottom)
            make.width.equalTo(60)
        }
        
        userImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addUserInfoComponent()
    }
    
    private func addUserInfoComponent() {
        informationView.addSubview(schoolButton)
        
        schoolButton.snp.makeConstraints { make in
            make.top.equalTo(userImageContainerView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(74)
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
            make.top.equalTo(schoolButton.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(97)
        }
        
        self.view.layoutIfNeeded()
        informationViewHeightAnchor?.update(
            offset: userImageContainerView.frame.height + schoolButton.frame.height + badgeAndTournamentStack.frame.height + 95)
    }
    
    private func addLinkComponent() {
        backgroundView.addSubview(divider1)
        backgroundView.addSubview(linkBackView)
        
        linkBackView.addSubview(linkRightButton)
        linkBackView.addSubview(linkTitleLabel)
        
        if viewModel.filterLinks.isEmpty {
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
        
        addLinkView(count: viewModel.filterLinks.count)
    }
    
    private func addLinkView(count: Int) {
        if count == 0 {
            if self.linkEmptyTextLabel.superview == nil {
                self.linkBackView.addSubview(self.linkEmptyTextLabel)
            }
            
            linkEmptyTextLabel.snp.makeConstraints { make in
                make.top.equalTo(linkTitleLabel.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            }
            
            self.view.layoutIfNeeded()
            
            self.linkBackViewHeightAnchor?.update(
                offset: linkTitleLabel.frame.height + linkEmptyTextLabel.frame.height + 88)
        } else {
            if self.linkView.superview == nil {
                self.linkBackView.addSubview(self.linkView)
            }
            
            self.view.layoutIfNeeded()
            
            let linkHeight = Int(self.linkView.oneLinkImageView.frame.height) * count
            let linkPadding = (count - 1) * 28

            self.linkView.snp.makeConstraints { make in
                make.top.equalTo(self.linkTitleLabel.snp.bottom).offset(22)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                make.height.equalTo(linkHeight + linkPadding + 36)
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
        
        if viewModel.user.introduction == nil {
            introduceView.addSubview(introduceEmptyTextLabel)
        } else {
            introduceView.addSubview(introduceTextLabel)
        }
        
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
            
            if viewModel.user.mbti == nil {
                make.height.equalTo(0)
            } else {
                make.height.equalTo(26)
            }
        }
        
        if viewModel.user.mbti != nil {
            introduceMbtiView.addSubview(introduceMbtiLabel)
            
            introduceMbtiLabel.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
        
        if viewModel.user.introduction == nil {
            introduceEmptyTextLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                
                if viewModel.user.mbti == nil {
                    make.top.equalTo(introduceTitleLabel.snp.bottom).offset(ViewValues.defaultPadding)
                } else {
                    make.top.equalTo(introduceMbtiView.snp.bottom).offset(7)
                }
            }
            
            self.view.layoutIfNeeded()
            
            self.introduceViewHeightAnchor?.update(
                offset: introduceTitleLabel.frame.height + introduceMbtiView.frame.height + introduceEmptyTextLabel.frame.height + 102)
        } else {
            introduceTextLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                
                if viewModel.user.mbti == nil {
                    make.top.equalTo(introduceTitleLabel.snp.bottom).offset(ViewValues.defaultPadding)
                } else {
                    make.top.equalTo(introduceMbtiView.snp.bottom).offset(7)
                }
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
            make.top.equalToSuperview().offset(39)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalTo(introduceRightButton.snp.leading).offset(-ViewValues.defaultPadding)
            make.height.equalTo(24)
        }

        addQuestionTextView()
    }
    
    private func addQuestionTextView() {
        if viewModel.user.questions.isEmpty {
            questionView.addSubview(questionEmptyTextLabel)
            
            questionEmptyTextLabel.snp.makeConstraints { make in
                make.top.equalTo(questionTitleLabel.snp.bottom).offset(10)
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            }
            
            self.view.layoutIfNeeded()

            self.questionViewHeightAnchor?.update(offset: questionTitleLabel.frame.height + questionEmptyTextLabel.frame.height + 129)
        } else {
            questionView.addSubview(questionTextView)
            
            self.view.layoutIfNeeded()
            
            let height = Int(questionTextView.oneTitleLabel.frame.height + questionTextView.oneTextLabel.frame.height) * min(2, viewModel.user.questions.count)
            
            questionTextView.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                make.top.equalTo(self.questionTitleLabel.snp.bottom).offset(22)
                if self.viewModel.user.questions.count > 2 {
                    self.questionTextViewHeightAnchor = make.height.equalTo(height + 44).constraint
                } else {
                    if self.viewModel.user.questions.count == 1 {
                        self.questionTextViewHeightAnchor = make.height.equalTo(height + 37).constraint
                    } else {
                        self.questionTextViewHeightAnchor = make.height.equalTo(height + 59).constraint
                    }
                }
            }
            
            self.view.layoutIfNeeded()
            
            if viewModel.user.questions.count > 2 {
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
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
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
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
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
        editImageButton.addTarget(
            self,
            action: #selector(clickEditImageButton(_:)),
            for: .touchUpInside)
        editUserNameButton.addTarget(
            self,
            action: #selector(clickEditUserNameButton(_:)),
            for: .touchUpInside)
        schoolButton.addTarget(
            self,
            action: #selector(clickSchoolButton(_:)),
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
    @objc private func clickEditImageButton(_ sender: UIButton) {
        coordinator?.didTabEditMyPhotoButton()
    }
    
    @objc private func clickEditUserNameButton(_ sender: UIButton) {
        coordinator?.didTabEditUserNameButton()
    }
    
    @objc private func clickSettingsButton(_ sender: UIButton) {
        print("세팅 아이콘 버튼 클릭")
    }
    
    @objc private func clickSchoolButton(_ sender: UIButton) {
        coordinator?.didTabSchoolButton()
    }
    
    @objc private func clickBadgeButton(_ sender: UIButton) {
        coordinator?.didTabBadgeButton()
    }
    
    @objc private func clickTournamentButton(_ sender: UIButton) {
        print("토너먼트 버튼 클릭")
    }
    
    @objc private func clickMoreLinkButton(_ sender: UIButton) {
        coordinator?.didTabLinkButton()
    }
    
    @objc private func clickMoreIntroduceButton(_ sender: UIButton) {
        coordinator?.didTabIntroduceButton()
    }
    
    @objc private func clickMoreQuestionButton(_ sender: UIButton) {
        coordinator?.didTabQuestionButton()
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

extension ProfileViewController: ProfileViewControllerDelegate {
    public func didTabBackButtonFromLinksDialogViewController() {
        linkView.subviews.forEach {
            $0.removeFromSuperview()
            $0.snp.removeConstraints()
        }
        
        linkEmptyTextLabel.snp.removeConstraints()
        linkView.snp.removeConstraints()
        linkEmptyTextLabel.removeFromSuperview()
        linkView.removeFromSuperview()
        
        linkView.configUserInterface(linkList: viewModel.filterLinks)
        
        addLinkView(count: viewModel.filterLinks.count)
        
        view.layoutIfNeeded()
        
        backgroundViewHeightAnchor?.update(offset: informationView.frame.height + linkBackView.frame.height + introduceView.frame.height + questionView.frame.height + 21)
        
        view.layoutIfNeeded()
        
        scrollView.contentSize = CGSize(width: view.frame.width, height: backgroundView.frame.height)
    }
    
    public func didTabBackButtonFromQuestionsViewController(user: MyPageData) {
        viewModel.user = user
        
        questionTextView.subviews.forEach {
            $0.removeFromSuperview()
            $0.snp.removeConstraints()
        }
        
        moreBackgroundView.subviews.forEach {
            $0.removeFromSuperview()
            $0.snp.removeConstraints()
        }
        
        [questionEmptyTextLabel, questionTextView, moreBackgroundView].forEach {
            $0.removeFromSuperview()
            $0.snp.removeConstraints()
        }
        
        questionTextView.configUserInterface(questionList: user.questions)
        
        addQuestionTextView()
        
        moreButton.setTitle("펼쳐서 보기", for: .normal)
        
        self.view.layoutIfNeeded()
        
        self.backgroundViewHeightAnchor?.update(offset: self.informationView.frame.height + self.linkBackView.frame.height + self.introduceView.frame.height + self.questionView.frame.height + 21)
        
        self.view.layoutIfNeeded()
        
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.backgroundView.frame.height)
    }
}
