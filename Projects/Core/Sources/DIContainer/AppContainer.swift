//
//  AppContainer.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

public struct AppContainer {
    static var storage: [String: Any] = [:]

    public init() { }
    public var auth = Auth()
    
    public static func register<T>(type: T.Type, _ object: T) {
        storage["\(type)"] = object
    }
    
    static func resolve<T>(type: T.Type) -> T {
        guard let object = storage["\(type)"] as? T else {
            fatalError("register 되지 않은 객체 호출: \(type)")
        }
        return object
    }
}
