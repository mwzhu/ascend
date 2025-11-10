//
//  ContentView.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var currentScreen: Screen = .onboarding1
    
    enum Screen {
        case onboarding1
        case onboarding2
        case home
    }
    
    var body: some View {
        Group {
            switch currentScreen {
            case .onboarding1:
                OnboardingView1 {
                    currentScreen = .onboarding2
                }
            case .onboarding2:
                OnboardingView2 {
                    currentScreen = .home
                }
            case .home:
                HomeView()
            }
        }
        .animation(.easeInOut, value: currentScreen)
    }
}

#Preview {
    ContentView()
}
