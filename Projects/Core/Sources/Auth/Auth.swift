//
//  Auth.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//
import Foundation

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
    private let sessionKey = "isSessionActive"
    
    private var session: UserDefaults

    public init(session: UserDefaults = .standard) {
        self.session = session
    }
}

extension Auth: SessionCheckAuth {
    public var isSessionActive: Bool {
        return session.bool(forKey: sessionKey)
    }
}

extension Auth: LogInAuth {
    public func logIn() {
        session.set(true, forKey: sessionKey)
    }
}

extension Auth: LogOutAuth {
    public func logOut() {
        session.set(false, forKey: sessionKey)
    }
}
