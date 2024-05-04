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

let project = Project(
    name: "MetroTime",
    targets: [
        .target(
            name: "MetroTime",
            destinations: .iOS,
            product: .app,
            productName: "MetroTime",
            bundleId: "de.JonasFrey.MetroTime",
            deploymentTargets: .iOS("16.0"),
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchStoryboardName": "LaunchScreen.storyboard",
                ]
            ),
            sources: ["MetroTime/Sources/**"],
            resources: ["MetroTime/Resources/**"],
            scripts: [.post(script: swiftLintScript, name: "SwiftLint", basedOnDependencyAnalysis: false)],
            dependencies: [
                .external(name: "XMLCoder", condition: nil),
                .external(name: "JFUtils", condition: nil),
                .target(name: "AppFoundation"),
                .target(name: "AppNetworking"),
                .target(name: "AppDomain"),
                .target(name: "AppData"),
            ],
            settings: .settings(
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
        ),
    ] +
    createTargets(for: "AppFoundation") +
    createTargets(for: "AppNetworking", dependsOn: ["AppFoundation"]) +
    createTargets(for: "AppDomain", dependsOn: ["AppFoundation"]) +
    createTargets(for: "AppData", dependsOn: ["AppFoundation", "AppDomain"]),
    schemes: [
        .scheme(
            name: "MetroTime",
            testAction: .testPlans([.relativeToRoot("MetroTime/Resources/MetroTime.xctestplan")]),
            runAction: .runAction(configuration: .debug, executable: .target("MetroTime"))
        )
    ]
)

private func createTargets(for modules: [String], dependsOn dependencies: [String] = []) -> [Target] {
    modules.flatMap { createTargets(for: $0, dependsOn: dependencies) }
}

private func createTargets(for module: String, dependsOn dependencies: [String] = []) -> [Target] {
    [
        .target(
            name: module,
            destinations: .iOS,
            product: .framework,
            bundleId: "de.JonasFrey.MetroTime.\(module)",
            infoPlist: .default,
            sources: ["Modules/\(module)/Sources/**"],
            resources: [],
            dependencies: dependencies.map { .target(name: $0, condition: nil) }
        ),
        .target(
            name: "\(module)Tests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "de.JonasFrey.MetroTime.\(module)Tests",
            infoPlist: .default,
            sources: ["Modules/\(module)/Tests/**"],
            resources: [],
            dependencies: [
                .target(name: module),
            ]
        ),
    ]
}
