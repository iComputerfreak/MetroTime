import ProjectDescription

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
            scripts: [.pre(script: """
            if [[ "$(uname -m)" == arm64 ]]; then
                export PATH="/opt/homebrew/bin:$PATH"
            fi

            if which swiftlint > /dev/null; then
              swiftlint
            else
              echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
            fi
            """, name: "SwiftLint", basedOnDependencyAnalysis: false)],
            dependencies: [
                .external(name: "JFSwiftUI", condition: nil),
                .external(name: "XMLCoder", condition: nil),
            ]
        ),
        .target(
            name: "MetroTimeTests",
            destinations: .iOS,
            product: .unitTests,
            bundleId: "io.tuist.MetroTimeTests",
            infoPlist: .default,
            sources: ["MetroTime/Tests/Sources/**"],
            resources: ["MetroTime/Tests/Resources/**"],
            dependencies: [.target(name: "MetroTime")]
        ),
    ]
)
