import SwiftUI

struct OnboardingCreatingPlan: View {
    let onNext: () -> Void
    let onBack: () -> Void
    let progress: Double
    
    @State private var currentStep = 0
    
    private let steps: [(emoji: String, text: String)] = [
        ("☁️", "Creating daily nutrition goals..."),
        ("💧", "Personalizing your daily water intake..."),
        ("🏋️", "Tailoring exercises to your lifestyle and goals..."),
        ("⏱️", "Organizing your timeline for best results...")
    ]
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                Spacer()
                
                Text(steps[currentStep].emoji)
                    .font(.system(size: 45))
                    .id(currentStep)
                    .transition(.opacity)
                    .padding(.bottom, 8)
                
                VStack(spacing: 12) {
                    HStack(spacing: 0) {
                        Text("Creating Your Ascend Plan")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    
                    Text(steps[currentStep].text)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.black.opacity(0.5))
                        .multilineTextAlignment(.center)
                        .padding(.top, 2)
                        .id("text-\(currentStep)")
                        .transition(.opacity)
                }
                .frame(maxWidth: .infinity)
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.gray.opacity(0.8)))
                    .scaleEffect(2.0)
                    .padding(.top, 50)
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal, 32)
        }
        .onAppear {
            startAnimation()
        }
    }
    
    private func startAnimation() {
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) { timer in
            withAnimation(.easeInOut(duration: 0.4)) {
                if currentStep < steps.count - 1 {
                    currentStep += 1
                } else {
                    timer.invalidate()
                }
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
            onNext()
        }
    }
}

#Preview {
    OnboardingCreatingPlan(onNext: {}, onBack: {}, progress: 0.96)
}

