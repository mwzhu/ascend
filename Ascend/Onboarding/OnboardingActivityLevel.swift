import SwiftUI

struct OnboardingActivityLevel: View {
    @State private var selectedActivityLevel: String = ""
    let onNext: () -> Void
    
    let activityLevelOptions: [(icon: String, title: String, subtitle: String)] = [
        (icon: "figure.seated.side", title: "Sedentary", subtitle: "(mostly inactive, little exercise)"),
        (icon: "figure.walk", title: "Lightly Active", subtitle: "(light daily activity and movement)"),
        (icon: "figure.run", title: "Active", subtitle: "(regular workouts or physical labor)"),
        (icon: "figure.strengthtraining.traditional", title: "Very Active", subtitle: "(intense exercise or very physical job)"),
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
                                .frame(width: geometry.size.width * 0.35, height: 4)
                        }
                    }
                    .frame(height: 4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                // Header Text
                Text("Tell us a bit about your daily routine.")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                Spacer()
                
                // Activity Level Buttons - Centered
                VStack(spacing: 16) {
                    ForEach(activityLevelOptions, id: \.title) { option in
                        ActivityLevelButton(
                            icon: option.icon,
                            title: option.title,
                            subtitle: option.subtitle,
                            isSelected: selectedActivityLevel == option.title,
                            action: {
                                selectedActivityLevel = option.title
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
                        .background(selectedActivityLevel.isEmpty ? Color.black.opacity(0.3) : Color.black)
                        .cornerRadius(28)
                }
                .disabled(selectedActivityLevel.isEmpty)
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
            }
        }
    }
}

struct ActivityLevelButton: View {
    let icon: String
    let title: String
    let subtitle: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 28))
                    .foregroundColor(isSelected ? .white : .black)
                    .frame(width: 40)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(isSelected ? .white : .black)
                    
                    Text(subtitle)
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(isSelected ? .white : .black)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .background(isSelected ? Color.black : Color.gray.opacity(0.05))
            .cornerRadius(12)
        }
    }
}

#Preview {
    OnboardingActivityLevel(onNext: {})
}
