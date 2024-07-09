//
//  ProfileDetailViewController.swift
//  ATeenClone
//
//  Created by 노주영 on 5/20/24.
//

import SnapKit

import Common
import FeatureDependency
import DesignSystem
import UIKit

public class ProfileDetailViewController: UIViewController {
    let colors: [CGColor] = [
        .init(red: 0, green: 0, blue: 0, alpha: 0.5),
        .init(red: 0, green: 0, blue: 0, alpha: 0)
    ]
    
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
    
    private var viewModel: ProfileDetailViewModel
    private weak var coordinator: ProfileDetailViewControllerCoordinator?
    
    var todayTeen: TodayTeen?
    
    var frame: CGRect?
    var topAnchor: Constraint?
    var leadingAnchor: Constraint?
    var widthAnchor: Constraint?
    var heightAnchor: Constraint?
    
    var backgroundViewHeightAnchor: Constraint?
    var informationViewHeightAnchor: Constraint?
    var questionViewHeightAnchor: Constraint?
    var questionTextViewHeightAnchor: Constraint?
    
    public init(
        viewModel: ProfileDetailViewModel,
        coordinator: ProfileDetailViewControllerCoordinator,
        frame: CGRect,
        todayTeen: TodayTeen
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        self.frame = frame
        self.todayTeen = todayTeen
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
        view.backgroundColor = DesignSystemAsset.grayLineColor.color
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
        let pageControl = CustomPageControlView()
        pageControl.isUserInteractionEnabled = false
        pageControl.dotColor = UIColor.white.withAlphaComponent(0.5)
        pageControl.selectedColor = UIColor.white
        return pageControl
    }()
    
