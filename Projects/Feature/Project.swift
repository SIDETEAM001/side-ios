import ProjectDescription
import ProjectDescriptionHelpers
import DependencyPlugin

let project = Project.makeModule(
    name: ModulePath.Feature.name+ModulePath.Feature.SignUp.rawValue,
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
            implements: .SignUp,
            factory: .init(
                dependencies: [
                    .feature(interface: .SignUp)
                ]
            )
        )
    ]
)
let targets: [Target] = [
    .feature(
        factory: .init(
            dependencies: [
                .domain,
                .feature(implements: .SignIn),
                .feature(implements: .SignUp)
            ]
        )
    )
]