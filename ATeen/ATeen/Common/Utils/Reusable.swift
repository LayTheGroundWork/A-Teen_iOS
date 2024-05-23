//
//  Reusable.swift
//  ATeen
//
//  Created by 최동호 on 5/17/24.
//

protocol Reusable { }

extension Reusable {
    static var reuseIdentifier: String { String(describing: self) }
}
