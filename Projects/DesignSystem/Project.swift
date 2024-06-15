//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 6/14/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "DesignSystem",
    moduleType: .dynamicFramework,
    hasResource: true,
    dependencies: [
        .external(name: "SnapKit")
    ]
)
