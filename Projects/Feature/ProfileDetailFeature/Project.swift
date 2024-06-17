//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 6/17/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "ProfileDetailFeature",
    moduleType: .feature,
    dependencies: [
        .featureDependency,
    ]
)
