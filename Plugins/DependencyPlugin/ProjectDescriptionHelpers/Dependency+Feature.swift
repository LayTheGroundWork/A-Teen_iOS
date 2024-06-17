//
//  Dependency+Feature.swift
//  EnvironmentPlugin
//
//  Created by 최동호 on 6/14/24.
//

import ProjectDescription

public extension Array<TargetDependency> {
    enum Presentation: String, CaseIterable {
        case main, login, ranking, profile, chat, teen, profileDetail
        
        public var dependency: TargetDependency {
            var name = rawValue.map { $0 }
            name.removeFirst()
            name.insert(Character(rawValue.first!.uppercased()), at: 0)
            return presentationModule(name: "\(String(name))Feature")
        }
        
        private func presentationModule(name: String) -> TargetDependency {
            .project(
                target: "\(name)",
                path: .relativeToRoot("Projects/Feature/\(name)")
            )
        }
    }
}
