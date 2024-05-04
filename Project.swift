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
    ]),
    schemes: [
        .scheme(
            name: "MetroTime",
            testAction: .testPlans([.relativeToRoot("MetroTime/Resources/MetroTime.xctestplan")]),
            runAction: .runAction(configuration: .debug, executable: .target("MetroTime"))
        )
    ]
)
