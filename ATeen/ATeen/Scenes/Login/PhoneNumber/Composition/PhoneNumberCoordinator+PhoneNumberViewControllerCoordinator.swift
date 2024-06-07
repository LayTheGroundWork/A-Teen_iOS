//
//  PhoneNumberCoordinator+PhoneNumberViewControllerCoordinator.swift
//  ATeen
//
//  Created by 최동호 on 5/31/24.
//

extension PhoneNumberCoordinator: PhoneNumberViewControllerCoordinator {
    func didFinish() {
        delegate?.didFinish(childCoordinator: self)
    }
    
    func didSelectResendCode() {
        // TODO: 코드 재전송
    }
}
