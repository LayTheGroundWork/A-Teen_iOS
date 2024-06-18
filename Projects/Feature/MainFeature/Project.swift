//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 6/14/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "MainFeature",
    moduleType: .feature,
    dependencies: [
        .featureDependency,
    ]
)