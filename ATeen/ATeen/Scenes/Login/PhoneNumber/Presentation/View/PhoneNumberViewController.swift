//
//  PhoneNumberViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import SnapKit

import UIKit

protocol PhoneNumberViewControllerCoordinator: AnyObject {
    func didFinish()
    func openVerificationCompleteDialog()
    func openExistingUserLoginDialog()
    func didSelectResendCode()
}

final class PhoneNumberViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var coordinator: PhoneNumberViewControllerCoordinator?
    private var currentSection: Int = 0
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
        layout.itemSize = CGSize(width: ViewValues.width, height: ViewValues.phoneNumberCollectionViewHeight)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        
        collectionView.register(PhoneNumberCollectionViewCell.self, forCellWithReuseIdentifier: PhoneNumberCollectionViewCell.reuseIdentifier)
        collectionView.register(CertificationCodeCollectionViewCell.self, forCellWithReuseIdentifier: CertificationCodeCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    
    // MARK: - Life Cycle
    init(coordinator: PhoneNumberViewControllerCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let visibleCells = collectionView.visibleCells as? [CertificationCodeCollectionViewCell] {
            for cell in visibleCells {
                cell.clearTextFields()
            }
        }
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = backButton
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configLayout() {
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(ViewValues.defaultPadding)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc private func didSelectNextButton(_ sender: UIButton) {
        
    }
    
    @objc private func didSelectBackButton(_ sender: UIButton) {
        if currentSection == 1 {
            collectionView.scrollToItem(
                at: IndexPath(item: 0, section: 0),
                at: .centeredHorizontally,
                animated: true
            )
        } else {
            coordinator?.didFinish()
        }
    }
}

// MARK: - Extensions here
extension PhoneNumberViewController: UICollectionViewDelegate {
    
}

extension PhoneNumberViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PhoneNumberCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? PhoneNumberCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.setDelegate(delegate: self)
            currentSection = 0
            return cell
        case 1:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CertificationCodeCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? CertificationCodeCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.setDelegate(delegate: self)
            currentSection = 1
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension PhoneNumberViewController: PhoneNumberCollectionViewCellDelegate {
    func didSelectCertificateButton() {
        collectionView.scrollToItem(
            at: IndexPath(item: 0, section: 1),
            at: .centeredHorizontally,
            animated: true
        )
    }
}

extension PhoneNumberViewController: CertificationCodeCollectionViewCellDelegate {
    func didSelectNextButton(registrationStatus: RegistrationStatus) {
        if registrationStatus == .notSignedUp {
            coordinator?.openVerificationCompleteDialog()
        } else {
            coordinator?.openExistingUserLoginDialog()
        }
    }
    
    func didSelectResendCode() {
        coordinator?.didSelectResendCode()
    }
}

