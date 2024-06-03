//
//  ReportDialogViewController.swift
//  ATeen
//
//  Created by phang on 5/31/24.
//

import SnapKit

import UIKit

protocol ReportDialogViewControllerCoordinator: AnyObject {
    func didFinish()
}

// TODO: - 기타 버튼 클릭 시, textField 에 내용 필수
// + 이유 없이 신고하기 버튼 클릭 disable 처리
// 신고 사유 정리되면 사유 텍스트 수정 필요
// 버튼 액션 처리
// 버튼 클릭 시, 버튼 이미지 변경 로직 필요
final class ReportDialogViewController: UIViewController {
    // MARK: - Private properties
    private weak var coordinator: ReportDialogViewControllerCoordinator?

    private lazy var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var xmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "xMarkIcon"), for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "신고사유"
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout,
                                       weight: .bold)
        return label
    }()
    
    private lazy var reportReasonButton1: UIButton = {
        let button = CustomUsedToReportViewButton(
            imageName: "circleButton",
            imageColor: .gray03,
            labelText: "따돌림 또는 괴롭힘")
        button.isSelected = false
        button.tag = 1
        return button
    }()
    
    private lazy var reportReasonButton2: UIButton = {
        let button = CustomUsedToReportViewButton(
            imageName: "circleButton",
            imageColor: .gray03,
            labelText: "불법적인 게시물")
        button.isSelected = false
        button.tag = 2
        return button
    }()
    
    private lazy var reportReasonButton3: UIButton = {
        let button = CustomUsedToReportViewButton(
            imageName: "circleButton",
            imageColor: .gray03,
            labelText: "혐오 발언 또는 상징")
        button.isSelected = false
        button.tag = 3
        return button
    }()
    
    private lazy var reportReasonButton4: UIButton = {
        let button = CustomUsedToReportViewButton(
            imageName: "circleButton",
            imageColor: .gray03,
            labelText: "기타")
        button.isSelected = false
        button.tag = 4
        return button
    }()
    
    // TODO: - delegate 사용해서 디벨롭 수정 필요
    private lazy var textField: UITextField = {
        let textField = UITextField()
//        textField.delegate = self
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 2
        textField.layer.borderColor = UIColor.gray03.cgColor
        return textField
    }()
    
    private lazy var blockButton: UIButton = {
        let button = CustomUsedToReportViewButton(
            imageName: "grayCheckButton",
            imageColor: .gray03,
            labelText: "해당 프로필 다시는 보지 않기")
        button.isSelected = false
        return button
    }()
    
    private lazy var explainMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "신고는 반대 의견을 표시하는 기능이 아닙니다."
        label.textColor = .gray01
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        return label
    }()
    
    private lazy var reportButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle("신고하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .main
        button.layer.cornerRadius = ViewValues.defaultRadius
        return button
    }()
    
    init(coordinator: ReportDialogViewControllerCoordinator) {
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
        setupActions()
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        view.backgroundColor = .black.withAlphaComponent(0.2)

        // 블러 효과 추가
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.82
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.addSubview(blurEffectView)
    
        view.addSubview(dialogView)
        dialogView.addSubview(xmarkButton)
        dialogView.addSubview(titleLabel)
        dialogView.addSubview(reportReasonButton1)
        dialogView.addSubview(reportReasonButton2)
        dialogView.addSubview(reportReasonButton3)
        dialogView.addSubview(reportReasonButton4)
        dialogView.addSubview(textField)
        dialogView.addSubview(blockButton)
        dialogView.addSubview(explainMessageLabel)
        dialogView.addSubview(reportButton)
    }
    
    private func configLayout() {
        dialogView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.trailing.equalToSuperview().offset(-ViewValues.defaultPadding)
            make.center.equalToSuperview()
        }
        
        xmarkButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(xmarkButton.snp.centerY)
            make.leading.equalToSuperview().offset(20)
        }
        
        reportReasonButton1.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.leading.equalToSuperview().offset(20)
        }
        
        reportReasonButton2.snp.makeConstraints { make in
            make.top.equalTo(reportReasonButton1.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(20)
        }
        
        reportReasonButton3.snp.makeConstraints { make in
            make.top.equalTo(reportReasonButton2.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(20)
        }
        
        reportReasonButton4.snp.makeConstraints { make in
            make.top.equalTo(reportReasonButton3.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(20)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(reportReasonButton4.snp.bottom).offset(ViewValues.defaultPadding)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(100)
        }
        
        blockButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(20)
        }
        
        explainMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(blockButton.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(20)
        }
        
        reportButton.snp.makeConstraints { make in
            make.top.equalTo(explainMessageLabel.snp.bottom).offset(42)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-30)
            make.height.equalTo(50)
        }
    }
    
    private func setupActions() {
        reportReasonButton1.addTarget(self,
                                      action: #selector(clickReasonButton(_:)),
                                      for: .touchUpInside)
        reportReasonButton2.addTarget(self,
                                      action: #selector(clickReasonButton(_:)),
                                      for: .touchUpInside)
        reportReasonButton3.addTarget(self,
                                      action: #selector(clickReasonButton(_:)),
                                      for: .touchUpInside)
        reportReasonButton4.addTarget(self,
                                      action: #selector(clickReasonButton(_:)),
                                      for: .touchUpInside)
        xmarkButton.addTarget(self,
                              action: #selector(clickCloseButton(_:)),
                              for: .touchUpInside)
        reportButton.addTarget(self,
                                action: #selector(clickReportButton(_:)),
                                for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func clickCloseButton(_ sender: UIButton) {
        coordinator?.didFinish()
    }
    
    @objc private func clickReasonButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            didSelectReasonButton(reportReasonButton1)
        case 2:
            didSelectReasonButton(reportReasonButton2)
        case 3:
            didSelectReasonButton(reportReasonButton3)
        case 4:
            didSelectReasonButton(reportReasonButton4)
        default:
            break
        }
    }
    
    @objc private func clickReportButton(_ sender: UIButton) {
        // TODO: - 신고
    }
}

// MARK: - Extension + Actions 관련 메서드
extension ReportDialogViewController {
    private func didSelectReasonButton(_ button: UIButton) {
        if button.isSelected {
            updateSelectButton(button)
        } else {
            updateNotSelectButton(button)
        }
    }
    
    private func updateSelectButton(_ button: UIButton) {
        button.isSelected = true
    }
    
    private func updateNotSelectButton(_ button: UIButton) {
        button.isSelected = false
    }
}
