//
//  FilterPinsView.swift
//  Voze Coding Exercise
//
//  Created by Braden Scothern on 9/26/24.
//

import Common
import Resources
import SwiftUI
import ViewModifiers

public struct FilterPinsView: View {
    @Binding
    var filter: LocationTypeFilter

    public var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                VStack {
                    Text("FILTER_PINS.TITLE", bundle: .package)
                    
                    // In order to not cover the whole screen so you can see some immediate results a scroll view is needed.
                    // This makes it so you can see the map while only 40% of the screen is covered with the sheet.
                    ScrollView {
                        ForEach(Location.LocationType.Cases.allCases) { locationType in
                            Toggle(
                                isOn: .init(
                                    get: {
                                        filter.contains(locationType.filterValue)
                                    },
                                    set: { value in
                                        if value {
                                            filter.insert(locationType.filterValue)
                                        } else {
                                            filter.remove(locationType.filterValue)
                                        }
                                    }
                                )
                            ) {
                                HStack {
                                    Image(systemName: locationType.systemImage)
                                        .frame(width: 24)
                                    Text(verbatim: locationType.localizedDescription)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                }
                .frame(width: geometry.size.width * 0.8)
                .scrollBounceBehavior(.basedOnSize)
                
                Spacer()
            }
            .padding()
            .presentationDetents([.fraction(0.4)])
        }
        .vceBackground()
    }
    
    public init(filter: Binding<LocationTypeFilter>) {
        self._filter = filter
    }
}

#Preview {
    @Previewable
    @State
    var filter: LocationTypeFilter = .all

    Color.clear
        .sheet(isPresented: .constant(true)) {
            FilterPinsView(
                filter: $filter
            )
        }
}
