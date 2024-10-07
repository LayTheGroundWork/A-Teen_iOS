//
//  OpertaingPolicyModalViewController.swift
//  ChatFeature
//
//  Created by 김명현 on 9/27/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit
import WebKit

public protocol OpertaingPolicyModalViewControllerCoordinator: AnyObject {
    func didFinish()
}

public final class OpertaingPolicyModalViewController: UIViewController, UIAdaptivePresentationControllerDelegate {
    // MARK: - Private properties
    weak var coordinator: OpertaingPolicyModalViewControllerCoordinator?
    public var webView: WKWebView?
    
    public lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.center = view.center
        indicator.hidesWhenStopped = true
        view.addSubview(indicator)
        return indicator
    }()
    
    // MARK: - Life Cycle
    public init(coordinator: OpertaingPolicyModalViewControllerCoordinator?) {
        super.init(nibName: nil, bundle: nil)
        self.coordinator = coordinator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        // webView loading indicator delegate 설정
        presentationController?.delegate = self
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        coordinator?.didFinish()
        cleanupWebView()
    }
    
    // MARK: - Helpers
    private func setupWebView() {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.processPool = WKProcessPool()
        
        webView = WKWebView(frame: view.bounds, configuration: webConfiguration)
        webView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        if let webView = webView {
            view.addSubview(webView)
        }
    }
    
    private func cleanupWebView() {
        webView?.stopLoading()
        webView?.navigationDelegate = nil
        webView?.uiDelegate = nil
        webView?.removeFromSuperview()
        webView = nil
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {
                    print("\(record.displayName) 데이터 삭제 완료")
                })
            }
        }
    }
    
    public func loadContent(url: URL) {
        activityIndicator.startAnimating()
        let request = URLRequest(url: url)
        webView?.load(request)
    }
}
