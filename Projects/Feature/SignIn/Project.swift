import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.SignIn.rawValue,
    targets: [
        .feature(
            interface: .SignIn,
            factory: .init(
                dependencies: [
                    .domain
                ]
            )
        ),
        .feature(
            implements: .SignIn,
            factory: .init(
                dependencies: [
                    .feature(interface: .SignIn)
                ]
            )
        )
    ]
)
