import SwiftUI

struct OnboardingGender: View {
    @State private var selectedGender: String = ""
    let onNext: () -> Void
    let onBack: () -> Void
    let progress: Double
    
    let genderOptions: [(icon: String?, title: String)] = [
        (icon: "♂", title: "Male"),
        (icon: "♀", title: "Female"),
        (icon: nil, title: "Other"),
        (icon: nil, title: "Prefer not to say"),
    ]
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                // Back Button and Progress Bar
                HStack(spacing: 20) {
                    Button(action: onBack) {
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
                                .frame(width: geometry.size.width * progress, height: 4)
                        }
                    }
                    .frame(height: 4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                // Header Text
                Text("Help us get the basics right.")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                // Subtitle Text
                Text("We use a few simple details to tailor your nutrition, activity, and wellness plan — all based on what works best for your body.")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                
                Spacer()
                
                // Gender Buttons - Centered
                VStack(spacing: 16) {
                    ForEach(genderOptions, id: \.title) { option in
                        GenderButton(
                            icon: option.icon,
                            title: option.title,
                            isSelected: selectedGender == option.title,
                            action: {
                                selectedGender = option.title
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
                        .background(selectedGender.isEmpty ? Color.black.opacity(0.3) : Color.black)
                        .cornerRadius(28)
                }
                .disabled(selectedGender.isEmpty)
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
            }
        }
    }
}

struct GenderButton: View {
    let icon: String?
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                
                if let icon = icon {
                    Text(icon)
                        .font(.system(size: 22))
                        .foregroundColor(isSelected ? .white : .black)
                }
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isSelected ? .white : .black)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 72)
            .background(isSelected ? Color.black : Color.gray.opacity(0.05))
            .cornerRadius(12)
        }
    }
}

#Preview {
    OnboardingGender(onNext: {}, onBack: {}, progress: 0.32)
}
