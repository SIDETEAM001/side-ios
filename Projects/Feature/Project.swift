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
