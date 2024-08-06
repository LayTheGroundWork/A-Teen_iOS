//
//  ChatPresnetationController.swift
//  ChatFeature
//
//  Created by 김명현 on 8/5/24.
//  Copyright © 2024 ATeen. All rights reserved.
//

import UIKit
import DesignSystem

public final class ChatPresentationController: UIPresentationController {
    private var dimmingView: UIView!
    private var gestureRecognizer: UIPanGestureRecognizer!

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        setupDimmingView()
        setGestureRecognizer()
    }
    
    private func setupDimmingView() {
        dimmingView = UIView()
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        dimmingView.alpha = 0
        dimmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped(_:))))
    }
    
    private func setGestureRecognizer() {
        gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handleGesture(_:)))
        presentedViewController.view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc private func dimmingViewTapped(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    @objc private func handleGesture(_ sender: UIPanGestureRecognizer) {
        // 스와이프 제스쳐로 modal dismiss
        let translation = sender.translation(in: presentedView)
        
        switch sender.state {
        case .changed:
            if translation.y > 0 {
                presentedView?.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended:
            if translation.y > 60 {
                presentingViewController.dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.presentedView?.transform = .identity
                }
            }
        default:
            break
        }
    }

    public override var frameOfPresentedViewInContainerView: CGRect {
        // modal 크기, 높이 조절
        guard let containerView = containerView else { return .zero }
        let screenBounds = containerView.bounds
        let size = CGSize(width: screenBounds.width, height: screenBounds.height * 0.18)
        let origin = CGPoint(x: 0, y: screenBounds.height - size.height)
        return CGRect(origin: origin, size: size)
    }

    override public func presentationTransitionWillBegin() {
        // modal이 나왔을때 설정
        guard let containerView = containerView else { return }
        dimmingView.frame = containerView.bounds
        containerView.insertSubview(dimmingView, at: 0)
        
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        })
    }
    
    override public func dismissalTransitionWillBegin() {
        // // modal이 사라졌을때 설정
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0
            return
        }
        
        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        })
    }
    
    override public func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        guard let containerView = containerView else { return }
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
}
