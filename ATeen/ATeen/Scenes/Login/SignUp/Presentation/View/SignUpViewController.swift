//
//  SignUpViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/29/24.
//

import SnapKit

import UIKit

protocol SignUpViewControllerCoordinator: AnyObject {
    func didFinish()
    func didSelectBirth()
    func didSelectService()
}

final class SignUpViewController: UIViewController {
    
    // MARK: - Private properties
    private var currentIndexPath = IndexPath(item: 0, section: 0)
    
    private var viewModel: LoginBirthViewModel
    private weak var coordinator: SignUpViewControllerCoordinator?

    private lazy var progressView: UIProgressView = {
        let view = UIProgressView()
        view.trackTintColor = .gray03
        view.progressTintColor = .main
        view.progress = ViewValues.signUpProgress
        return view
    }()
    
    // 뒤로 가기 버튼
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(named: "leftArrowIcon"),
                                     style: .plain,
                                     target: self,
                                     action: #selector(didSelectBackButton(_:)))
        button.tintColor = .black
        return button
    }()
    
    // 콜렉션 뷰
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: ViewValues.width, height: ViewValues.halfHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        collectionView.register(UserIdCollectionViewCell.self, forCellWithReuseIdentifier: UserIdCollectionViewCell.reuseIdentifier)
        collectionView.register(UserNameCollectionViewCell.self, forCellWithReuseIdentifier: UserNameCollectionViewCell.reuseIdentifier)
        collectionView.register(UserBirthCollectionViewCell.self, forCellWithReuseIdentifier: UserBirthCollectionViewCell.reuseIdentifier)
        collectionView.register(SearchSchoolCollectionViewCell.self, forCellWithReuseIdentifier: SearchSchoolCollectionViewCell.reuseIdentifier)
       
        return collectionView
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle(AppLocalized.nextButton, for: .normal)
        button.setTitle(AppLocalized.nextButton, for: .disabled)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.gray02, for: .disabled)
        button.backgroundColor = .gray03
        button.layer.cornerRadius = ViewValues.defaultRadius
        button.isEnabled = false
        return button
    }()
    
    init(viewModel: LoginBirthViewModel,
         coordinator: SignUpViewControllerCoordinator
    ) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        setupActions()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = backButton
        self.view.addSubview(progressView)
        self.view.addSubview(collectionView)
        self.view.addSubview(nextButton)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configLayout() {
        progressView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(5)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(progressView.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(ViewValues.halfHeight)
        }
        
        nextButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalTo(ViewValues.signUpNextButtonWidth)
            make.height.equalTo(ViewValues.signUpNextButtonHeight)
        }
    }
    
    private func setupActions() {
        nextButton.addTarget(self,
                             action: #selector(didSelectNextButton(_: )),
                             for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func didSelectNextButton(_ sender: UIButton) {
        guard currentIndexPath.section < collectionView.numberOfSections - 1 else { return }
        
        currentIndexPath.section += 1
        progressView.setProgress(progressView.progress + ViewValues.signUpProgress, animated: true)
        collectionView.scrollToItem(
            at: currentIndexPath,
            at: .centeredHorizontally,
            animated: true
        )
        nextButton.isEnabled = false
        nextButton.backgroundColor = .gray03
        view.endEditing(true)
    }
    
    @objc private func didSelectBackButton(_ sender: UIBarButtonItem) {
        guard currentIndexPath.section != 0 else {
            coordinator?.didFinish()
            return
        }
        switch currentIndexPath.section {
        // 유저 아이디
        case 1:
            let cell = collectionView.cellForItem(at: currentIndexPath) as? UserNameCollectionViewCell
            cell?.textField.text = ""
            cell?.contentView.endEditing(true)
        // 생년월일
        case 2:
            let cell = collectionView.cellForItem(at: currentIndexPath) as? UserBirthCollectionViewCell
            cell?.birthButton.customLabel.attributedText = nil
            cell?.birthButton.customLabel.text = AppLocalized.userBirthSelectButton
            break
        // 학교 선택
        case 3:
            let cell = collectionView.cellForItem(at: currentIndexPath) as? SearchSchoolCollectionViewCell
            cell?.schoolTextField.text = ""
            cell?.tableBackgroundView.isHidden = true
            cell?.contentView.endEditing(true)
            break
        default:
            break
        }
        currentIndexPath.section -= 1
        progressView.setProgress(progressView.progress - ViewValues.signUpProgress, animated: true)
        collectionView.scrollToItem(
            at: currentIndexPath,
            at: .centeredHorizontally,
            animated: true
        )
        nextButton.isEnabled = true
        nextButton.backgroundColor = .black
    }
}

// MARK: - Extensions here
extension SignUpViewController: UICollectionViewDelegate { }

extension SignUpViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        4
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {

        case 0:
            guard
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserIdCollectionViewCell.reuseIdentifier,
                for: indexPath) as? UserIdCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.setProperties(delegate: self)
            return cell
            
        case 1:
            guard
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserNameCollectionViewCell.reuseIdentifier,
                for: indexPath) as? UserNameCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.setProperties(delegate: self)
            return cell
            
        case 2:
            guard
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: UserBirthCollectionViewCell.reuseIdentifier,
                for: indexPath) as? UserBirthCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            guard let coordinator = coordinator else { return UICollectionViewCell() }
            cell.setProperties(viewModel: viewModel,
                               coordinator: coordinator,
                               delegate: self)
            
            return cell
            
        case 3:
            guard
                let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: SearchSchoolCollectionViewCell.reuseIdentifier,
                for: indexPath) as? SearchSchoolCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.setProperties(delegate: self, viewModel: viewModel)
            return cell

        default:
            return UICollectionViewCell()
        }
    }
}

extension SignUpViewController: UserIdCollectionViewCellDelegate,
                                UserNameCollectionViewCellDelegate,
                                UserBirthCollectionViewCellDelegate,
                                SearchSchoolCollectionViewCellDelegate {
    func updateNextButtonState(_ state: Bool) {
        nextButton.isEnabled = state
        nextButton.backgroundColor = if state { UIColor.black } else { UIColor.gray03 }
    }
    
    func didTapNextButtonInKeyboard() {
        didSelectNextButton(nextButton)
    }
}
