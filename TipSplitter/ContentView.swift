//
//  ContentView.swift
//  WeSplit
//
//  Created by Steven Yim on 12/18/23.
//

import SwiftUI

struct ContentView: View {
    
    // Initial configuration for navigation bar appearance
    init() {
        let coloredNavAppearance = UINavigationBarAppearance()
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = .systemBlue
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    
    // State variables for user input and app state
    @State private var checkAmount = ""
    @State private var numberOfPeople = 2
    @State private var customTipAmount: String = ""
    @State private var tipPercentages = Array(stride(from: 0, through: 100, by: 5))
    @State private var selectedTipPercentage: Int?
    @State private var isCustomTipActive = false // Track if custom tip input is active
    @State private var shouldCalculate = false
    @State private var isCustomTipAmountEntered = false // Track if custom tip amount is entered
    @State private var isDarkMode = false

    // Computed properties for calculated values
    private var totalAmount: Double {
        guard let amount = Double(checkAmount), amount > 0 else {
            return 0
        }

        var tipValue = 0.0

        if let selectedPercentage = selectedTipPercentage {
            tipValue = amount * Double(selectedPercentage) / 100
        } else if let customTip = Double(customTipAmount), customTip > 0 {
            tipValue = amount * customTip / 100
        }

        return amount + tipValue
    }

    private var totalPerPerson: Double {
        guard totalAmount > 0 else {
            return 0
        }
        
        let peopleCount = Double(numberOfPeople + 2)
        return totalAmount / peopleCount
    }

    var body: some View {
        NavigationView {
            VStack {
                Spacer().frame(height: 0.17)
                Form {
                    // Amount and number of people input section
                    Section {
                        HStack {
                            Text("$")
                                .foregroundColor(.secondary)
                                .padding(.leading, 8)
                            TextField("Amount", text: $checkAmount)
                                .keyboardType(.decimalPad)
                            Button("Reset All") {
                                resetValues()
                            }
                        }
                        Picker("Number of people", selection: $numberOfPeople) {
                            ForEach(2..<100) {
                                Text("\($0) people")
                            }
                        }
                    }
                    
                    // Tip percentage selection section
                    Section(header: Text("TIP PERCENTAGE")) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(tipPercentages, id: \.self) { percentage in
                                    TipButtonView(
                                        percentage: percentage,
                                        selectedTipPercentage: $selectedTipPercentage
                                    )
                                }
                            }
                        }
                        HStack {
                            Button(action: {
                                withAnimation {
                                    isCustomTipActive = true // Activate custom tip input
                                }
                            }) {
                                Text("Customize Tip")
                                    .foregroundColor(.blue)
                                    .font(.headline)
                            }
                            .buttonStyle(PlainButtonStyle()) // Prevents the whole HStack from being tappable

                            Spacer()

                            Text("\(customTipAmount)%")
                                .foregroundColor(.blue)
                                .padding(.trailing)
                        }
                    }
                    
                    // Total amount and amount per person display sections
                    Section(header: Text("TOTAL AMOUNT (ORIGINAL AMOUNT + TIP)")) {
                        Text("$\(totalAmount, specifier: "%.2f")")
                    }
                    Section(header: Text("AMOUNT PER PERSON")) {
                        Text("$\(totalPerPerson, specifier: "%.2f")")
                    }
                }
            }
            .background(Color.white)
            .navigationTitle("TipSplitter")
            .blur(radius: isCustomTipActive ? 3 : 0)
            .overlay(
                CustomTipView(customTipAmount: $customTipAmount, shouldCalculate: $shouldCalculate, isActive: $isCustomTipActive, isCustomTipAmountEntered: $isCustomTipAmountEntered,
                    isDarkMode: $isDarkMode)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.black.opacity(0.4))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(isCustomTipActive ? 1 : 0)
            )
            .toolbar {
                // Done button in the keyboard toolbar
                ToolbarItem(placement: .keyboard) {
                    Button("Done") {
                        hideKeyboard()
                        shouldCalculate = true
                    }
                    .padding()
                    .foregroundColor(.blue)
                }
            }
            .toolbar {
                // Dark mode toggle button in the navigation bar
                ToolbarItem(placement: .navigationBarTrailing) {
                    DarkModeToggleView(isDarkMode: $isDarkMode)
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }

    // Function to reset input values
    func resetValues() {
        checkAmount = ""
        numberOfPeople = 2
        customTipAmount = ""
        selectedTipPercentage = nil
        shouldCalculate = false
        isCustomTipAmountEntered = false
    }
}

// Function to hide the keyboard
func hideKeyboard() {
    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
}

// Extension for custom colors
extension Color {
    static let offWhite = Color(red: 0.8, green: 0.8, blue: 0.8)
    static let lightBlue = Color(red: 0.75, green: 0.85, blue: 0.95)
}

#Preview {
    ContentView()
}
