import SwiftUI

struct OnboardingDreamWeight3: View {
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
                
                // Header Text
                Text("Make Peptides Work for You — 3x More Effectively")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                
                // Comparison Chart Section
                VStack(spacing: 30) {
                    // Comparison Bars
                    HStack(alignment: .bottom, spacing: 40) {
                        // Without Column
                        VStack(spacing: 16) {
                            Text("Without")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.black)
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(width: 120, height: 60)
                                
                                Text("18%")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                        
                        // Ascend Column
                        VStack(spacing: 16) {
                            HStack(alignment: .center, spacing: 4) {
                                Image(systemName: "bolt.fill")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(Color(hex: "FF7300"))
                                
                                Text("Ascend")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.black)
                                    .italic()
                            }
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(hex: "FF7300").opacity(0.8))
                                    .frame(width: 120, height: 200)
                                
                                Text("3X")
                                    .font(.system(size: 26, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    
                    // Description Text
                    Text("Enjoy a smoother experience, from managing side effects to hitting your health goals more effectively.")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                        .padding(.horizontal, 40)
                }
                .padding(.vertical, 40)
                .background(Color.gray.opacity(0.05))
                .cornerRadius(20)
                .padding(.horizontal, 24)
                
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
    OnboardingDreamWeight3(onNext: {}, onBack: {}, progress: 0.60)
}
