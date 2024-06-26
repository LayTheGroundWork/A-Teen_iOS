//
//  Project.swift
//  CoreManifests
//
//  Created by 최동호 on 6/27/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "Domain",
    moduleType: .dynamicFramework,
    dependencies: [
        .core
    ]
)
