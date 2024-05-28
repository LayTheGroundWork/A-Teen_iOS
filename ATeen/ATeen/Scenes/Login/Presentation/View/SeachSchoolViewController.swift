//
//  SeachSchoolViewController.swift
//  ATeen
//
//  Created by 김명현 on 5/28/24.
//

import UIKit

class SeachSchoolViewController: UIViewController {
    var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "다니고 있는\n학교를 알려주세요"
        label.numberOfLines = 0
        label.setLineSpacing(spacing: 10)
        return label
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
        let mainColor = UIColor(named: "mainColor")
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 12
        textField.layer.borderColor = mainColor?.cgColor
        
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = mainColor
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 30)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        paddingView.addSubview(imageView)
        
        textField.rightView = paddingView
        textField.rightViewMode = .always
        
        return textField
    }()
    
    var button: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        button.setTitle("다음으로", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = ViewValues.defaultRadius
        
        return button
    }()
    
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .systemBackground
        
        self.view.addSubview(label)
        self.view.addSubview(textField)
        self.view.addSubview(button)
        
        label.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(31)
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
        }
        
        textField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.equalTo(label.snp.bottom).offset(10)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(44)
        }
        
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.bottom.equalToSuperview().offset(-40)
            make.width.equalTo(116)
            make.height.equalTo(50)
        }
    }
}

extension UILabel {
    func setLineSpacing(spacing: CGFloat) {
        guard let text = text else { return }
        
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        style.lineSpacing = spacing
        attributeString.addAttribute(.paragraphStyle,
                                     value: style,
                                     range: NSRange(location: 0, length: attributeString.length))
        attributedText = attributeString
    }
}


