//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 7/2/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "MediaEditorFeature",
    moduleType: .feature,
    dependencies: [
        .featureDependency,
    ]
)
