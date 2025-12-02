//
//  GroupSelectionView.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 12/1/25.
//

import SwiftUI

struct GroupSelectionView: View {
    @Binding var selectedGroups: [String]

    let allGroups = [
        "Torah", "Historical Books", "Wisdom",
        "Major Prophets", "Minor Prophets",
        "Gospels", "Acts", "Epistles", "Revelation"
    ]

    var body: some View {
        NavigationStack {
            List {
                ForEach(allGroups, id: \.self) { group in
                    Toggle(group, isOn: Binding(
                        get: { selectedGroups.contains(group) },
                        set: { isOn in
                            if isOn {
                                selectedGroups.append(group)
                            } else {
                                selectedGroups.removeAll { $0 == group }
                            }
                        }
                    ))
                }
            }
            .navigationTitle("Select Groups")
        }
    }
}


/*
#Preview {
    GroupSelectionView(selectedGroups: ["Major Prophets"])
}*/
