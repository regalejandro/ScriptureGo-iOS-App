//
//  ContentView.swift
//  ScripturePal
//
//  Created by Alejandro Regalado on 11/17/25.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false

    @State private var selection = 0
    @State private var reveal: RevealItem?

    /// Owned here so the "start the next book?" popup survives BookDetailView
    /// being popped by "Done Reading".
    @StateObject private var nextBookPrompt = NextBookPrompt()

    var body: some View {
        ZStack {
            TabView(selection: $selection) {

                SelectorView(onReveal: { chapter, translation in
                    reveal = RevealItem(chapter: chapter, translation: translation)
                })
                    .tabItem {
                        Label("Select", systemImage: "rays")
                    }
                    .tag(0)

                LibraryView()
                    .tabItem {
                        Label("Library", systemImage: selection == 1 ? "books.vertical.fill" : "books.vertical")
                            .environment(\.symbolVariants, .none)
                    }
                    .tag(1)

                StatsView()
                    .tabItem {
                        Label("Stats", systemImage: selection == 2 ? "chart.bar.fill" : "chart.bar")
                            .environment(\.symbolVariants, .none)
                    }
                    .tag(2)
            }
            .tint(themeManager.current.primary)
            .environmentObject(nextBookPrompt)

            // Full-screen chapter reveal rendered in-hierarchy
            if let reveal {
                ChapterRevealView(
                    chapter: reveal.chapter,
                    translation: reveal.translation,
                    onDismiss: { self.reveal = nil }
                )
                .transition(.opacity)
                .zIndex(1)
            }

            // "Start the next book?" popup, above everything else.
            if let next = nextBookPrompt.pending {
                NextBookPromptView(
                    book: next,
                    finishedBookName: nextBookPrompt.finishedBookName,
                    onClose: { nextBookPrompt.dismiss() }
                )
                // Plain fade: the dimming backdrop is part of this view, and
                // scaling it would show its edges sliding in as a rectangle.
                // The card does its own scale-in from inside.
                .transition(.opacity)
                .zIndex(2)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: reveal?.id)
        .animation(.easeInOut(duration: 0.25), value: nextBookPrompt.pending?.canonicalKey)
        .onAppear {
            themeManager.apply(systemScheme: colorScheme)
        }
        .onChange(of: colorScheme) {
            themeManager.apply(systemScheme: colorScheme)
        }
        // Shown once on first launch; OnboardingView flips the same
        // AppStorage flag when finished, which dismisses this automatically.
        .fullScreenCover(isPresented: Binding(
            get: { !hasCompletedOnboarding },
            set: { isShowing in hasCompletedOnboarding = !isShowing }
        )) {
            OnboardingView()
                .environmentObject(themeManager)
        }
    }
}

/// A pending chapter reveal presented over the whole app.
private struct RevealItem: Identifiable {
    let id = UUID()
    let chapter: ChapterPointer
    let translation: String
}

#Preview {
    ContentView()
        .environmentObject(ThemeManager())
}
