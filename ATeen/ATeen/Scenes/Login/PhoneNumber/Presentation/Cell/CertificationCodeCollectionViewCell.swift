//
//  CertificationCodeCollectionViewCell.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

import SnapKit

import UIKit

protocol CertificationCodeCollectionViewCellDelegate: AnyObject {
    func didSelectNextButton()
}

final class CertificationCodeCollectionViewCell: UICollectionViewCell {
    // MARK: - Public properties
    
    // MARK: - Private properties
    private weak var delegate: CertificationCodeCollectionViewCellDelegate?
    
    private lazy var inputCodeLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.inputCodeText
        label.font = UIFont.customFont(forTextStyle: .title3,
                                       weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle(AppLocalized.nextButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUserInterface()
        configLayout()
        setupActions()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(inputCodeLabel)
        self.contentView.addSubview(nextButton)

    }

    private func configLayout() {
        inputCodeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.greaterThanOrEqualToSuperview().offset(-ViewValues.defaultPadding)
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
    
    func setDelegate(delegate: CertificationCodeCollectionViewCellDelegate) {
        self.delegate = delegate
    }
    
    // MARK: - Actions
    @objc private func didSelectNextButton(_ sender: UIButton) {
        delegate?.didSelectNextButton()
    }
    // MARK: - Extensions here
    
}

extension CertificationCodeCollectionViewCell: Reusable { }
