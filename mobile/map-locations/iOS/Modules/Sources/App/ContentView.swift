//
//  ContentView.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/25/24.
//

import SwiftUI
import Resources

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!", bundle: .package)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
