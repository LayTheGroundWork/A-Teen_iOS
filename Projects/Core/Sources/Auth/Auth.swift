//
//  Auth.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//
public protocol SessionCheckAuth {
    var isSessionActive: Bool { get }
}

public protocol LogInAuth {
    func logIn()
}

public protocol LogOutAuth {
    func logOut()
}

public final class Auth {
    private var session = false
}

extension Auth: SessionCheckAuth {
    public var isSessionActive: Bool {
        session
    }
}

extension Auth: LogInAuth {
    public func logIn() {
        session = true
    }
}

extension Auth: LogOutAuth {
    public func logOut() {
        session = false
    }
}
