//
//  PhoneNumberViewController.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol PhoneNumberViewControllerCoordinator: AnyObject {
    func didFinish()
    func openVerificationCompleteDialog()
    func openExistingUserLoginDialog()
    func openInValidCodeNumberDialog()
}

public final class PhoneNumberViewController: UIViewController {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var coordinator: PhoneNumberViewControllerCoordinator?
    private var currentIndexPath = IndexPath(item: 0, section: 0)
    private let viewModel: PhoneNumberViewModel
    // 뒤로 가기 버튼
    private lazy var backButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: DesignSystemAsset.leftArrowIcon.image,
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
    init(
        coordinator: PhoneNumberViewControllerCoordinator,
        viewModel: PhoneNumberViewModel
    ) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let visibleCells = collectionView.visibleCells as? [CertificationCodeCollectionViewCell] {
            for cell in visibleCells {
                cell.clearTextFields()
            }
        }
        currentIndexPath.section = 0
        collectionView.scrollToItem(
            at: currentIndexPath,
            at: .centeredHorizontally,
            animated: false
        )
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
    @objc private func didSelectBackButton(_ sender: UIButton) {
        if currentIndexPath.section == 1 {
            currentIndexPath.section -= 1
            collectionView.scrollToItem(
                at: currentIndexPath,
                at: .centeredHorizontally,
                animated: true
            )
            view.endEditing(true)
            if let visibleCells = collectionView.visibleCells as? [CertificationCodeCollectionViewCell] {
                for cell in visibleCells {
                    cell.clearTextFields()
                }
            }
        } else {
            coordinator?.didFinish()
        }
    }
}

// MARK: - Extensions here
extension PhoneNumberViewController: UICollectionViewDelegate { }

extension PhoneNumberViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(
        _ collectionView: UICollectionView,
        willDisplay cell: UICollectionViewCell,
        forItemAt indexPath: IndexPath
    ) {
        if indexPath.section == 1 {
            if let cell = cell as? CertificationCodeCollectionViewCell {
                cell.resetTimer()
            }
        }
    }
}

extension PhoneNumberViewController: UICollectionViewDataSource {
    public func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        1
    }
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    public func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: PhoneNumberCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? PhoneNumberCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.setProperty(
                delegate: self,
                viewModel: viewModel
            )
            return cell
        case 1:
            guard
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: CertificationCodeCollectionViewCell.reuseIdentifier,
                    for: indexPath) as? CertificationCodeCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            
            cell.setProperty(
                delegate: self,
                viewModel: viewModel
            )
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}

extension PhoneNumberViewController: PhoneNumberCollectionViewCellDelegate {

    func didSelectCertificateButton() {
        currentIndexPath.section += 1
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.scrollToItem(
                at: self.currentIndexPath,
                at: .centeredHorizontally,
                animated: true
            )
            self.view.endEditing(true)
        }
    }
}

extension PhoneNumberViewController: CertificationCodeCollectionViewCellDelegate {
    public func didSelectNextButton(registrationStatus: RegistrationStatus) {
        switch registrationStatus {
        case .signedUp:
            self.coordinator?.openExistingUserLoginDialog()

        case .notSignedUp:
            self.coordinator?.openVerificationCompleteDialog()

        case .inValidCodeNumber:
            self.coordinator?.openInValidCodeNumberDialog()
        }
    }
}
