//
//  LocationListView.swift
//  TravelSchedule
//
//  Created by Danil Kazakov on 18.06.2025.
//

import SwiftUI

struct LocationListView<Item: Identifiable>: View {
    let items: [Item]
    let itemTitle: (Item) -> String
    let onItemTap: (Item) -> Void
    
    var body: some View {
        List(items) { item in
            ListRowButton(title: itemTitle(item)) {
                onItemTap(item)
            }
            .listRowSeparator(.hidden, edges: .all)
            .padding(.vertical)
        }
    }
}

#Preview {
    LocationListView(
        items: [
            Station(
                name: "Station 1", code: "1234"
            ),
            Station(name: "Station 2", code: "123")
        ]
    ) { station in
        station.name
    } onItemTap: { station in
        print("Tapped on \(station.name)")
    }
}
