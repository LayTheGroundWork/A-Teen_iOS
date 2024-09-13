//
//  ReportDialogViewController.swift
//  ATeen
//
//  Created by phang on 5/31/24.
//

import SnapKit

import Common
import DesignSystem
import UIKit

public protocol ReportDialogViewControllerCoordinator: AnyObject {
    func didFinish()
    func didReport()
}

// TODO: - 기타 버튼 클릭 시, textField 에 내용 필수
// 신고 사유 정리되면 사유 텍스트 수정 필요
final class ReportDialogViewController: UIViewController {
    // MARK: - Private properties
    private var dialogType: ReportDialogType
    
    private weak var coordinator: ReportDialogViewControllerCoordinator?
    
    private lazy var dialogView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = ViewValues.defaultRadius
        return view
    }()
    
    private lazy var xmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.xMarkIcon.image, for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.reportDialogTitle
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .callout,
                                       weight: .bold)
        return label
    }()
    
    private lazy var reportReasonButton1: CustomUsedToReportViewButton = {
        let button = CustomUsedToReportViewButton(
            imageName: DesignSystemAsset.circleButton.name,
            selectedImageName: DesignSystemAsset.clickedCircleButton.name,
            imageColor: DesignSystemAsset.gray03.color,
            labelText: dialogType == .profile ?  AppLocalized.reportDialogViolenceReason : AppLocalized.reportDialogViolenceReasonInChat)
        button.tag = 1
        button.isSelected = false
        return button
    }()
    
    private lazy var reportReasonButton2: CustomUsedToReportViewButton = { 
        let button = CustomUsedToReportViewButton(
            imageName: DesignSystemAsset.circleButton.name,
            selectedImageName: DesignSystemAsset.clickedCircleButton.name,
            imageColor: DesignSystemAsset.gray03.color,
            labelText: dialogType == .profile ? AppLocalized.reportDialogAdReason : AppLocalized.reportDialogAdReasonInChat)
        button.tag = 2
        button.isSelected = false
        return button
    }()
    
    private lazy var reportReasonButton3: CustomUsedToReportViewButton = {
        let button = CustomUsedToReportViewButton(
            imageName: DesignSystemAsset.circleButton.name,
            selectedImageName: DesignSystemAsset.clickedCircleButton.name,
            imageColor: DesignSystemAsset.gray03.color,
            labelText: AppLocalized.reportDialogImpersonationReason)
        button.tag = 3
        button.isSelected = false
        return button
    }()
    
    private lazy var reportReasonButton4: CustomUsedToReportViewButton = {
        let button = CustomUsedToReportViewButton(
            imageName: DesignSystemAsset.circleButton.name,
            selectedImageName: DesignSystemAsset.clickedCircleButton.name,
            imageColor: DesignSystemAsset.gray03.color,
            labelText: AppLocalized.reportDialogETCReason)
        button.tag = 4
        button.isSelected = false
        return button
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.backgroundColor = UIColor.white
        textView.text = AppLocalized.reportDialogPlaceholderText
        textView.textColor = DesignSystemAsset.gray01.color
        textView.autocapitalizationType = .none
        textView.autocorrectionType = .no
        textView.returnKeyType = .done
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 2
        textView.layer.borderColor = DesignSystemAsset.gray03.color.cgColor
        textView.font = .customFont(forTextStyle: .footnote,
                                    weight: .regular)
        textView.textAlignment = .left
        textView.isEditable = true
        textView.isScrollEnabled = true
        return textView
    }()
    
    private lazy var blockButton: CustomUsedToReportViewButton = {
        let button = CustomUsedToReportViewButton(
            imageName: DesignSystemAsset.grayCheckButton.name,
            selectedImageName: DesignSystemAsset.mainCheckButton.name,
            imageColor: DesignSystemAsset.gray03.color,
            labelText: AppLocalized.reportDialogBlockButtonText)
        button.isSelected = false
        return button
    }()
    
    private lazy var explainMessageLabel: UILabel = {
        let label = UILabel()
        label.text = AppLocalized.reportDialogExplainText
        label.textColor = DesignSystemAsset.gray01.color
        label.textAlignment = .center
        label.font = UIFont.customFont(forTextStyle: .footnote,
                                       weight: .regular)
        return label
    }()
    
    private lazy var reportButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .callout,
                                                    weight: .regular)
        button.setTitle(AppLocalized.reportButton, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = DesignSystemAsset.gray01.color
        button.layer.cornerRadius = ViewValues.defaultRadius
        button.isEnabled = false
        return button
    }()
    
    init(
        coordinator: ReportDialogViewControllerCoordinator,
        dialogType: ReportDialogType
    ) {
        self.coordinator = coordinator
        self.dialogType = dialogType
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
        self.navigationItem.setHidesBackButton(true, animated: true)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        // 키보드 내리기
        let tapGesture = UITapGestureRecognizer(
            target: view,
            action: #selector(view.endEditing))
        view.addGestureRecognizer(tapGesture)
    
        view.addSubview(dialogView)
        dialogView.addSubview(xmarkButton)
        dialogView.addSubview(titleLabel)
        dialogView.addSubview(reportReasonButton1)
        dialogView.addSubview(reportReasonButton2)
        dialogView.addSubview(reportReasonButton3)
        dialogView.addSubview(reportReasonButton4)
        dialogView.addSubview(textView)
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
            make.width.equalTo(getTextSize(
                text: reportReasonButton1.labelText,
                font: .customFont(
                    forTextStyle: .footnote,
                    weight: .regular)).width + 30)
        }
        
        reportReasonButton2.snp.makeConstraints { make in
            make.top.equalTo(reportReasonButton1.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(getTextSize(
                text: reportReasonButton2.labelText,
                font: .customFont(
                    forTextStyle: .footnote,
                    weight: .regular)).width + 30)
        }
        
        reportReasonButton3.snp.makeConstraints { make in
            make.top.equalTo(reportReasonButton2.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(getTextSize(
                text: reportReasonButton3.labelText,
                font: .customFont(
                    forTextStyle: .footnote,
                    weight: .regular)).width + 30)
        }
        
        reportReasonButton4.snp.makeConstraints { make in
            make.top.equalTo(reportReasonButton3.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(getTextSize(
                text: reportReasonButton4.labelText,
                font: .customFont(
                    forTextStyle: .footnote,
                    weight: .regular)).width + 30)
        }
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(reportReasonButton4.snp.bottom).offset(ViewValues.defaultPadding)
            make.centerX.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(100)
        }
        
        blockButton.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(ViewValues.defaultPadding)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(getTextSize(
                text: blockButton.labelText,
                font: .customFont(
                    forTextStyle: .footnote,
                    weight: .regular)).width + 30)
        }
        
        explainMessageLabel.snp.makeConstraints { make in
            make.top.equalTo(blockButton.snp.bottom).offset(12)
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
        blockButton.addTarget(self,
                              action: #selector(clickBlockCheckButton(_:)),
                              for: .touchUpInside)
        xmarkButton.addTarget(self,
                              action: #selector(clickCloseButton(_:)),
                              for: .touchUpInside)
        reportButton.addTarget(self,
                                action: #selector(clickReportButton(_:)),
                                for: .touchUpInside)
    }

    private func getTextSize(text: String, font: UIFont) -> CGSize {
        let attributes: [NSAttributedString.Key: UIFont] = [.font: font]
        let textSize = (text as NSString).size(withAttributes: attributes)
        return textSize
    }
    
    // MARK: - Actions
    @objc private func clickCloseButton(_ sender: UIButton) {
        print("여기")
        coordinator?.didFinish()
        print("gh")
    }
    
    @objc private func clickReasonButton(_ sender: CustomUsedToReportViewButton) {
        switch sender.tag {
        case 1:
            didSelectCheckButton(reportReasonButton1)
        case 2:
            didSelectCheckButton(reportReasonButton2)
        case 3:
            didSelectCheckButton(reportReasonButton3)
        case 4:
            didSelectCheckButton(reportReasonButton4)
        default:
            break
        }
        updateReportButton()
    }
    
    @objc private func clickBlockCheckButton(_ sender: CustomUsedToReportViewButton) {
        didSelectCheckButton(sender)
    }
    
    @objc private func clickReportButton(_ sender: UIButton) {
        // TODO: - 신고
        // 현재는 화면 이동만 진행
        print("하이")
        coordinator?.didReport()
    }
}

// MARK: - Extension + Actions 관련 메서드
extension ReportDialogViewController {
    private func didSelectCheckButton(_ button: CustomUsedToReportViewButton) {
        if button.isSelected {
            updateNotSelectButton(button)
        } else {
            updateSelectButton(button)
        }
    }
    
    private func updateSelectButton(_ button: CustomUsedToReportViewButton) {
        button.updateImage(for: .selected)
        button.isSelected = true
    }
    
    private func updateNotSelectButton(_ button: CustomUsedToReportViewButton) {
        button.updateImage(for: .normal)
        button.isSelected = false
    }
    
    private func checkReportButtonEnable() -> Bool {
        return [reportReasonButton1, reportReasonButton2,
                reportReasonButton3, reportReasonButton4]
            .contains { $0.isSelected == true }
    }
    
    private func updateReportButton() {
        if checkReportButtonEnable() {
            reportButton.isEnabled = true
            reportButton.backgroundColor = DesignSystemAsset.mainColor.color
        } else {
            reportButton.isEnabled = false
            reportButton.backgroundColor = DesignSystemAsset.gray01.color
        }
    }
}

// MARK: - Extension + TextView
extension ReportDialogViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == DesignSystemAsset.gray01.color else { return }
        textView.text = ""
        textView.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text == "") {
            textView.text = AppLocalized.reportDialogPlaceholderText
            textView.textColor = DesignSystemAsset.gray01.color
        }
    }
}
