import ProjectDescription

let swiftLintScript = """
if [[ "$(uname -m)" == arm64 ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
fi

if which swiftlint > /dev/null; then
swiftlint
else
echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
"""

let deploymentTarget: DeploymentTargets = .iOS("17.0")

private let mainTarget: Target = .target(
    name: "MetroTime",
    destinations: .iOS,
    product: .app,
    productName: "MetroTime",
    bundleId: "de.JonasFrey.MetroTime",
    deploymentTargets: deploymentTarget,
    infoPlist: .extendingDefault(
        with: [
            "UILaunchStoryboardName": "LaunchScreen.storyboard",
        ]
    ),
    sources: ["MetroTime/Sources/**"],
    resources: ["MetroTime/Resources/**"],
    scripts: [.post(script: swiftLintScript, name: "SwiftLint", basedOnDependencyAnalysis: false)],
    dependencies: [
        .external(name: "XMLCoder"),
        .external(name: "JFUtils"),
        .external(name: "Factory"),
        .external(name: "JamitFoundation"),
        .external(name: "UserDefaults"),
        .target(name: "AppFoundation"),
        .target(name: "AppNetworking"),
        .target(name: "AppDomain"),
        .target(name: "AppData"),
    ],
    settings: .settings(
        base: SettingsDictionary()
            .automaticCodeSigning(devTeam: "46C9Y785NA"),
        configurations: [
            .debug(
                name: .debug,
                xcconfig: .relativeToRoot("MetroTime/Resources/Build.xcconfig")
            ),
            .release(
                name: .release,
                xcconfig: .relativeToRoot("MetroTime/Resources/Build.xcconfig")
            ),
        ]
    )
)

private let testsTarget: Target = .target(
    name: "MetroTimeTests",
    destinations: .iOS,
    product: .unitTests,
    bundleId: "de.JonasFrey.MetroTimeTests",
    infoPlist: .default,
    sources: ["MetroTime/Tests/Sources/**"],
    resources: ["MetroTime/Tests/Resources/**"],
    dependencies: [
        .target(name: "MetroTime"),
    ]
)

let project = Project(
    name: "MetroTime",
    targets: [
        mainTarget,
        testsTarget,
    ] +
    createTargets(for: "AppFoundation") +
    createTargets(for: "AppNetworking", dependsOn: [.target(name: "AppFoundation")]) +
    createTargets(for: "AppDomain", dependsOn: [.target(name: "AppFoundation")]) +
    createTargets(
        for: "AppData",
        dependsOn: [
            .target(name: "AppFoundation"),
            .target(name: "AppDomain"),
            .external(name: "JamitFoundation"),
            .external(name: "UserDefaults"),
        ]
    ),
    schemes: [
        .scheme(
            name: "MetroTime",
            testAction: .testPlans([.relativeToRoot("MetroTime/Resources/MetroTime.xctestplan")]),
            runAction: .runAction(configuration: .debug, executable: .target("MetroTime"))
        )
    ]
)

private func createTargets(for modules: [String], dependsOn dependencies: [TargetDependency] = []) -> [Target] {
    modules.flatMap { createTargets(for: $0, dependsOn: dependencies) }
}

private func createTargets(for module: String, dependsOn dependencies: [TargetDependency] = []) -> [Target] {
    [
        .target(
            name: module,
            destinations: .iOS,
            product: .framework,
            bundleId: "de.JonasFrey.MetroTime.\(module)",
            deploymentTargets: deploymentTarget,
            infoPlist: .default,
            sources: ["Modules/\(module)/Sources/**"],
            resources: ["Modules/\(module)/Resources/**"],
            dependencies: dependencies,
            settings: .settings(
                base: SettingsDictionary()
                    .automaticCodeSigning(devTeam: "46C9Y785NA"),
                configurations: [
                    .debug(
                        name: .debug,
                        xcconfig: .relativeToRoot("MetroTime/Resources/Build.xcconfig")
                    ),
                    .release(
                        name: .release,
                        xcconfig: .relativeToRoot("MetroTime/Resources/Build.xcconfig")
                    ),
                ]
            )
        ),
        .target(
            name: "\(module)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "de.JonasFrey.MetroTime.\(module)Tests",
            infoPlist: .default,
            sources: ["Modules/\(module)/Tests/**"],
            resources: ["Modules/\(module)/Tests/Resources/**"],
            dependencies: [
                .target(name: module),
            ]
        ),
    ]
}
