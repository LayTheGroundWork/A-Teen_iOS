//
//  TodayTeenCollectionViewCell.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

class TodayTeenCollectionViewCell: UICollectionViewCell {
    let colors: [CGColor] = [
        .init(red: 0, green: 0, blue: 0, alpha: 0.5),
        .init(red: 0, green: 0, blue: 0, alpha: 0)
    ]
    
    weak var delegate: MainViewControllerCoordinator?
    
    var heartButtonAction: (() -> Void)?
    
    lazy var topGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height / 2)
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.locations = [0.0, 0.44, 1.0]
        return layer
    }()
    
    lazy var bottomGradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.frame = CGRect(x: 0, y: contentView.frame.height / 2, width: contentView.frame.width, height: contentView.frame.height / 2)
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0.5, y: 1.0)
        layer.endPoint = CGPoint(x: 0.5, y: 0.0)
        layer.locations = [0.0, 0.44, 1.0]
        return layer
    }()
    
    lazy var titleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.addSublayer(topGradientLayer)
        imageView.layer.addSublayer(bottomGradientLayer)
        return imageView
    }()
    
    lazy var schoolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "graduationcap.fill")
        imageView.tintColor = .white
        return imageView
    }()
    
    lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.text = "인덕원고등학교"
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    lazy var chattingButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.chattingIcon.image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = DesignSystemAsset.mainColor.color
        button.layer.cornerRadius = 23.5
        button.addTarget(self, action: #selector(clickChattingButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var heartButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.heartIcon.image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = DesignSystemAsset.mainColor.color
        button.layer.cornerRadius = 23.5
        button.isUserInteractionEnabled = true
        button.addTarget(self, action: #selector(clickHeartButton(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.menuIcon.image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(clickMenuButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(titleImageView)
        contentView.addSubview(schoolImageView)
        contentView.addSubview(schoolLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(chattingButton)
        contentView.addSubview(heartButton)
        contentView.addSubview(menuButton)
        
        self.titleImageView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        self.schoolImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-38)
            make.height.equalTo(24)
        }
        
        self.schoolLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.schoolImageView.snp.trailing).offset(2)
            make.bottom.equalToSuperview().offset(-38)
            make.width.equalTo(100)
            make.height.equalTo(24)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-80)
            make.bottom.equalTo(self.schoolLabel.snp.top)
            make.height.equalTo(24)
        }
        
        self.menuButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-27.5)
            make.bottom.equalToSuperview().offset(-38)
            make.width.height.equalTo(24)
        }
        
        self.heartButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.menuButton.snp.top).offset(-16)
            make.width.height.equalTo(47)
        }
        
        self.chattingButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalTo(self.heartButton.snp.top).offset(-16)
            make.width.height.equalTo(47)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(teen: TodayTeen) {
        titleImageView.image = teen.image
        nameLabel.text = teen.name
    }
}

// MARK: - Action
extension TodayTeenCollectionViewCell {
    @objc func clickChattingButton(_ sender: UIButton) {
        delegate?.didSelectTodayTeenChattingButton()
    }
    
    @objc func clickHeartButton(_ sender: UIButton) {
        heartButtonAction?()
    }
    
    @objc func clickMenuButton(_ sender: UIButton) {
        self.layoutIfNeeded()
        guard let collectionView = superview,
              let tableViewCell = collectionView.superview,
              let tableView = tableViewCell.superview,
              let mainView = tableView.superview,
              let appView = mainView.superview
        else { return }
        
        let menuButtonPosition = menuButton.convert(menuButton.bounds, to: appView)
        delegate?.didSelectMenuButton(popoverPosition: menuButtonPosition)
    }
}

extension TodayTeenCollectionViewCell: Reusable { }
