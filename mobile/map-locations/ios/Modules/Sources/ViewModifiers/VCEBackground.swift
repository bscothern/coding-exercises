//
//  VCEBackground.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/26/24.
//

import Resources
import SwiftUI

// Using VCE for Voze Coding Exercise

extension View {
    /// Applies the common background the the current view.
    ///
    /// - Returns: The current view with the common background added to it.
    @inlinable
    public func vceBackground() -> some View {
        // Using a view modifier instead of just doing the work here helps the compiler manage Opaque Types better for compilation time.
        // It also lets you abstract out the logic into the ViewModifier type because they can become complex if they are doing more tricky things than this is.
        modifier(VCEBackground())
    }
}

@usableFromInline
struct VCEBackground: ViewModifier {
    @usableFromInline
    init() {}

    @usableFromInline
    func body(content: Content) -> some View {
        content
            .background {
                // This adds a tiled image to the background of everything with just a bit of opacity so it adds some texture.
                // This makes it feel a little off from just standard cookie cutter UI which can help it feel polished
                Image("Background", bundle: .package)
                    .resizable(resizingMode: .tile)
                    .opacity(0.2)
                    .ignoresSafeArea()
            }
    }
}
