import SwiftUI

struct OnboardingGoalTimeline: View {
    @State private var weeklyChange: Double = 1.5
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
                Text("How quickly do you want to reach your goal?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                // Subtitle Text
                Text("(Don't worry, we'll help you stay healthy whatever pace you choose.)")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                
                // Goal Date
                HStack {
                    Spacer()
                    HStack(spacing: 4) {
                        Image(systemName: "flag.pattern.checkered")
                            .font(.system(size: 12))
                            .foregroundColor(.black)
                        Text("Est. Goal Date")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.gray)
                        Text("Sep 17, 2025")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.black.opacity(0.8))
                    }
                    .padding(.horizontal, 6)
                    .padding(.vertical, 6)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    Spacer()
                }
                .padding(.bottom, 20)
                .padding(.top, 60)
                
                // Weekly Change Display
                VStack(spacing: 12) {
                    Text("Weekly Change:")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.black)
                    
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text(String(format: "%.1f", weeklyChange))
                            .font(.system(size: 40, weight: .bold))
                            .foregroundColor(.black)
                        Text("kg")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(.black.opacity(0.8))
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 30)
                
                // Slider with Icons
                VStack(spacing: 8) {
                    HStack(spacing: 0) {
                        Image(systemName: "figure.walk")
                            .font(.system(size: 23))
                            .foregroundColor(.black)
                            .frame(width: 30)
                        
                        Spacer()
                        
                        Image(systemName: "car.fill")
                            .font(.system(size: 27))
                            .foregroundColor(Color(hex: "FF7300"))
                            .offset(y: -5)
                        
                        Spacer()
                        
                        Image(systemName: "bolt.fill")
                            .font(.system(size: 23))
                            .foregroundColor(.black)
                            .frame(width: 30)
                    }
                    .padding(.horizontal, 50)
                    
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hex: "FF7300").opacity(0.3))
                            .frame(height: 10)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(hex: "FF7300"))
                            .frame(width: CGFloat((weeklyChange - 0.1) / (1.5 - 0.1)) * (UIScreen.main.bounds.width - 100), height: 10)
                        
                        Circle()
                            .fill(Color(hex: "FF7300"))
                            .frame(width: 27, height: 27)
                            .offset(x: CGFloat((weeklyChange - 0.1) / (1.5 - 0.1)) * (UIScreen.main.bounds.width - 100) - 14)
                            .gesture(
                                DragGesture()
                                    .onChanged { value in
                                        let width = UIScreen.main.bounds.width - 100
                                        let newValue = min(max(0.1, 0.1 + (value.location.x / width) * 1.4), 1.5)
                                        weeklyChange = Double(round(newValue * 10) / 10)
                                    }
                            )
                    }
                    .padding(.horizontal, 50)
                    
                    HStack {
                        Text("0.1 kg")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.black.opacity(0.8))
                        
                        Spacer()
                        
                        Text("0.7 kg")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.black.opacity(0.8))
                        
                        Spacer()
                        
                        Text("1.5 kg")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.black.opacity(0.8))
                    }
                    .padding(.horizontal, 50)
                }
                .padding(.bottom, 10)
                
                Spacer()
                
                // Info Text
                VStack(spacing: 2) {
                    Text("This faster pace is within medical guidelines.")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.black.opacity(0.8))
                    Text("We'll help you adjust if needed.")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundColor(.black.opacity(0.8))
                }
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.horizontal, 24)
                .padding(.bottom, 32)
                
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
    OnboardingGoalTimeline(onNext: {}, onBack: {}, progress: 0.56)
}
