//
//  Bundle+package.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import Foundation
import SwiftUIPreviewBundleFinder
import SwiftUI

// SwiftUI previews don't load resources properly from other module bundles still...
// So this is a little helper that makes it so you can use Bundle.package and it will be found in previews and the correct bundles will also be found at runtime.
// The SwiftUIPreviewBundleFinder library does the real work this just gives it the info it needs to function in this package.
// SwiftUIPreviewBundleFinder is a library I wrote and use in all my personal projects and my previous job implemented the code directly into their code base since it is MIT licensed.
extension Bundle {
    @usableFromInline
    class _CurrentBundleFinder: BundleFinder {
        @usableFromInline
        static let packageName: String = "Modules"

        @usableFromInline
        static let moduleName = String(#fileID.split(separator: "/")[0])

        @usableFromInline
        static let packageModule: Bundle = .module
    }

    @inlinable
    public static var package: Bundle { .bundleFinder(_CurrentBundleFinder.self) }
}
