//
//  ProfileDetailViewController.swift
//  ATeenClone
//
//  Created by 노주영 on 5/20/24.
//

import SnapKit

import UIKit

class ProfileDetailViewController: UIViewController {
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
        .init(
            title: "Lorem ipsum dolor sit amet?",
            text: """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            """),
        .init(
            title: "Lorem ipsum dolor sit amet?",
            text: """
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            """),
    ]
    
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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .systemBackground
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
        scrollView.clipsToBounds = true
        scrollView.layer.cornerRadius = 20
        return scrollView
    }()
    
    lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayLineColor")
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "arrowshape.backward.fill"), for: .normal)
        button.tintColor = .white
        button.alpha = 0
        button.addTarget(self, action: #selector(clickCloseButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menuIcon"), for: .normal)
        button.tintColor = .white
        button.alpha = 0
        button.addTarget(self, action: #selector(clickMenuButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var todayTeenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = self.todayTeen?.image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.addSublayer(topGradientLayer)
        imageView.layer.addSublayer(bottomGradientLayer)
        return imageView
    }()
    
    lazy var heartButton: CustomHeartButton = {
        let button = CustomHeartButton(frame: .zero, text: "123")
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
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        return label
    }()
    
    lazy var schoolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "graduationcap.fill")
        imageView.tintColor = UIColor(named: "graySchoolColor")
        return imageView
    }()
    
    lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.text = "인덕원고등학교, 18세"
        label.textColor = UIColor(named: "graySchoolColor")
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    lazy var badgeButton: CustomProfileButton = {
        let button = CustomProfileButton(
            frame: .zero,
            title: "뱃지",
            count: "10개",
            imageString: "profileBadge")
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(clickBadgeButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var tournamentButton: CustomProfileButton = {
        let button = CustomProfileButton(
            frame: .zero,
            title: "Teen",
            count: "5월 2주차 우승",
            imageString: "profileTournament")
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(clickTournamentButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var aboutMeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "자기 소개"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var mbtiLabel: UILabel = {
        let label = UILabel()
        label.text = "INFP"
        label.textColor = UIColor(named: "grayTextColor")
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.backgroundColor = UIColor(named: "grayMbtiCellColor")
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 10
        return label
    }()
    
    lazy var aboutMeTextLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
        """
        label.textColor = UIColor(named: "grayTextColor")
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var questionView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
    }()
    
    lazy var questionTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "10문 10답"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var questionTextView: CustomQuestionView = {
        let view = CustomQuestionView(frame: .zero, questionList: self.questionList)
        return view
    }()
    
    lazy var addBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayQuestionCellColor")
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = CACornerMask(arrayLiteral: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        return view
    }()
    
    lazy var moreImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "moreIcon")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("펼쳐서 보기", for: .normal)
        button.setTitleColor(UIColor(named: "grayTextColor"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.addTarget(self, action: #selector(clickMoreButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var barView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "mainColor")
        view.alpha = 0
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
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
        print("펼치기 버튼 클릭")
        if sender.titleLabel?.text == "펼쳐서 보기" {
            UIView.animate(withDuration: 0.4, delay: 0, options: .showHideTransitionViews) {
                self.questionTextViewHeightAnchor?.update(offset: self.questionTextView.recursiveUnionInDepthFor(view: self.questionTextView).height + 16)
                
                self.view.layoutIfNeeded()
                self.questionViewHeightAnchor?.update(offset: self.questionTitleLabel.frame.height + self.questionTextView.frame.height + 190)
                
                self.view.layoutIfNeeded()
                self.backgroundViewHeightAnchor?.update(offset: self.backgroundView.recursiveUnionInDepthFor(view: self.backgroundView).height)
                
                self.view.layoutIfNeeded()
                self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.backgroundView.frame.height)
                
                sender.setTitle("접기", for: .normal)
            }
        } else {
            UIView.animate(withDuration: 0.4, delay: 0, options: .showHideTransitionViews) {
                self.questionTextViewHeightAnchor?.update(offset: 267)
                
                self.view.layoutIfNeeded()
                self.questionViewHeightAnchor?.update(offset: self.questionTitleLabel.frame.height + self.questionTextView.frame.height + 190)
                
                self.view.layoutIfNeeded()
                self.backgroundViewHeightAnchor?.update(offset: self.backgroundView.recursiveUnionInDepthFor(view: self.backgroundView).height - 305)
                
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
        view.backgroundColor = .clear
        
        addScrollView(frame: frame)
        
        //가장 마지막
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
            make.height.equalTo(80)
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
        backgroundView.addSubview(todayTeenImageView)
        backgroundView.addSubview(informationView)
        backgroundView.addSubview(questionView)
        backgroundView.addSubview(heartButton)
        
        todayTeenImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.height.equalTo(self.frame?.height ?? 360)
        }
        
        informationView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.todayTeenImageView.snp.bottom)
            self.informationViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        questionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.informationView.snp.bottom).offset(7)
            self.questionViewHeightAnchor = make.height.equalTo(0).constraint
        }
        
        heartButton.snp.makeConstraints { make in
            make.top.equalTo(self.todayTeenImageView.snp.bottom).offset(-35)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(70)
        }
        
        self.view.layoutIfNeeded()
        
        self.topGradientLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: self.todayTeenImageView.frame.width,
            height: self.todayTeenImageView.frame.height/2)
        
        self.bottomGradientLayer.frame = CGRect(
            x: 0,
            y: self.todayTeenImageView.frame.height/2,
            width: self.todayTeenImageView.frame.width,
            height: self.todayTeenImageView.frame.height/2)
        
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
        questionView.addSubview(addBackgroundView)
        
        questionTitleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(28)
            make.height.equalTo(24)
        }
        
        questionTextView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.questionTitleLabel.snp.bottom).offset(22)
            self.questionTextViewHeightAnchor = make.height.equalTo(267).constraint
        }
        
        addBackgroundView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.questionTextView.snp.bottom)
            make.height.equalTo(80)
        }
        
        self.view.layoutIfNeeded()
        
        self.questionViewHeightAnchor?.update(offset: questionTitleLabel.frame.height + questionTextView.frame.height + 190)
        
        addAddBackgroundComponentView()
    }
    
    private func addAddBackgroundComponentView() {
        addBackgroundView.addSubview(moreImageView)
        addBackgroundView.addSubview(moreButton)
        
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
        backgroundView.addSubview(closeButton)
        backgroundView.addSubview(menuButton)
        
        closeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(60)
            make.width.height.equalTo(24)
        }
        
        menuButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(57)
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
}

// MARK: - Animation
extension ProfileDetailViewController {
    func animateView() {
        UIView.animate(withDuration: 0.4, delay: 0, options: .overrideInheritedCurve) {
            self.topAnchor?.update(offset: 0)
            self.leadingAnchor?.update(offset: 0)
            self.widthAnchor?.update(offset: self.view.frame.width)
            self.heightAnchor?.update(offset: self.view.frame.height - 80)
            
            self.scrollView.layer.cornerRadius = 0
            self.backgroundView.layer.cornerRadius = 0
            self.view.layoutIfNeeded()
            
            self.topGradientLayer.frame = CGRect(
                x: 0,
                y: 0,
                width: self.todayTeenImageView.frame.width,
                height: self.todayTeenImageView.frame.height/2)
            
            self.bottomGradientLayer.frame = CGRect(
                x: 0,
                y: self.todayTeenImageView.frame.height/2,
                width: self.todayTeenImageView.frame.width,
                height: self.todayTeenImageView.frame.height/2)
            
            self.view.layoutIfNeeded()
            
            self.backgroundViewHeightAnchor?.update(offset: self.backgroundView.recursiveUnionInDepthFor(view: self.backgroundView).height)
            
            self.view.layoutIfNeeded()
            
            self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: self.backgroundView.frame.height)
        } completion: { _ in
            self.todayTeenImageView.clipsToBounds = true
            self.todayTeenImageView.contentMode = .scaleAspectFill
            self.barView.alpha = 1
        }
    }
    
    func closeAnimation() {
        self.scrollView.layer.cornerRadius = 20
        
        //TODO: - 이미지 뷰 뺴고 다 0
        self.closeButton.alpha = 0
        self.menuButton.alpha = 0
        self.heartButton.alpha = 0
        self.barView.alpha = 0
        
        self.todayTeenImageView.clipsToBounds = false
        
        UIView.animate(withDuration: 0.4, delay: 0, options: .showHideTransitionViews) {
            if let frame = self.frame {
                self.topAnchor?.update(offset: frame.origin.y)
                self.leadingAnchor?.update(offset: frame.origin.x)
                self.widthAnchor?.update(offset: frame.size.width)
                self.heightAnchor?.update(offset: frame.size.height)
                
                self.view.layoutIfNeeded()
            }
        } completion: { _ in
            self.dismiss(animated: false, completion: nil)
        }
    }
}
