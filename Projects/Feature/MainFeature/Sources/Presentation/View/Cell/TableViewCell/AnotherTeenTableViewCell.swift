//
//  AnotherTeenTableViewCell.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import Common
import DesignSystem
import UIKit

class AnotherTeenTableViewCell: UITableViewCell {
    let colors: [CGColor] = [
        .init(red: 0, green: 0, blue: 0, alpha: 0.5),
        .init(red: 0, green: 0, blue: 0, alpha: 0)
    ]
    
    weak var delegate: MainViewControllerCoordinator?
//    
//    lazy var teenCollectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 16
//        layout.minimumInteritemSpacing = 0
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: ViewValues.todayTeenImageWidth, height: ViewValues.todayTeenImageHeight)
//        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        collectionView.backgroundColor = UIColor.white
//        collectionView.showsHorizontalScrollIndicator = false
//        return collectionView
//    }()
    var heartButtonAction: (() -> Void)?
    
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
    
    lazy var teenImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.addSublayer(topGradientLayer)
        imageView.layer.addSublayer(bottomGradientLayer)
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    lazy var schoolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "graduationcap.fill")
        imageView.tintColor = UIColor.white
        return imageView
    }()
    
    lazy var schoolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .footnote, weight: .regular)
        return label
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(teenImageView)
        contentView.addSubview(schoolImageView)
        contentView.addSubview(schoolLabel)
        contentView.addSubview(nameLabel)
        contentView.addSubview(heartButton)
        
        self.teenImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        self.schoolImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-16)
            make.height.equalTo(24)
        }
        
        self.schoolLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.schoolImageView.snp.trailing).offset(2)
            make.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(100)
            make.height.equalTo(24)
        }
        
        self.nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-80)
            make.bottom.equalTo(self.schoolImageView.snp.top).offset(-3)
            make.height.equalTo(24)
        }
        
        self.heartButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-32)
            make.bottom.equalToSuperview().offset(-16)
            make.width.height.equalTo(47)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        teenImageView.image = nil
        nameLabel.text = ""
        schoolLabel.text = ""
    }
    
    override func setNeedsLayout() {
        self.topGradientLayer.frame = CGRect(
            x: 0,
            y: 0,
            width: contentView.frame.width,
            height: contentView.frame.height/2)
        
        self.bottomGradientLayer.frame = CGRect(
            x: 0,
            y: contentView.frame.height/2,
            width: contentView.frame.width,
            height: contentView.frame.height/2)
    }
    
    func setUI(teen: TodayTeen) {
        teenImageView.image = teen.image
        nameLabel.text = teen.name
        schoolLabel.text = "인덕원 고등학교"
    }
}

// MARK: - Action
extension AnotherTeenTableViewCell {
    @objc func clickHeartButton(_ sender: UIButton) {
        heartButtonAction?()
    }
}

extension AnotherTeenTableViewCell: Reusable { }
