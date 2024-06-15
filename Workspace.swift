
import DependencyPlugin
import EnvironmentPlugin
import ProjectDescription

let workspace = Workspace(
    name: .appName,
    projects: [
        "Projects/**",
    ],
    additionalFiles: [
          "README.md",
      ]
)
