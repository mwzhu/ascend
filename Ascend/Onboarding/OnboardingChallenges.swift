import SwiftUI

struct OnboardingChallenges: View {
    @State private var selectedChallenges: Set<String> = []
    let onNext: () -> Void
    
    let challenges: [(icon: String, title: String)] = [
        (icon: "calendar.badge.exclamationmark", title: "I struggle to stay consistent"),
        (icon: "questionmark.circle", title: "I'm missing the right information"),
        (icon: "clock.badge.exclamationmark", title: "I have a busy schedule"),
        (icon: "person.2.slash", title: "I lack support"),
        (icon: "fork.knife", title: "I have unhealthy eating habits")
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
                                .frame(width: geometry.size.width * 0.05, height: 4)
                        }
                    }
                    .frame(height: 4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                // Header Text
                Text("What's stopping you from reaching your goals?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                Spacer()
                
                // Challenge Buttons - Multi-select
                VStack(spacing: 16) {
                    ForEach(challenges, id: \.title) { challenge in
                        ChallengeButton(
                            icon: challenge.icon,
                            title: challenge.title,
                            isSelected: selectedChallenges.contains(challenge.title),
                            action: {
                                if selectedChallenges.contains(challenge.title) {
                                    selectedChallenges.remove(challenge.title)
                                } else {
                                    selectedChallenges.insert(challenge.title)
                                }
                            }
                        )
                    }
                }
                .padding(.horizontal, 24)
                
                Spacer()
                
                // Next Button
                Button(action: onNext) {
                    Text("Next")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(selectedChallenges.isEmpty ? Color.black.opacity(0.3) : Color.black)
                        .cornerRadius(28)
                }
                .disabled(selectedChallenges.isEmpty)
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
            }
        }
    }
}

struct ChallengeButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .white : .black)
                    .frame(width: 32)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isSelected ? .white : .black)
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .frame(height: 72)
            .background(isSelected ? Color.black : Color.gray.opacity(0.05))
            .cornerRadius(12)
        }
    }
}

#Preview {
    OnboardingChallenges(onNext: {})
}
