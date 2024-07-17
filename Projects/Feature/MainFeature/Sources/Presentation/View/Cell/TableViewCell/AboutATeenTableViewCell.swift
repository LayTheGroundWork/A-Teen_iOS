//
//  AboutATeenTableViewCell.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import DesignSystem
import Common
import UIKit

class AboutATeenTableViewCell: UITableViewCell {
    weak var delegate: MainViewControllerCoordinator?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.aboutATeen
        label.textAlignment = .left
        label.font = UIFont.customFont(forTextStyle: .title3, weight: .bold)
        return label
    }()
    
    lazy var everythingStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstStackView, SecondStackView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = ViewValues.defaultSpacing
        return stack
    }()
    
    lazy var firstStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [teenBox, tournamentBox])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = ViewValues.defaultSpacing
        return stack
    }()
    
    lazy var SecondStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [chattingBox, profileBox])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = ViewValues.defaultSpacing
        return stack
    }()
    
    lazy var teenBox: CustomAboutATeenView = {
        let view = CustomAboutATeenView(
            frame: .zero,
            imageName: "person",
            title: AppLocalized.teenTitle,
            text: AppLocalized.teenText)
        view.tag = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedView(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var tournamentBox: CustomAboutATeenView = {
        let view = CustomAboutATeenView(
            frame: .zero,
            imageName: "person",
            title: AppLocalized.tournamentTitle,
            text: AppLocalized.tournamentText)
        view.tag = 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedView(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var chattingBox: CustomAboutATeenView = {
        let view = CustomAboutATeenView(
            frame: .zero,
            imageName: "person",
            title: AppLocalized.chatTitle,
            text: AppLocalized.chatText)
        view.tag = 2
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedView(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var profileBox: CustomAboutATeenView = {
        let view = CustomAboutATeenView(
            frame: .zero,
            imageName: "person",
            title: AppLocalized.myTeenTitle,
            text: AppLocalized.myTeenText)
        view.tag = 3
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedView(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var grayLine: UIView = {
        let view = UIView()
        view.backgroundColor = DesignSystemAsset.grayLineColor.color
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(everythingStackView)
        contentView.addSubview(grayLine)
        
        self.titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(46)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(24)
        }
        
        self.everythingStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalTo(self.titleLabel.snp.bottom).offset(22)
            make.height.equalTo(210)
        }
        
        self.grayLine.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(self.everythingStackView.snp.bottom).offset(40)
            make.height.equalTo(7)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}

// MARK: - Action
extension AboutATeenTableViewCell {
    @objc func clickedView(_ sender: UIGestureRecognizer) {
        if let tag = sender.view?.tag {
            switch tag {
            case 0:
                delegate?.didSelectAboutATeenCell(tag: TabTag.teenTab)
            case 1:
                delegate?.didSelectAboutATeenCell(tag: TabTag.rankingTab)
            case 2:
                delegate?.didSelectAboutATeenCell(tag: TabTag.chatTab)
            case 3:
                delegate?.didSelectAboutATeenCell(tag: TabTag.profileTab)
            default:
                break
            }
        }
    }
}

extension AboutATeenTableViewCell: Reusable { }
