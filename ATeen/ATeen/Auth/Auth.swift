//
//  Auth.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//
protocol SessionCheckAuth {
    var isSessionActive: Bool { get }
}

protocol LogInAuth {
    func logIn()
}

protocol LogOutAuth {
    func logOut()
}

final class Auth {
    private var session = false

}

extension Auth: SessionCheckAuth {
    var isSessionActive: Bool {
        session
    }
}

extension Auth: LogInAuth {
    func logIn() {
        session = true
    }
}

extension Auth: LogOutAuth {
    func logOut() {
        session = false
    }
}
