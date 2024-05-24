//
//  AboutATeenTableViewCell.swift
//  ATeenClone
//
//  Created by 노주영 on 5/16/24.
//

import UIKit

class AboutATeenTableViewCell: UITableViewCell {
    weak var delegate: MainViewControllerCoordinator?
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Abount A-Teen"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    lazy var everythingStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstStackView, SecondStackView])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    
    lazy var firstStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [teenBox, tournamentBox])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    
    lazy var SecondStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [chattingBox, profileBox])
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 16
        return stack
    }()
    
    lazy var teenBox: CustomAboutATeenView = {
        let view = CustomAboutATeenView(
            frame: .zero,
            imageName: "person",
            title: "Teen",
            text: "친구들의 프로필을 투표해보세요!")
        view.tag = 0
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedView(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var tournamentBox: CustomAboutATeenView = {
        let view = CustomAboutATeenView(
            frame: .zero,
            imageName: "person",
            title: "토너먼트",
            text: "투표 결과를 한 눈에 볼 수 있어요! ")
        view.tag = 1
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedView(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var chattingBox: CustomAboutATeenView = {
        let view = CustomAboutATeenView(
            frame: .zero,
            imageName: "person",
            title: "채팅",
            text: "채팅을 통해 친구들과 소통해보세요!")
        view.tag = 2
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedView(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var profileBox: CustomAboutATeenView = {
        let view = CustomAboutATeenView(
            frame: .zero,
            imageName: "person",
            title: "나만의 Teen",
            text: "나만의의 프로필을 등록해보세요!")
        view.tag = 3
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickedView(_:)))
        view.addGestureRecognizer(tapGesture)
        return view
    }()
    
    lazy var grayLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "grayLineColor")
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
            delegate?.didSelectAboutATeenCell(tag: tag)
        }
    }
}

extension AboutATeenTableViewCell: Reusable { }
