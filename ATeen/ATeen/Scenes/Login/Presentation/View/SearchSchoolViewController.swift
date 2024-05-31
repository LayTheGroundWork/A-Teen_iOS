//
//  SearchSchoolViewController.swift
//  ATeen
//
//  Created by 김명현 on 5/28/24.
//

import UIKit

class SearchSchoolViewController: UIViewController, UITextFieldDelegate {
    // MARK: - Public properties
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
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(15, 0, 0) // 텍스트필드 앞에 공백 넣어주기
        textField.autocorrectionType = .no
        textField.spellCheckingType = .no
        textField.tintColor = .gray
        
        let image = UIImage(systemName: "magnifyingglass")
        let imageView = UIImageView(image: image)
        imageView.tintColor = mainColor
        imageView.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 25)) // 이미지 패딩값 넣어주기
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
    
    var tableBackgroundView: UIView = {
        let tableBackgroundView = UIView()
        tableBackgroundView.backgroundColor = .white
        tableBackgroundView.layer.cornerRadius = ViewValues.defaultRadius
        
        return tableBackgroundView
    }()
    
    var tableView = SearchSchoolResultTableViewController()
    let schools = ["seoul","seoul2", "busan", "busan2", "changwon", "anyang", "busan3", "busan4", "busan5", "busan6", "busan7", "busan8", "busan9", "busan10", "busan11","busan12"]
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        
        textField.delegate = self
        
        tableView.searchDelegate = self
        tableView.schools = schools
        tableBackgroundView.isHidden = true
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = UIColor(named: "backgroundColor")
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
        self.view.addSubview(label)
        self.view.addSubview(textField)
        self.view.addSubview(tableBackgroundView)
        self.view.addSubview(button)
        tableBackgroundView.addSubview(tableView)
    }
    
    private func configLayout() {
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
            make.bottom.equalToSuperview().offset(-50)
            make.width.equalTo(116)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.leading.equalTo(tableBackgroundView.snp.leading).offset(5)
            make.trailing.equalTo(tableBackgroundView.snp.trailing).offset(-44)
            make.height.equalTo(0)
            
        }
        
        tableBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(18)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.height.equalTo(0)
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let query = textField.text else { return }
        tableView.filterSchools(with: query)
    }
}

// MARK: - Extensions here
extension UILabel {
    func setLineSpacing(spacing: CGFloat) { // 줄 간격 조절
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

extension SearchSchoolViewController: SchoolTableViewSearchDelegate {
    func didSelectFilteredSchool(schoolName: String) {
        textField.text = schoolName
    }
    
    func didUpdateFilteredSchools(isEmpty: Bool) {
        tableBackgroundView.isHidden = isEmpty
    }
    
    func didUpdateFilterSchoolsCount(count: Int) {
        let height = 45
        tableBackgroundView.snp.updateConstraints { make in
            if count < 6 {
                make.height.equalTo(height * count)
            } else {
                make.height.equalTo(240)
            }
        }
        
        tableView.snp.updateConstraints { make in
            if count < 6 {
                make.height.equalTo(height * count)
            } else {
                make.height.equalTo(240)
            }
        }
    }
}

