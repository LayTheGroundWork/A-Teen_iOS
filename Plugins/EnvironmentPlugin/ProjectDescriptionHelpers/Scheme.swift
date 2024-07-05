//
//  Scheme.swift
//  EnvironmentPlugin
//
//  Created by 최동호 on 7/5/24.
//

import ProjectDescription

public extension Scheme {
    static func moduleScheme(name: String) -> Self {
        Scheme.scheme(
            name: name,
            shared: true,
            buildAction: .buildAction(targets: ["\(name)"]),
            runAction: .runAction(configuration: .debug),
            archiveAction: .archiveAction(configuration: .release)
        )
    }
}
