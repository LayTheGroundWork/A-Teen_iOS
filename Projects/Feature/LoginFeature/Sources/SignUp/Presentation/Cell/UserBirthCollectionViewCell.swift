//
//  UserBirthCollectionViewCell.swift
//  ATeen
//
//  Created by 노주영 on 5/30/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

protocol UserBirthCollectionViewCellDelegate: AnyObject {
    func updateNextButtonState(_ state: Bool)
}

final class UserBirthCollectionViewCell: UICollectionViewCell {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var coordinator: SignUpViewControllerCoordinator?
    private weak var delegate: UserBirthCollectionViewCellDelegate?
    private var viewModel: SignUpViewModel?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.userBirthTitle
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    lazy var birthButton: CustomBirthButton = {
        let button = CustomBirthButton(
            imageName: "arrowDownIcon",
            imageColor: UIColor.white,
            textColor: UIColor.black,
            labelText: AppLocalized.userBirthSelectButton,
            buttonBackgroundColor: UIColor.white,
            labelFont: UIFont.customFont(forTextStyle: .callout, weight: .regular),
            frame: .zero)
        button.addTarget(self, action: #selector(didSelectBirth(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var serviceButton: CustomServiceButton = {
        let button = CustomServiceButton(
            imageName: "arrowRightSmallIcon",
            imageColor: UIColor.white,
            textColor: DesignSystemAsset.gray01.color,
            labelText: AppLocalized.userBirthServiceTermsButton,
            buttonBackgroundColor: UIColor.white,
            labelFont: UIFont.customFont(forTextStyle: .footnote, weight: .regular),
            frame: .zero)
        button.customLabel.sizeToFit()
        button.addTarget(self, action: #selector(didSelectService(_:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotification(_:)),
            name: .selectBirth,
            object: nil)
        configUserInterface()
        configLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(birthButton)
        contentView.addSubview(serviceButton)
    }
    
    private func configLayout() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.top.equalToSuperview()
        }
        
        birthButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.equalTo(titleLabel.snp.bottom).offset(36)
            make.width.equalTo(190)
            make.height.equalTo(24)
        }
        
        serviceButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.equalTo(birthButton.snp.bottom).offset(87)
            make.width.equalTo(140)
            make.height.equalTo(24)
        }
    }
    
    // MARK: - Actions
    func setProperties(
        coordinator: SignUpViewControllerCoordinator,
        delegate: UserBirthCollectionViewCellDelegate,
        viewModel: SignUpViewModel
    ) {
        self.coordinator = coordinator
        self.delegate = delegate
        self.viewModel = viewModel
    }
    
    @objc func didSelectBirth(_ sender: UIButton) {
        coordinator?.didSelectBirth()
    }
    
    @objc func didSelectService(_ sender: UIButton) {
        coordinator?.didSelectService()
    }
    
    @objc func handleNotification(_ notification: Notification) {
        guard let viewModel = viewModel else { return }
        birthButton.changeWidth(
            year: viewModel.year,
            month: viewModel.month,
            day: viewModel.day)
        
        print(viewModel.phoneNumber)
        print(viewModel.userId)
        print(viewModel.userName)
        print(viewModel.year)
        print(viewModel.month)
        print(viewModel.day)
        delegate?.updateNextButtonState(true)
    }
}

// MARK: - Extensions here

extension UserBirthCollectionViewCell: Reusable { }
