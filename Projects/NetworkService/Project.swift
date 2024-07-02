//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 최동호 on 6/27/24.
//

import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeProject(
    name: "NetworkService",
    moduleType: .dynamicFramework,
    dependencies: [
        .domain,
    ]
)