    lazy var categoryLabel: UILabel = {
        let label = UILabel()
        //TODO: 카테고리 유저 모델에 있겠지?
        label.text = "#스포츠"
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
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
            labelText: "123",
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
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = self.todayTeen?.name
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .largeTitle, weight: .bold)
        return label
    }()
    
    lazy var schoolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "graduationcap.fill")
        imageView.tintColor = DesignSystemAsset.gray01.color
        return imageView
    }()
    
    lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.text = "인덕원고등학교, 18세"
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
    
    lazy var aboutMeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "자기 소개"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    lazy var mbtiLabel: UILabel = {
        let label = UILabel()
        label.text = "INFP"
        label.textColor = DesignSystemAsset.gray02.color
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        label.backgroundColor = DesignSystemAsset.grayMbtiCellColor.color
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        return label
    }()
    
    lazy var aboutMeTextLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        """
        label.textColor = DesignSystemAsset.gray02.color
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    lazy var questionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemBackground
        return view
    }()
    
    lazy var questionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "10문 10답"
        label.textColor = UIColor.black
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    lazy var questionTextView: CustomQuestionView = {
        let view = CustomQuestionView(frame: .zero, questionList: self.questionList)
        return view
    }()
    
    lazy var addBackgroundView: UIView = {
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
        let view = ProfileDetailBottomBar()
        return view
    }()

    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
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
        if sender.titleLabel?.text == "펼쳐서 보기" {
            UIView.animate(withDuration: 0.3, delay: 0, options: .showHideTransitionViews) {
                self.questionTextViewHeightAnchor?.update(offset: self.questionTextView.recursiveUnionInDepthFor(view: self.questionTextView).height + 15)
                
                self.view.layoutIfNeeded()
                self.questionViewHeightAnchor?.update(offset: self.questionTitleLabel.frame.height + self.questionTextView.frame.height + 190)
                
                self.view.layoutIfNeeded()
                self.backgroundViewHeightAnchor?.update(offset: self.teenCollectionView.frame.height + self.informationView.frame.height + self.questionView.frame.height + 7)
                
                self.view.layoutIfNeeded()
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.backgroundView.frame.height)
                
                sender.setTitle("접기", for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .showHideTransitionViews) {
                self.view.layoutIfNeeded()
                let originHeight = self.questionTextView.oneTitleLabel.frame.height + self.questionTextView.oneTextLabel.frame.height + self.questionTextView.twoTitleLabel.frame.height + self.questionTextView.twoTextLabel.frame.height + 45

                self.questionTextViewHeightAnchor?.update(offset: originHeight)
                
                self.view.layoutIfNeeded()
                self.questionViewHeightAnchor?.update(offset: self.questionTitleLabel.frame.height + self.questionTextView.frame.height + 190)
                
                self.view.layoutIfNeeded()
                self.backgroundViewHeightAnchor?.update(offset: self.teenCollectionView.frame.height + self.informationView.frame.height + self.questionView.frame.height + 7)
                
                self.view.layoutIfNeeded()
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.backgroundView.frame.height)
                
                sender.setTitle("펼쳐서 보기", for: .normal)
            }
        }
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
            self.topAnchor = make.top.equalToSuperview().offset(frame.origin.y).constraint
            self.leadingAnchor = make.leading.equalToSuperview().offset(frame.origin.x).constraint
            
            self.widthAnchor = make.width.equalTo(frame.width).constraint
            self.heightAnchor = make.height.equalTo(frame.height).constraint
        }
        
        self.barView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(90)
        }
        
        addBackgroundView(frame: frame)
    }
    
    private func addBackgroundView(frame: CGRect) {
        scrollView.addSubview(backgroundView)
        
        self.backgroundView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalTo(self.scrollView.frameLayoutGuide)
            self.backgroundViewHeightAnchor = make.height.equalTo(frame.height).constraint
        }
        
        addBackgroundComponentView()
    }
    
    private func addBackgroundComponentView() {
        backgroundView.addSubview(teenCollectionView)
        backgroundView.addSubview(categoryLabel)
        backgroundView.addSubview(informationView)
        backgroundView.addSubview(questionView)
        backgroundView.addSubview(heartButton)
        backgroundView.addSubview(pageControl)
        
        teenCollectionView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(self.frame?.height ?? 360)
        }
        
        categoryLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(
                (self.categoryLabel.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: self.categoryLabel.font!]).width + 40)
            make.height.equalTo(26)
        }
        
        informationView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.teenCollectionView.snp.bottom)
            self.informationViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        questionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.informationView.snp.bottom).offset(7)
            self.questionViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(self.teenCollectionView.snp.bottom).offset(-35)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(70)
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.heartButton.snp.top).offset(-14)
            make.height.equalTo(5)
        }
        
        self.view.layoutIfNeeded()
        
        self.topGradientLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: self.teenCollectionView.frame.width,
            height: self.teenCollectionView.frame.height/2)
        
        self.bottomGradientLayer.frame = CGRect(
            x: 0,
            y: self.teenCollectionView.frame.height/2,
            width: self.teenCollectionView.frame.width,
            height: self.teenCollectionView.frame.height/2)
        
        addInfomationComponentView()
        addQuestionComponentView()
    }
    
    private func addInfomationComponentView() {
        informationView.addSubview(nameLabel)
        informationView.addSubview(schoolImageView)
        informationView.addSubview(schoolLabel)
        informationView.addSubview(badgeButton)
        informationView.addSubview(tournamentButton)
        informationView.addSubview(aboutMeTitleLabel)
        informationView.addSubview(mbtiLabel)
        informationView.addSubview(aboutMeTextLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(40)
            make.width.equalTo(
                (self.nameLabel.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: self.nameLabel.font!]).width + 10)
            make.height.equalTo(38)
        }
        
        schoolImageView.snp.makeConstraints { make in
            make.leading.equalTo(self.nameLabel.snp.trailing)
            make.bottom.equalTo(self.nameLabel.snp.bottom)
            make.width.height.equalTo(24)
        }
        
        schoolLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.leading.equalTo(self.schoolImageView.snp.trailing).offset(2)
            make.bottom.equalTo(self.nameLabel.snp.bottom)
            make.height.equalTo(24)
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
        
        aboutMeTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.badgeButton.snp.bottom).offset(40)
            make.height.equalTo(24)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(self.aboutMeTitleLabel.snp.bottom).offset(7)
            make.width.equalTo(74)
            make.height.equalTo(26)
        }
        
        aboutMeTextLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.mbtiLabel.snp.bottom).offset(7)
            make.height.greaterThanOrEqualTo(
                (self.nameLabel.text! as NSString).size(withAttributes: [NSAttributedString.Key.font: self.nameLabel.font!]).height)
        }
        
        self.view.layoutIfNeeded()
        
        self.informationViewHeightAnchor?.update(offset: self.informationView.recursiveUnionInDepthFor(view: self.informationView).height + 40)
    }
    
    private func addQuestionComponentView() {
        questionView.addSubview(questionTitleLabel)
        questionView.addSubview(questionTextView)
        
        questionTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(28)
            make.height.equalTo(24)
        }
        
        self.view.layoutIfNeeded()
        
        questionTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.questionTitleLabel.snp.bottom).offset(22)
            if self.questionList.count > 2 {
                self.questionTextViewHeightAnchor = make.height.equalTo(
                    questionTextView.oneTitleLabel.frame.height + questionTextView.oneTextLabel.frame.height + questionTextView.twoTitleLabel.frame.height + questionTextView.twoTextLabel.frame.height + 45
                ).constraint
            } else {
                self.questionTextViewHeightAnchor = make.height.equalTo(
                    questionTextView.oneTitleLabel.frame.height + questionTextView.oneTextLabel.frame.height + questionTextView.twoTitleLabel.frame.height + questionTextView.twoTextLabel.frame.height + 60
                ).constraint
            }
        }
        
        self.view.layoutIfNeeded()
        
        if self.questionList.count > 2 {
            self.questionViewHeightAnchor?.update(offset: questionTitleLabel.frame.height + questionTextView.frame.height + 190)
            
            addAddBackgroundComponentView()
        } else {
            self.questionViewHeightAnchor?.update(offset: questionTitleLabel.frame.height + questionTextView.frame.height + 125)
            
            animateView()
        }
    }
    
    private func addAddBackgroundComponentView() {
        questionView.addSubview(addBackgroundView)
        
        addBackgroundView.addSubview(moreImageView)
        addBackgroundView.addSubview(moreButton)
        
        addBackgroundView.snp.makeConstraints { make in
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
        
        animateView()
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
        for _ in 0..<9 {
            self.todayTeen?.images.append(DesignSystemAsset.blackGlass.image)
        }
        
        guard let imagesCount = self.todayTeen?.images.count else { return }
        
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
            
            self.teenCollectionView.collectionViewLayout = self.setCollectionViewLayout(
                width: self.view.frame.width,
                height: self.view.frame.height)
            
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
            
            self.backgroundViewHeightAnchor?.update(offset: self.teenCollectionView.frame.height + self.informationView.frame.height + self.questionView.frame.height + 7)
            
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
                for: indexPath) as? TeenImageCellCollectionViewCell, let todayTeen = self.todayTeen
        else {
            return UICollectionViewCell()
        }
        cell.setImage(image: todayTeen.images[indexPath.row])
        
        return cell
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.todayTeen?.images.count ?? 1
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
