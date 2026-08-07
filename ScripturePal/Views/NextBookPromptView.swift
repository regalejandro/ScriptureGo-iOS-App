//
//  NextBookPromptView.swift
//  ScripturePal
//
//  The "keep going?" prompt shown after a book is finished: BookDetailView's
//  completion alert hands off the next book in canonical order, and this popup
//  offers to start a reading session for it.
//
//  It's driven by a NextBookPrompt owned by ContentView rather than by the view
//  that triggers it, because "Done Reading" also pops BookDetailView off the
//  navigation stack — a popup presented from there would be torn down with it.
//  Living at the root lets the pop and the popup happen together.
//

import SwiftUI
import SwiftData
import Combine

// MARK: - NextBookPrompt

/// Root-level state for the next-book prompt. Set `pending` to offer a book.
final class NextBookPrompt: ObservableObject {

    /// The book being offered, or nil when no prompt is showing.
    @Published private(set) var pending: Book?

    /// Name of the book just finished, for the popup's lead-in line.
    @Published private(set) var finishedBookName = ""

    /// Offers `next` after finishing `finished`. Callers are responsible for
    /// skipping books the user is already reading.
    func offer(_ next: Book, after finished: String) {
        finishedBookName = finished
        pending = next
    }

    func dismiss() {
        pending = nil
    }
}

// MARK: - NextBookPromptView

/// Centered card asking whether to start the next book, over a dimmed backdrop.
struct NextBookPromptView: View {

    let book: Book
    let finishedBookName: String
    let onClose: () -> Void

    @EnvironmentObject var themeManager: ThemeManager
    @Environment(\.modelContext) private var modelContext

    /// Set once the book has been taken up, so the tile can morph into its
    /// "currently reading" state before the popup clears.
    @State private var started = false

    /// Drives the card's scale-in. Kept separate from the view's own
    /// transition so only the card scales — the backdrop just fades.
    @State private var appeared = false

    private var theme: Theme { themeManager.current }

    var body: some View {
        ZStack {
            // Backdrop. Tapping it declines, same as "Not Now".
            Color.black.opacity(0.35)
                .ignoresSafeArea()
                .onTapGesture { onClose() }

            VStack(spacing: 16) {

                Text("You finished \(finishedBookName)")
                    .font(.caption.weight(.medium))
                    .foregroundColor(theme.textSecondary)

                Text("Would you like to start reading \(book.name)?")
                    .font(.system(size: 22, weight: .semibold, design: .serif))
                    .foregroundColor(theme.textPrimary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)

                BookTile(
                    book: book,
                    size: .large,
                    height: LibraryTileSize.large.targetWidth * LibraryTileSize.large.aspectRatio,
                    isCurrentlyReading: started,
                    theme: theme
                )
                .frame(width: LibraryTileSize.large.targetWidth)
                .padding(.vertical, 2)

                VStack(spacing: 8) {
                    Button {
                        startReading()
                    } label: {
                        Text("Start Reading")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 46)
                    }
                    .glassProminentOrFallback(tint: theme.primary)

                    Button("Not Now") { onClose() }
                        .font(.subheadline.weight(.medium))
                        .foregroundColor(theme.textSecondary)
                        .padding(.vertical, 6)
                }
                .padding(.top, 2)
                // No second tap while the tile is morphing on its way out.
                .disabled(started)
            }
            .padding(22)
            .frame(maxWidth: 340)
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(theme.background)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(theme.secondary.opacity(0.9), lineWidth: 1)
            )
            .shadow(color: .black.opacity(0.18), radius: 20, y: 8)
            .padding(.horizontal, 32)
            .scaleEffect(appeared ? 1 : 0.92)
        }
        .onAppear {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                appeared = true
            }
        }
    }

    private func startReading() {
        guard !started else { return }
        modelContext.insert(CurrentlyReading(canonicalKey: book.canonicalKey))
        Haptics.addedToCurrentlyReading()

        // Let the tile's book symbol morph into the circled "currently
        // reading" one, then clear the popup once it's settled.
        withAnimation(.snappy(duration: 0.35)) { started = true }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { onClose() }
    }
}

#Preview {
    NextBookPromptView(
        book: Book(id: 47, name: "Mark", chapters: 16, groups: ["Gospels"], section: "NT", canonicalKey: "mark"),
        finishedBookName: "Matthew",
        onClose: {}
    )
    .environmentObject(ThemeManager())
}
