import SwiftUI

struct OnboardingExperience: View {
    @State private var selectedExperience: String = ""
    let onNext: () -> Void
    
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
                Text("Ready to ascend?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                // Subtitle Text
                Text("Where are you with your peptide journey?")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 60)
                
                // Experience Level Buttons
                VStack(spacing: 16) {
                    ExperienceButton(
                        icon: "sparkles",
                        title: "I'm new to this",
                        isSelected: selectedExperience == "new",
                        action: { selectedExperience = "new" }
                    )
                    
                    ExperienceButton(
                        icon: "chart.line.uptrend.xyaxis",
                        title: "I've got some experience",
                        isSelected: selectedExperience == "experienced",
                        action: { selectedExperience = "experienced" }
                    )

                    ExperienceButton(
                        icon: "star.fill",
                        title: "I'm a peptide expert",
                        isSelected: selectedExperience == "expert",
                        action: { selectedExperience = "expert" }
                    )
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
                        .background(selectedExperience.isEmpty ? Color.black.opacity(0.3) : Color.black)
                        .cornerRadius(28)
                }
                .disabled(selectedExperience.isEmpty)
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
            }
        }
    }
}

struct ExperienceButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(isSelected ? .white : .black)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isSelected ? .white : .black)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(isSelected ? Color.black : Color.gray.opacity(0.05))
            .cornerRadius(12)
        }
    }
}

#Preview {
    OnboardingExperience(onNext: {})
}
