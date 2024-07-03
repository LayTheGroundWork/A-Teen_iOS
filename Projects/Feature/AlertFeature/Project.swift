//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 7/3/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "AlertFeature",
    moduleType: .feature,
    dependencies: [
        .featureDependency,
    ]
)
