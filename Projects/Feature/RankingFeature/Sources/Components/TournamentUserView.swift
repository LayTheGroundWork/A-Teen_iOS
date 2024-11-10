//
//  TournamentUserView.swift
//  RankingFeature
//
//  Created by phang on 6/26/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import Common
import DesignSystem
import Domain
import UIKit

final class TournamentUserView: UIView {
    // MARK: - Private properties
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = DesignSystemAsset.badge9.image
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var schoolAndAgeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.white
        label.font = UIFont.customFont(forTextStyle: .callout, weight: .bold)
        return label
    }()
    
    // MARK: - Life Cycle
    init(frame: CGRect, tag: Int) {
        super.init(frame: frame)
        
        self.tag = tag
        
        configUserInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        self.clipsToBounds = true
        self.layer.cornerRadius = ViewValues.defaultRadius
        
        addSubview(imageView)
        imageView.addSubview(schoolAndAgeLabel)
        imageView.addSubview(nameLabel)
    }
    
    func changeUI(participant: TournamentParticipantData, age: Int) {
        nameLabel.text = participant.userName
        schoolAndAgeLabel.text = "\(participant.userSchool) | \(age)세"
    }
    
    func changeFontSize() {
        nameLabel.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        schoolAndAgeLabel.font = UIFont.customFont(forTextStyle: .callout, weight: .regular)
    }
}

// MARK: - Extensions here
extension TournamentUserView {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        schoolAndAgeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.bottom.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.bottom.equalTo(schoolAndAgeLabel.snp.top).offset(-8)
            make.trailing.equalTo(imageView.snp.centerX)
        }
    }
}
