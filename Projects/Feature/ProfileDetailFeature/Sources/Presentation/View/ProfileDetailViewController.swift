//
//  ProfileDetailViewController.swift
//  ATeenClone
//
//  Created by 노주영 on 5/20/24.
//

import SnapKit

import Common
import DesignSystem
import Domain
import FeatureDependency
import UIKit

public class ProfileDetailViewController: UIViewController {
    let colors: [CGColor] = [
        .init(red: 0, green: 0, blue: 0, alpha: 0.5),
        .init(red: 0, green: 0, blue: 0, alpha: 0)
    ]
    
    private var viewModel: ProfileDetailViewModel
    private weak var coordinator: ProfileDetailViewControllerCoordinator?
    
    var frame: CGRect?
    var topAnchor: Constraint?
    var leadingAnchor: Constraint?
    var widthAnchor: Constraint?
    var heightAnchor: Constraint?
    
    var backgroundViewHeightAnchor: Constraint?
    var informationViewHeightAnchor: Constraint?
    var introduceViewHeightAnchor: Constraint?
    var questionViewHeightAnchor: Constraint?
    var questionTextViewHeightAnchor: Constraint?
    
    public init(
        viewModel: ProfileDetailViewModel,
        coordinator: ProfileDetailViewControllerCoordinator,
        frame: CGRect
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.frame = frame
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var topGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.locations = [0.0, 0.44, 1.0]
        return layer
    }()
    
