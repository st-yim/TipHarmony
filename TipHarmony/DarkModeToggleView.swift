//
//  DarkModeToggleView.swift
//  TipSplitter
//
//  Created by Steven Yim on 1/11/24.
//

import SwiftUI

// DarkModeToggleView is a SwiftUI view responsible for rendering the dark mode toggle button.
struct DarkModeToggleView: View {
    @Binding var isDarkMode: Bool // Binding to control the dark mode state
    
    var body: some View {
        Button(action: {
            isDarkMode.toggle() // Toggle the dark mode state on button tap
        }) {
            Image(systemName: isDarkMode ? "moon.fill" : "sun.max.fill")
                .foregroundColor(isDarkMode ? .white : .yellow)
                // Use moon.fill icon for dark mode, sun.max.fill for light mode
        }
    }
}
