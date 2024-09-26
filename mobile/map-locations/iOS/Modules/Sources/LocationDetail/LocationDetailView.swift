//
//  LocationDetailView.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/26/24.
//

import Common
import Resources
import SwiftUI

public struct LocationDetailView: View {
    let location: Location
    
    @Binding
    var selectedBinding: Int?
    
    public var body: some View {
        Color.red
            .presentationDetents([.fraction(0.4)])
            .onDisappear {
                // Without the withAnimation block this just snaps back and feels/looks bad.
                withAnimation {
                    selectedBinding = nil
                }
            }
    }
    
    public init(for location: Location, selected selectedBinding: Binding<Int?>) {
        self.location = location
        self._selectedBinding = selectedBinding
    }
}