    lazy var bottomGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0.5, y: 1.0)
        layer.endPoint = CGPoint(x: 0.5, y: 0.0)
        layer.locations = [0.0, 0.44, 1.0]
        return layer
    }()
    
    lazy var naviView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.xMarkWhiteIcon.image, for: .normal)
        button.tintColor = .white
        button.alpha = 0
        button.addTarget(self, action: #selector(clickCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.menuIcon.image, for: .normal)
        button.tintColor = .white
        button.alpha = 0
        button.addTarget(self, action: #selector(clickMenuButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = UIColor.systemBackground
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = true
        scrollView.layer.cornerRadius = 20
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 90, right: 0)
        scrollView.delegate = self
        return scrollView
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var teenCollectionView: UICollectionView = {
        guard let frame = self.frame else { return UICollectionView() }
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: setCollectionViewLayout(width: frame.width, height: frame.height))
        collectionView.backgroundColor = UIColor.white
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.layer.addSublayer(topGradientLayer)
        collectionView.layer.addSublayer(bottomGradientLayer)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(TeenImageCellCollectionViewCell.self, forCellWithReuseIdentifier: TeenImageCellCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    lazy var pageControl: CustomPageControlView = {
        let pageControl = CustomPageControlView(dotWidth: 6, dotHeight: 6)
        pageControl.isUserInteractionEnabled = false
        pageControl.dotColor = UIColor.white.withAlphaComponent(0.5)
        pageControl.selectedColor = UIColor.white
        return pageControl
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "#\(viewModel.user.category)"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .semibold)
        label.clipsToBounds = true
        label.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.layer.borderColor = DesignSystemAsset.profileDetailCategoryBorderColor.color.cgColor
        return label
    }()
    
    lazy var heartButton: CustomHeartButton = {
        let button = CustomHeartButton(
            imageName: DesignSystemAsset.heartIcon.name,
            imageColor: .white,
            textColor: .white,
            labelText: "\(viewModel.user.likeCount)",
            buttonBackgroundColor: .black,
            labelFont: UIFont.preferredFont(
                forTextStyle: .footnote),
            frame: .zero)
        button.layer.cornerRadius = 35
        button.addTarget(self, action: #selector(clickHeartButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var informationView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    lazy var idLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.user.uniqueId
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.user.nickName
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .largeTitle, weight: .bold)
        return label
    }()
    
    lazy var schoolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.schoolGrayIcon.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.text = "\(viewModel.user.schoolName), \(viewModel.getUserAge())세"
        label.textColor = DesignSystemAsset.gray01.color
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    lazy var badgeButton: CustomProfileBadgeButton = {
        let button = CustomProfileBadgeButton(
            frame: .zero,
            title: "뱃지",
            count: "10개",
            imageType: .badge)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(clickBadgeButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var tournamentButton: CustomProfileBadgeButton = {
        let button = CustomProfileBadgeButton(
            frame: .zero,
            title: "Teen",
            count: "5월 2주차 우승",
            imageType: .tournament)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(clickTournamentButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var introduceView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    lazy var introduceTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "자기 소개"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
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
    
    lazy var introduceTextLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.user.introduction ?? ""
        label.textColor = DesignSystemAsset.gray02.color
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var introduceEmptyTextLabel: UILabel = {
        let label = UILabel()
        label.text = "등록된 소개글이 없습니다."
        label.font = .customFont(forTextStyle: .footnote, weight: .regular)
        label.textColor = DesignSystemAsset.gray02.color
        return label
    }()
    
    lazy var divider = CustomDivider()
    
    lazy var questionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        return view
    }()
    
    lazy var questionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "자문자답"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    lazy var questionTextView: CustomQuestionView = {
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
        button.addTarget(self, action: #selector(clickMoreButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var barView: UIView = {
        let view = ProfileDetailBottomBar(frame: .zero,
                                          coordinator: self)
        return view
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getUserDetailData { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.setUI()
            }
        }
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        addSampleImages()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
}

// MARK: Action
extension ProfileDetailViewController {
    @objc func clickCloseButton(_ sender: UIButton){
        self.closeAnimation()
    }
    
    @objc func clickMenuButton(_ sender: UIButton){
        print("메뉴 버튼 클릭")
    }
    
    @objc func clickHeartButton(_ sender: UIButton) {
        print("하트 버튼 클릭")
    }
    
    @objc func clickBadgeButton(_ sender: UIButton) {
        print("뱃지 버튼 클릭")
    }
    
    @objc func clickTournamentButton(_ sender: UIButton) {
        print("토너먼트 버튼 클릭")
    }
    
    @objc func clickMoreButton(_ sender: UIButton) {
        moreButtonAnimation(sender)
    }
}

// MARK: - UI
extension ProfileDetailViewController {
    private func setUI(){
        guard let frame = self.frame else { return }
        view.backgroundColor = UIColor.clear
        
        addScrollView(frame: frame)
        addNaviButton()
    }
    
    private func addScrollView(frame: CGRect) {
        view.addSubview(scrollView)
        view.addSubview(barView)
        
        scrollView.snp.makeConstraints { make in
            topAnchor = make.top.equalToSuperview().offset(frame.origin.y).constraint
            leadingAnchor = make.leading.equalToSuperview().offset(frame.origin.x).constraint
            
            widthAnchor = make.width.equalTo(frame.width).constraint
            heightAnchor = make.height.equalTo(frame.height).constraint
        }
        
        barView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(90)
        }
        
        addBackgroundView(frame: frame)
    }
    
    private func addBackgroundView(frame: CGRect) {
        scrollView.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(scrollView.frameLayoutGuide)
            backgroundViewHeightAnchor = make.height.equalTo(frame.height).constraint
        }
        
        addBackgroundComponentView()
    }
    
    private func addBackgroundComponentView() {
        backgroundView.addSubview(teenCollectionView)
        backgroundView.addSubview(categoryLabel)
        backgroundView.addSubview(informationView)
        backgroundView.addSubview(heartButton)
        backgroundView.addSubview(pageControl)
        
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.categoryLabel.frame
        blurEffectView.alpha = 0.1
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.cornerRadius = 10
        blurEffectView.clipsToBounds = true
        
        categoryLabel.addSubview(blurEffectView)
        
        teenCollectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(self.frame?.height ?? 360)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(
                (categoryLabel.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: categoryLabel.font!]).width + 40)
            make.height.equalTo(26)
        }
        
        informationView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(teenCollectionView.snp.bottom)
            informationViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(teenCollectionView.snp.bottom).offset(-35)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(70)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(heartButton.snp.top).offset(-14)
            make.height.equalTo(5)
        }
        
        view.layoutIfNeeded()
        
        topGradientLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: teenCollectionView.frame.width,
            height: teenCollectionView.frame.height/2)
        
        bottomGradientLayer.frame = CGRect(
            x: 0,
            y: teenCollectionView.frame.height/2,
            width: teenCollectionView.frame.width,
            height: teenCollectionView.frame.height/2)
        
        addInfomationComponent()
        addIntroduceComponent()
        addQuestionComponent()
    }
    
    private func addInfomationComponent() {
        informationView.addSubview(idLabel)
        informationView.addSubview(nameLabel)
        informationView.addSubview(schoolImageView)
        informationView.addSubview(schoolLabel)
        informationView.addSubview(badgeButton)
        informationView.addSubview(tournamentButton)
        
        idLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.equalToSuperview().offset(29)
            make.trailing.equalTo(view.snp.centerX)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.equalTo(idLabel.snp.bottom).offset(1)
            make.width.equalTo(
                (self.nameLabel.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: self.nameLabel.font!]).width + 10)
        }
        
        schoolImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.nameLabel.snp.trailing)
            make.bottom.equalTo(self.nameLabel.snp.bottom)
            make.width.height.equalTo(24)
        }
        
        schoolLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalTo(self.schoolImageView.snp.trailing).offset(2)
            make.centerY.equalTo(self.schoolImageView).offset(2)
        }
        
        badgeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(18)
            make.trailing.equalTo(self.informationView.snp.centerX).offset(-8)
            make.height.equalTo(97)
        }
        
        tournamentButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.nameLabel.snp.bottom).offset(18)
            make.leading.equalTo(self.informationView.snp.centerX).offset(8)
            make.height.equalTo(97)
        }
        
        view.layoutIfNeeded()
        
        informationViewHeightAnchor?.update(
            offset: idLabel.frame.height + nameLabel.frame.height + badgeButton.frame.height + 88
        )
    }
    
    private func addIntroduceComponent() {
        backgroundView.addSubview(introduceView)
        introduceView.addSubview(introduceTitleLabel)
        
        introduceView.snp.makeConstraints { make in
            make.top.equalTo(informationView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            self.introduceViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        introduceTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
        addIntroduceTextView()
    }
    
    private func addIntroduceTextView() {
        introduceView.addSubview(introduceMbtiView)
        
        if viewModel.user.introduction == nil {
            introduceView.addSubview(introduceEmptyTextLabel)
        } else {
            introduceView.addSubview(introduceTextLabel)
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
                    make.top.equalTo(introduceMbtiView.snp.bottom).offset(10)
                }
            }
            
            view.layoutIfNeeded()
            
            introduceViewHeightAnchor?.update(
                offset: introduceTitleLabel.frame.height + introduceMbtiView.frame.height + introduceEmptyTextLabel.frame.height + 66)
        } else {
            introduceTextLabel.snp.makeConstraints { make in
                make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
                make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
                
                if viewModel.user.mbti == nil {
                    make.top.equalTo(introduceTitleLabel.snp.bottom).offset(ViewValues.defaultPadding)
                } else {
                    make.top.equalTo(introduceMbtiView.snp.bottom).offset(10)
                }
            }
            
            view.layoutIfNeeded()
            
            introduceViewHeightAnchor?.update(
                offset: introduceTitleLabel.frame.height + introduceMbtiView.frame.height + introduceTextLabel.frame.height + 66)
        }
    }

    private func addQuestionComponent() {
        backgroundView.addSubview(divider)
        backgroundView.addSubview(questionView)
        questionView.addSubview(questionTitleLabel)
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(introduceView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        
        questionView.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom)
            make.leading.trailing.equalToSuperview()
            self.questionViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        questionTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(39)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
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
        animateView()
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
    
    private func addNaviButton(){
        view.addSubview(naviView)
        
        naviView.addSubview(closeButton)
        naviView.addSubview(menuButton)
        
        naviView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(100)
        }
        
        closeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.height.equalTo(24)
        }
        
        menuButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-16)
            make.width.height.equalTo(30)
        }
        
        UIView.animate(withDuration: 0.1, delay: 0.3, options: .showHideTransitionViews) {
            self.closeButton.alpha = 1
            self.menuButton.alpha = 1
        } completion: { _ in
            self.view.layoutIfNeeded()
            
            self.backgroundViewHeightAnchor?.update(offset: self.backgroundView.recursiveUnionInDepthFor(view: self.backgroundView).height)
        }
    }
    
    private func setCollectionViewLayout(width: CGFloat, height: CGFloat) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: width, height: height)
        return layout
    }
    
    private func addSampleImages() {
        if viewModel.user.profileImages.count > 1 {
            for _ in 0..<viewModel.user.profileImages.count - 1 {
                viewModel.todayTeenImages.append(DesignSystemAsset.badge2.image)
            }
        }
        
        let imagesCount = viewModel.todayTeenImages.count
        pageControl.pages = imagesCount
        
        if imagesCount <= 5 {
            pageControl.maxDots = 5
            pageControl.centerDots = 5
        } else {
            pageControl.maxDots = 7
            pageControl.centerDots = 3
        }
        self.teenCollectionView.reloadData()
    }
}

