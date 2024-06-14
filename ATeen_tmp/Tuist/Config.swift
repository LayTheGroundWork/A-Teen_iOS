//
//  Config.swift
//  tuist-ExampleManifests
//
//  Created by 최동호 on 6/5/24.
//

import ProjectDescription

let config = Config(
    compatibleXcodeVersions: .all,
    plugins: [
        .local(path: .relativeToRoot("Plugins/EnvironmentPlugin")),
        .local(path: .relativeToRoot("Plugins/DependencyPlugin"))
    ],
    generationOptions: .options()
)
