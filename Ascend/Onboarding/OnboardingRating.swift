import SwiftUI

struct OnboardingRating: View {
    let onNext: () -> Void
    @State private var selectedRating: Int = 0
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                headerSection
                
                ScrollView {
                    VStack(spacing: 32) {
                        titleSection
                        starRating
                        testimonialsSection
                        bottomMessage
                    }
                }
                
                continueButton
            }
        }
    }
    
    private var headerSection: some View {
        HStack(spacing: 20) {
            Button(action: {}) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 4)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(width: geometry.size.width * 0.95, height: 4)
                }
            }
            .frame(height: 4)
        }
        .padding(.horizontal, 24)
        .padding(.top, 60)
        .padding(.bottom, 20)
    }
    
    private var titleSection: some View {
        Text("Give us a rating")
            .font(.system(size: 32, weight: .bold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.top, 20)
    }
    
    private var starRating: some View {
        HStack(spacing: 12) {
            ForEach(1...5, id: \.self) { index in
                Button(action: {
                    selectedRating = index
                }) {
                    Image(systemName: selectedRating >= index ? "star.fill" : "star.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color(hex: "C89FD9"))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
    }
    
    private var testimonialsSection: some View {
        VStack(spacing: 16) {
            testimonialCard(
                name: "Olivia, 34",
                text: "\"I was nervous about starting GLP-1, but MeAgain made it so much easier. I've lost 10lbs in 2 months and I feel so much better.\""
            )
            
            testimonialCard(
                name: "Taylor, 25",
                text: "\"After 3 months on GLP-1 I hit a plateau. MeAgain helped me break through it. thx\""
            )
            
            testimonialCard(
                name: "Jordan, 31",
                text: "\"Even on bad days, MeAgain reminds me why I started and keeps me going. I finally believe I can do this.\""
            )
        }
        .padding(.horizontal, 24)
    }
    
    private func testimonialCard(name: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 56, height: 56)
                
                Text(name)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 4) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star.fill")
                            .font(.system(size: 16))
                            .foregroundColor(Color(hex: "FFB347"))
                    }
                }
            }
            
            Text(text)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.white)
                .lineSpacing(4)
        }
        .padding(20)
        .background(Color.white.opacity(0.1))
        .cornerRadius(16)
    }
    
    private var bottomMessage: some View {
        HStack(spacing: 16) {
            Image(systemName: "leaf.fill")
                .font(.system(size: 40))
                .foregroundColor(.white.opacity(0.3))
                .rotationEffect(.degrees(-45))
            
            VStack(spacing: 4) {
                Text("We are a small team trying to")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                Text("build the best GLP-1 app, so a")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
                Text("rating goes a really long way!")
                    .font(.system(size: 15))
                    .foregroundColor(.white)
            }
            .multilineTextAlignment(.center)
            
            Image(systemName: "leaf.fill")
                .font(.system(size: 40))
                .foregroundColor(.white.opacity(0.3))
                .rotationEffect(.degrees(45))
                .scaleEffect(x: -1, y: 1)
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .padding(.bottom, 40)
    }
    
    private var continueButton: some View {
        Button(action: onNext) {
            Text("Continue")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white.opacity(0.5))
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.white.opacity(0.1))
                .cornerRadius(28)
        }
        .padding(.horizontal, 32)
        .padding(.bottom, 40)
    }
}

#Preview {
    OnboardingRating(onNext: {})
}

