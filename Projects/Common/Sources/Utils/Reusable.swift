//
//  Reusable.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

public protocol Reusable { }

extension Reusable {
    public static var reuseIdentifier: String { String(describing: self) }
}
