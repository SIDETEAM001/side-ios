//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 강민성 on 3/3/24.
//

import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let targets: [Target] = [
    .flow(
        factory: .init(
            dependencies: [
                .feature
            ]
        )
    )
]


let project: Project = .makeModule(
    name: "Flow",
    targets: targets
)
