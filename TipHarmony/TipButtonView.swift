//
//  TipButtonView.swift
//  TipSplitter
//
//  Created by Steven Yim on 1/11/24.
//

import SwiftUI

// TipButtonView is a SwiftUI view representing a button for selecting tip percentages.
struct TipButtonView: View {
    let percentage: Int // Tip percentage value
    @Binding var selectedTipPercentage: Int? // Binding for tracking the selected tip percentage

    var body: some View {
        Button(action: {
            if selectedTipPercentage == percentage {
                selectedTipPercentage = nil // Deselect if already selected
            } else {
                selectedTipPercentage = percentage // Set selected tip
            }
        }) {
            Text("\(percentage)%")
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    selectedTipPercentage == percentage ?
                    Color.blue.opacity(0.8) :
                    Color.blue
                )
                .foregroundColor(.white)
                .cornerRadius(8)
                // Display the tip percentage as a button with styling based on selection state
        }
    }
}
