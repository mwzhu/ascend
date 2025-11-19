import SwiftUI

struct OnboardingDreamWeight2: View {
    let onNext: () -> Void
    let onBack: () -> Void
    let progress: Double
    
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
                
                Spacer()
                
                VStack(spacing: 25) {
                    // Logo Section
                    HStack(alignment: .center, spacing: 4) {
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 32, weight: .semibold))
                            .foregroundColor(Color(hex: "FF7300"))
                        
                        Text("Ascend")
                            .font(.system(size: 36, weight: .semibold))
                            .foregroundColor(.black)
                            .italic()
                    }
                    
                    // Main Content Card
                    VStack(spacing: 24) {
                        // Main Headline
                        (Text("Losing ")
                            .foregroundColor(.black) +
                        Text("7 kg")
                            .foregroundColor(Color(hex: "FF7300")) +
                        Text(" might feel overwhelming—but it's very realistic. Let's tackle it together.")
                            .foregroundColor(.black))
                            .font(.system(size: 26, weight: .semibold))
                            .multilineTextAlignment(.center)
                            .lineSpacing(2)
                            .padding(.horizontal, 24)
                    }
                    .padding(.vertical, 40)
                    .background(Color.gray.opacity(0.05))
                    .cornerRadius(20)
                    .padding(.horizontal, 24)
                }
                .padding(.bottom, 24)

                 // Subheadline
                    Text("Over 80% of Ascend members see tangible progress in their first month — without the scary side effects they feared.")
                        .font(.system(size: 13, weight: .regular))
                        .foregroundColor(.black.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                        .padding(.horizontal, 60)

                Spacer()
                
                // Next Button
                Button(action: onNext) {
                    Text("Next")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.black)
                        .cornerRadius(28)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    OnboardingDreamWeight2(onNext: {}, onBack: {}, progress: 0.52)
}
