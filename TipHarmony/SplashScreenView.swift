//
//  SplashScreenView.swift
//  TipSplitter
//
//  Created by Steven Yim on 1/9/24.
//

import SwiftUI

// SplashScreenView is a SwiftUI view representing the splash screen.
struct SplashScreenView: View {
    @State private var isActive = false // State variable to track whether to transition to ContentView
    @State private var size = 0.8 // Initial size for scaling animation
    @State private var opacity = 0.5 // Initial opacity for fading animation
    
    var body: some View {
        if isActive {
            ContentView() // Transition to ContentView when isActive is true
        } else {
            VStack {
                VStack {
                    // Splash screen content with scaling and fading animation
                    Image(systemName: "person.3")
                        .font(.system(size: 80))
                        .foregroundColor(.blue)
                    Text("TipSplitter")
                        .font(Font.custom("Baskerville-Bold", size: 26))
                        .foregroundColor(.black.opacity(0.80))
                }
                .scaleEffect(size) // Scale effect animation
                .opacity(opacity) // Opacity animation
                .onAppear {
                    withAnimation(.easeIn(duration: 1.2)) {
                        self.size = 0.9 // Scale up
                        self.opacity = 1.0 // Fade in
                    }
                }
            }
            .onAppear {
                // Trigger transition to ContentView after a delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
