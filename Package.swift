//
//  Package.swift
//  HMDABackblazeB2
//
//  Created by Konstantinos Kontos on 17/12/2018.
//  Copyright © 2018 Handmade Apps Ltd. All rights reserved.
//

import PackageDescription

let package = Package(
    name: "HMDABackblazeB2",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "HMDABackblazeB2",
            type: .dynamic,
            targets: ["HMDABackblazeB2"]),
        ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(name: "HMDABackblazeB2",dependencies: [],path: "./HMDABackblazeB2"),
        //        .testTarget(name: "HMDAToolkitTests",dependencies: ["HMDAToolkit"],path: "./HMDAToolkit"),
    ]
)
