import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = true
    @State private var onboardingStep = 1
    
    private var progress: Double {
        Double(onboardingStep) / 25.0
    }
    
    private func nextStep() {
        if onboardingStep < 25 {
            onboardingStep += 1
        } else {
            showOnboarding = false
        }
    }
    
    private func previousStep() {
        if onboardingStep > 1 {
            onboardingStep -= 1
        }
    }
    
    var body: some View {
        if showOnboarding {
            switch onboardingStep {
            case 1:
                OnboardingView1(onGetStarted: nextStep)
            case 2:
                OnboardingExperience(onNext: nextStep, onBack: previousStep, progress: progress)
            case 3:
                OnboardingAccomplish(onNext: nextStep, onBack: previousStep, progress: progress)
            case 4:
                OnboardingPeptides(onNext: nextStep, onBack: previousStep, progress: progress)
            case 5:
                OnboardingDosage(onNext: nextStep, onBack: previousStep, progress: progress)
            case 6:
                OnboardingFrequency(onNext: nextStep, onBack: previousStep, progress: progress)
            case 7:
                OnboardingGraph(onNext: nextStep, onBack: previousStep, progress: progress)
            case 8:
                OnboardingGender(onNext: nextStep, onBack: previousStep, progress: progress)
            case 9:
                OnboardingBirthday(onNext: nextStep, onBack: previousStep, progress: progress)
            case 10:
                OnboardingHeightWeight(onNext: nextStep, onBack: previousStep, progress: progress)
            case 11:
                OnboardingHealthGoals(onNext: nextStep, onBack: previousStep, progress: progress)
            case 12:
                OnboardingDreamWeight(onNext: nextStep, onBack: previousStep, progress: progress)
            case 13:
                OnboardingDreamWeight2(onNext: nextStep, onBack: previousStep, progress: progress)
            case 14:
                OnboardingGoalTimeline(onNext: nextStep, onBack: previousStep, progress: progress)
            case 15:
                OnboardingDreamWeight3(onNext: nextStep, onBack: previousStep, progress: progress)
            case 16:
                OnboardingChallenges(onNext: nextStep, onBack: previousStep, progress: progress)
            case 17:
                OnboardingActivityLevel(onNext: nextStep, onBack: previousStep, progress: progress)
            case 18:
                OnboardingSideEffects(onNext: nextStep, onBack: previousStep, progress: progress)
            case 19:
                OnboardingMotivation(onNext: nextStep, onBack: previousStep, progress: progress)
            case 20:
                OnboardingGraph4(onNext: nextStep, onBack: previousStep, progress: progress)
            case 21:
                OnboardingRating(onNext: nextStep, onBack: previousStep, progress: progress)
            case 22:
                OnboardingNotification(onNext: nextStep, onBack: previousStep, progress: progress)
            case 23:
                OnboardingDone(onNext: nextStep, onBack: previousStep, progress: progress)
            case 24:
                OnboardingCreatingPlan(onNext: nextStep, onBack: previousStep, progress: progress)
            case 25:
                OnboardingPlan(onNext: nextStep, onBack: previousStep, progress: progress)
            default:
                OnboardingView1(onGetStarted: nextStep)
            }
        } else {
            HomeView()
        }
    }
}

#Preview {
    ContentView()
}
