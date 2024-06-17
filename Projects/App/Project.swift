//
//  Project.swift
//
//
//  Created by 최동호 on 6/5/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "App",
    moduleType: .app,
    dependencies: [
        .mainTabFeature,
        .core
    ]
)
