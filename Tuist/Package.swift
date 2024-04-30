// swift-tools-version: 5.9
import PackageDescription

#if TUIST
    import ProjectDescription

    let packageSettings = PackageSettings(
        // Customize the product types for specific package product
        // Default is .staticFramework
        // productTypes: ["Alamofire": .framework,] 
        productTypes: [
            "JFSwiftUI": .framework,
            "XMLCoder": .framework,
        ]
    )
#endif

let package = Package(
    name: "MetroTime",
    dependencies: [
        // Add your own dependencies here:
        // .package(url: "https://github.com/Alamofire/Alamofire", from: "5.0.0"),
        // You can read more about dependencies here: https://docs.tuist.io/documentation/tuist/dependencies
        .package(url: "https://github.com/iComputerfreak/JFSwiftUI", from: "1.2.0"),
        .package(url: "https://github.com/CoreOffice/XMLCoder", from: "0.17.1"),
    ]
)