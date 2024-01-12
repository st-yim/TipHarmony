//
//  CustomTipView.swift
//  TipSplitter
//
//  Created by Steven Yim on 1/11/24.
//

import SwiftUI

// CustomTipView is a SwiftUI view representing a custom tip input overlay.
struct CustomTipView: View {
    @Binding var customTipAmount: String // Binding for custom tip amount input
    @Binding var shouldCalculate: Bool // Binding to trigger calculation
    @Binding var isActive: Bool // Binding to track the view's active state
    @Binding var isCustomTipAmountEntered: Bool // Binding to track if custom tip amount is entered
    @Binding var isDarkMode: Bool // Binding to control dark mode

    var customTipAmountDouble: Double {
        return Double(customTipAmount) ?? 0.0
    }

    var body: some View {
        VStack {
            HStack {
                TextField("Custom Tip (%)", text: $customTipAmount, onEditingChanged: { isEditing in
                    isCustomTipAmountEntered = isEditing
                })
                .keyboardType(.decimalPad)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            }
            HStack {
                Button("Close") {
                    if !isCustomTipAmountEntered {
                        hideKeyboard()
                        isActive = false
                    }
                }
                .disabled(isCustomTipAmountEntered)
                .font(.headline)
                .foregroundColor(Color.blue) // Set text color to blue
                .padding()

                Button("Reset") {
                    if !isCustomTipAmountEntered {
                        customTipAmount = ""
                    }
                }
                .disabled(isCustomTipAmountEntered)
                .font(.headline)
                .foregroundColor(.red)
                .padding()
            }
        }
        .background(isDarkMode ? Color.offWhite.edgesIgnoringSafeArea(.all) : Color.lightBlue.edgesIgnoringSafeArea(.all))
        // Background color based on dark mode state

        .opacity(isActive ? 1 : 0) // Show or hide the view based on isActive
        .cornerRadius(10)
        .padding()
    }
}
