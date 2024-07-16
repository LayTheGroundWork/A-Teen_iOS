//
//  AppContainer.swift
//  ATeen
//
//  Created by 최동호 on 5/15/24.
//

import Foundation

public final class AppContainer {
    static var storage: [String: Any] = [:]
    private static let queue = DispatchQueue(label: "AppContainerQueue", attributes: .concurrent)
    
    public static func register<T>(type: T.Type, _ object: T) {
          queue.async(flags: .barrier) {
              storage[String(describing: type)] = object
          }
      }
    
    public static func resolve<T>(type: T.Type) -> T {
        var result: T?
        queue.sync {
            result = storage[String(describing: type)] as? T
        }
        guard let object = result else {
            fatalError("register 되지 않은 객체 호출: \(type)")
        }
        return object
    }
}
