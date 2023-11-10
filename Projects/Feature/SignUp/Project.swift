<<<<<<< HEAD
=======
//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 강민성 on 11/6/23.
//

>>>>>>> develop
import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.SignUp.rawValue,
    targets: [
        .feature(
            interface: .SignUp,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .SignUp,
            factory: .init(
                dependencies: [
                    .feature(interface: .SignUp)
                ]
            )
        )
    ]
)
<<<<<<< HEAD

=======
>>>>>>> develop