// MARK: - Animation
extension ProfileDetailViewController {
    func animateView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .overrideInheritedCurve) {
            self.topAnchor?.update(offset: 0)
            self.leadingAnchor?.update(offset: 0)
            self.widthAnchor?.update(offset: self.view.frame.width)
            self.heightAnchor?.update(offset: self.view.frame.height)
            self.view.layoutIfNeeded()
            
            self.teenCollectionView.collectionViewLayout = self.setCollectionViewLayout(
                width: self.view.frame.width,
                height: self.teenCollectionView.frame.height)

            
            self.scrollView.layer.cornerRadius = 0
            self.backgroundView.layer.cornerRadius = 0
            self.view.layoutIfNeeded()
            
            self.topGradientLayer.frame = CGRect(
                x: 0,
                y: 0,
                width: self.teenCollectionView.frame.width,
                height: self.teenCollectionView.frame.height / 2)
            
            self.bottomGradientLayer.frame = CGRect(
                x: 0,
                y: self.teenCollectionView.frame.height / 2,
                width: self.teenCollectionView.frame.width,
                height: self.teenCollectionView.frame.height / 2)
            
            self.view.layoutIfNeeded()
            
            self.backgroundViewHeightAnchor?.update(offset: self.teenCollectionView.frame.height + self.informationView.frame.height + self.introduceView.frame.height + self.divider.frame.height + self.questionView.frame.height)
            
            self.view.layoutIfNeeded()
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.backgroundView.frame.height)
        } completion: { _ in
            self.barView.alpha = 1
        }
    }
    
    func closeAnimation() {
        self.teenCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        
        self.scrollView.layer.cornerRadius = 20
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        
        //TODO: - 이미지 뷰 뺴고 다 0
        self.naviView.alpha = 0
        self.closeButton.alpha = 0
        self.menuButton.alpha = 0
        self.pageControl.alpha = 0
        self.categoryLabel.alpha = 0
        self.heartButton.alpha = 0
        self.barView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .showHideTransitionViews) {
            if let frame = self.frame {
                self.topAnchor?.update(offset: frame.origin.y)
                self.leadingAnchor?.update(offset: frame.origin.x)
                self.widthAnchor?.update(offset: frame.size.width)
                self.heightAnchor?.update(offset: frame.size.height)
                
                self.teenCollectionView.collectionViewLayout = self.setCollectionViewLayout(
                    width: frame.width,
                    height: frame.height)
                
                self.view.layoutIfNeeded()
            }
        } completion: { _ in
            self.coordinator?.didFinishFlow()
        }
    }
    
    func moreButtonAnimation(_ sender: UIButton) {
        if sender.titleLabel?.text == "펼쳐서 보기" {
            UIView.animate(withDuration: 0.3, delay: 0, options: .showHideTransitionViews) {
                self.questionTextViewHeightAnchor?.update(offset: self.questionTextView.recursiveUnionInDepthFor(view: self.questionTextView).height + 15)
                
                self.view.layoutIfNeeded()
                self.questionViewHeightAnchor?.update(offset: self.questionTitleLabel.frame.height + self.questionTextView.frame.height + 210)
                
                self.view.layoutIfNeeded()
                self.backgroundViewHeightAnchor?.update(offset: self.teenCollectionView.frame.height + self.informationView.frame.height + self.introduceView.frame.height + self.divider.frame.height + self.questionView.frame.height)
                
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
                self.backgroundViewHeightAnchor?.update(offset: self.teenCollectionView.frame.height + self.informationView.frame.height + self.introduceView.frame.height + self.divider.frame.height + self.questionView.frame.height)
                
                self.view.layoutIfNeeded()
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.backgroundView.frame.height)
                
                sender.setTitle("펼쳐서 보기", for: .normal)
            }
        }
    }
}

