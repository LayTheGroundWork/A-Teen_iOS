//
//  LogInViewModel.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

final class LogInViewModel {
    var logInAuth: LogInAuth?
    
    init(logInAuth: LogInAuth? = nil) {
        self.logInAuth = logInAuth
    }
    
    func login() {
        logInAuth?.logIn()
    }
}
