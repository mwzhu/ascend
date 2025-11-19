import SwiftUI
import StoreKit

struct OnboardingRating: View {
    let onNext: () -> Void
    let onBack: () -> Void
    let progress: Double
    @State private var selectedRating: Int = 0
    @State private var isContinueEnabled: Bool = false
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                headerSection
                
                Spacer().frame(height: 8)
                
                titleSection
                
                Spacer().frame(height: 8)
                
                starRating
                
                Spacer().frame(height: 8)
                
                testimonialsSection
                
                Spacer().frame(height: 50)
                
                bottomMessage
                
                Spacer()
                
                continueButton
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    SKStoreReviewController.requestReview(in: scene)
                }
                isContinueEnabled = true
            }
        }
    }
    
    private var headerSection: some View {
        HStack(spacing: 20) {
            Button(action: onBack) {
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
                        .frame(width: geometry.size.width * progress, height: 4)
                }
            }
            .frame(height: 4)
        }
        .padding(.horizontal, 24)
        .padding(.top, 10)
    }
    
    private var titleSection: some View {
        Text("Give us a rating")
            .font(.system(size: 32, weight: .medium))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 8)
    }
    
    private var starRating: some View {
        HStack(spacing: 6) {
            ForEach(1...5, id: \.self) { index in
                Button(action: {
                    selectedRating = index
                }) {
                    Image(systemName: selectedRating >= index ? "star.fill" : "star.fill")
                        .font(.system(size: 26))
                        .foregroundColor(Color(hex: "FF7300"))
                }
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 10)
    }
    
    private var testimonialsSection: some View {
        ZStack {
            testimonialCard(
                imageName: "profile_ethan",
                name: "Ethan, 21",
                text: "\"I knew nothing about peptides, but Ascend made everything easy. In 2 months, I've gained 8lbs of muscle and a more defined face.\""
            )
            .rotationEffect(.degrees(-1.5))
            .offset(x: 5, y: -110)
            .zIndex(0)
            
            testimonialCard(
                imageName: "profile_jessica",
                name: "Jessica, 29",
                text: "\"Even on bad days, Ascend reminds me why I started and keeps me going. My skin looks clearer and I feel like myself again. ty!\""
            )
            .rotationEffect(.degrees(1))
            .offset(x: -5, y: 22)
            .zIndex(1)
            
            testimonialCard(
                imageName: "profile_lucas",
                name: "Lucas, 38",
                text: "\"Ascend helped me smash a plateau I thought I'd never overcome. I lost 16lbs and recovered from an injury that slowed me for years.\""
            )
            .rotationEffect(.degrees(-1.5))
            .offset(x: 5, y: 152)
            .zIndex(2)
        }
        .padding(.horizontal, 24)
        .frame(height: 400)
    }
    
    private func testimonialCard(imageName: String, name: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 44, height: 44)
                    
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 44, height: 44)
                        .clipShape(Circle())
                }
                .frame(width: 44, height: 44)
                
                Text(name)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
                
                Spacer()
                
                HStack(spacing: 3) {
                    ForEach(0..<5) { _ in
                        Text("⭐")
                            .font(.system(size: 15))
                    }
                }
            }
            
            Text(text)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.white)
                .lineSpacing(2)
        }
        .padding(14)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(hex: "2C2C2E"))
                
                VStack {
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color.white.opacity(0.1),
                            Color.clear
                        ]),
                        startPoint: .top,
                        endPoint: .center
                    )
                    .frame(height: 30)
                    Spacer()
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .shadow(color: Color.black.opacity(0.3), radius: 8, x: 0, y: 4)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color.white.opacity(0.4), lineWidth: 1.5)
        )
        .cornerRadius(16)
    }
    
    private var bottomMessage: some View {
        HStack(spacing: 6) {
            Image(systemName: "laurel.leading")
                .font(.system(size: 65))
                .foregroundColor(.white)
            
            VStack(spacing: 0) {
                Text("We are a small team trying to")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                Text("build the best peptide app, so a")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
                Text("rating goes a really long way!")
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundColor(.white)
            }
            .multilineTextAlignment(.center)
            
            Image(systemName: "laurel.trailing")
                .font(.system(size: 65))
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 24)
    }
    
    private var continueButton: some View {
        Button(action: {
            if isContinueEnabled {
                onNext()
            }
        }) {
            Text("Continue")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(isContinueEnabled ? Color(hex: "FF7300") : Color.white.opacity(0.1))
                .cornerRadius(28)
        }
        .disabled(!isContinueEnabled)
        .padding(.horizontal, 32)
        .padding(.bottom, 20)
    }
}

#Preview {
    OnboardingRating(onNext: {}, onBack: {}, progress: 0.84)
}