extension ProfileDetailViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let frame = frame {
            let scrollOffset = scrollView.contentOffset.y
            
            if scrollOffset > frame.height - 100 {
                naviView.backgroundColor = .white
                closeButton.setImage(DesignSystemAsset.xMarkIcon.image, for: .normal)
                menuButton.setImage(DesignSystemAsset.menuBlackIcon.image, for: .normal)
            } else {
                naviView.backgroundColor = .clear
                closeButton.setImage(DesignSystemAsset.xMarkWhiteIcon.image, for: .normal)
                menuButton.setImage(DesignSystemAsset.menuIcon.image, for: .normal)
            }
        }
    }
}

// MARK: - UICollectionViewDataSource
extension ProfileDetailViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: TeenImageCellCollectionViewCell.reuseIdentifier,
                for: indexPath) as? TeenImageCellCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        cell.setImage(image: viewModel.todayTeenImages[indexPath.row])
        
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.todayTeenImages.count
    }
}

// MARK: - UICollectionViewDelegate
extension ProfileDetailViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //TODO: 셀 클릭할 떄 동작
    }

    public func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == teenCollectionView {
            let pageIndex = Int(targetContentOffset.pointee.x / self.view.frame.width)
            pageControl.selectedPage = pageIndex
        }
    }
}


//MARK: - ProfileDetailBottomBarDelegate
extension ProfileDetailViewController: ProfileDetailBottomBarDelegate {
    public func didTapSNSButton(
        contentViewController: UIViewController
    ) {
        coordinator?.didTapSNSButton(contentViewController: contentViewController)
    }
}
