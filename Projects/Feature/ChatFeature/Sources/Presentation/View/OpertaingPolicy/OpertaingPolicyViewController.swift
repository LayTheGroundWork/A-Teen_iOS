//
//  OpertaingPolicyModalViewController.swift
//  ChatFeature
//
//  Created by 김명현 on 9/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import SnapKit

import Common
import DesignSystem
import UIKit
import WebKit

public protocol OpertaingPolicyViewControllerCoordinator: AnyObject {
    func didFinish()
}

public final class OpertaingPolicyViewController: UIViewController {
    // MARK: - Private properties
    weak var coordinator: OpertaingPolicyViewControllerCoordinator?
    
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(DesignSystemAsset.xMarkIcon.image, for: .normal)
        button.addTarget(self, action: #selector(clickCloseButton(_:)), for: .touchUpInside)
        return button
    }()

    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.navigationDelegate = self
        return view
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Life Cycle
    public init(coordinator: OpertaingPolicyViewControllerCoordinator) {
        self.coordinator = coordinator
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        configUserInterface()
        configLayout()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadContent()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        webView.navigationDelegate = nil
        webView.uiDelegate = nil
    }
    
    // MARK: - Helpers
    private func configUserInterface() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        view.backgroundColor = .systemBackground
        view.addSubview(closeButton)
        view.addSubview(webView)
        view.addSubview(activityIndicator)
    }
    
    private func configLayout() {
        closeButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(ViewValues.defaultPadding)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.height.equalTo(24)
        }
        
        webView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(closeButton.snp.bottom).offset(ViewValues.defaultPadding)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    public func loadContent() {
        activityIndicator.startAnimating()
        
        guard let url = URL(string: "https://www.google.com") else {
            print("URL 오류")
            return
        }
        
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    @objc func clickCloseButton(_ sender: UIButton){
        webView.loadHTMLString("", baseURL: nil)
        webView.navigationDelegate = nil
        webView.uiDelegate = nil
        webView.removeFromSuperview()
        WKWebsiteDataStore.default().removeData(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes(), modifiedSince: Date.distantPast) { [weak self] in
            self?.coordinator?.didFinish()
        }
    }
}

extension OpertaingPolicyViewController: WKNavigationDelegate {
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }

    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}
