import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = true
    @State private var onboardingStep = 1
    @State private var selectedExperience = ""
    
    var body: some View {
        if showOnboarding {
            if onboardingStep == 1 {
                OnboardingView1(onGetStarted: {
                    onboardingStep = 2
                })
            } else {
                OnboardingView2(
                    selectedExperience: $selectedExperience,
                    onContinue: {
                        showOnboarding = false
                    }
                )
            }
        } else {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
