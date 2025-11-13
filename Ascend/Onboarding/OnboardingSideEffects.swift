import SwiftUI

struct OnboardingSideEffects: View {
    @State private var selectedSideEffects: Set<String> = []
    let onNext: () -> Void
    
    let sideEffects = [
        "Nausea",
        "Fatigue",
        "Headaches",
        "Dizziness",
        "Injection Anxiety",
        "Appetite Changes",
        "Other",
        "Not Concerned"
    ]
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                // Back Button and Progress Bar
                HStack(spacing: 20) {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 4)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .frame(width: geometry.size.width * 0.1, height: 4)
                        }
                    }
                    .frame(height: 4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                // Header Text
                Text("What side effects are you most concerned about?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                // Subtitle Text
                Text("Share what's on your mind — we'll tailor support to your needs.")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                
                // Side Effect Buttons - Scrollable
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(sideEffects, id: \.self) { sideEffect in
                            MultiSelectButton(
                                title: sideEffect,
                                isSelected: selectedSideEffects.contains(sideEffect),
                                action: {
                                    if selectedSideEffects.contains(sideEffect) {
                                        selectedSideEffects.remove(sideEffect)
                                    } else {
                                        selectedSideEffects.insert(sideEffect)
                                    }
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                }
                
                Spacer()
                
                // Next Button
                Button(action: onNext) {
                    Text("Next")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(selectedSideEffects.isEmpty ? Color.black.opacity(0.3) : Color.black)
                        .cornerRadius(28)
                }
                .disabled(selectedSideEffects.isEmpty)
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    OnboardingSideEffects(onNext: {})
}
