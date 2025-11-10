import SwiftUI

struct OnboardingView2: View {
    @Binding var selectedExperience: String
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                // Back Button and Progress Bar
                HStack(spacing: 12) {
                    Button(action: {}) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 8)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.black)
                                .frame(width: geometry.size.width * 0.5, height: 8)
                        }
                    }
                    .frame(height: 8)
                }
                .padding(.horizontal, 24)
                .padding(.top, 60)
                .padding(.bottom, 40)
                
                // Header Text
                Text("Ready to feel like you again?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 12)
                
                // Subtitle Text
                Text("Where are you with your GLP-1 journey?")
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 60)
                
                Spacer()
                
                // Experience Level Buttons
                VStack(spacing: 16) {
                    ExperienceButton(
                        icon: "sparkles",
                        title: "I'm already on a GLP-1",
                        isSelected: selectedExperience == "already",
                        action: { selectedExperience = "already" }
                    )
                    
                    ExperienceButton(
                        icon: "play.fill",
                        title: "I'm about to start a GLP-1",
                        isSelected: selectedExperience == "starting",
                        backgroundColor: .black,
                        action: { selectedExperience = "starting" }
                    )
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 100)
                
                Spacer()
                
                // Continue Button
                Button(action: onContinue) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(selectedExperience.isEmpty ? Color.gray.opacity(0.3) : Color.black)
                        .cornerRadius(16)
                }
                .disabled(selectedExperience.isEmpty)
                .padding(.horizontal, 24)
                .padding(.bottom, 50)
            }
        }
    }
}

struct ExperienceButton: View {
    let icon: String
    let title: String
    let isSelected: Bool
    var backgroundColor: Color = .white
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(backgroundColor == .black ? .white : .black)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(backgroundColor == .black ? .white : .black)
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(height: 60)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(backgroundColor == .black ? Color.clear : Color.gray.opacity(0.2), lineWidth: 1)
            )
            .cornerRadius(12)
        }
    }
}

#Preview {
    OnboardingView2(selectedExperience: .constant(""), onContinue: {})
}
