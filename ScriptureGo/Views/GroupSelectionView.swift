//
//  GroupSelectionView.swift
//  ScriptureGo
//
//  Created by Alejandro Regalado on 12/1/25.
//

import SwiftUI

struct GroupSelectionView: View {
    @Binding var selectedGroups: [String]
    @Binding var groupMode: String  // "all" or "custom"
    
    let allGroups: [String]
    
    var body: some View {
        NavigationStack {
            Form {

                // MARK: - MODE SELECTION
                Section {
                    Button {
                        groupMode = "all"
                        selectedGroups = allGroups // include everything
                    } label: {
                        HStack {
                            Text("Include All Books")
                                .foregroundColor(Color.primary)
                            Spacer()
                            if groupMode == "all" {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }

                    Button {
                        groupMode = "custom"
                        if selectedGroups.isEmpty {
                            selectedGroups = [] // start empty
                        }
                    } label: {
                        HStack {
                            Text("Custom Selection")
                                .foregroundColor(Color.primary)
                            Spacer()
                            if groupMode == "custom" {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }

                // MARK: - CUSTOM GROUPS
                if groupMode == "custom" {
                    Section("Choose Sections") {
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
                }
                
                if groupMode == "custom" {
                    if selectedGroups.count < allGroups.count {
                        Button {
                            selectedGroups = allGroups
                        } label: {
                            HStack {
                                Text("Select All")
                                Spacer()
                            }
                        }
                    }
                    if selectedGroups.count > 0{
                        Button {
                            
                            selectedGroups = []
                        } label: {
                            HStack {
                                Text("Deselect All")
                                Spacer()
                            }
                        }
                    }
                }


            }
            .navigationTitle("Section Filtering")
        }
    }
}


/*
#Preview {
    GroupSelectionView(selectedGroups: ["Major Prophets"])
}*/
