import SwiftUI
import UserNotifications

struct OnboardingNotification: View {
    @State private var arrowOffset: CGFloat = 0
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
                Text("Reach Your Goals with Notifications")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 160)
                
                // Spacer()
                
                // Notification Dialog
                VStack(spacing: 0) {
                    VStack(spacing: 4) {
                        Text("Turn on Push Notifications to unlock tailored advice.")
                            .font(.system(size: 19, weight: .semibold))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                            .padding(.top, 16)
                        
                        Text("Ascend reminds you to stay on track with your transformation.")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 24)
                    }
                    .padding(.bottom, 14)
                    
                    Divider()
                    
                    HStack(spacing: 0) {
                        Button(action: {
                            onNext()
                        }) {
                            Text("Don't Allow")
                                .font(.system(size: 19))
                                .foregroundColor(.gray.opacity(0.7))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                        
                        Divider()
                        
                        Button(action: {
                            requestNotificationPermission()
                        }) {
                            Text("Allow")
                                .font(.system(size: 19, weight: .semibold))
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 12)
                        }
                    }
                    .frame(height: 50)
                }
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color(white: 0.95))
                        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                )
                .background(
                    Ellipse()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(colors: [
                                    Color(hex: "FF7300").opacity(0.4),
                                    Color(hex: "FF7300").opacity(0.2),
                                    Color.clear
                                ]),
                                center: .center,
                                startRadius: 50,
                                endRadius: 250
                            )
                        )
                        .frame(width: 500, height: 500)
                        .blur(radius: 40)
                )
                .padding(.horizontal, 40)
                
                // Animated Arrow - positioned under Allow button
                HStack(spacing: 0) {
                    Spacer()
                        .frame(maxWidth: .infinity)
                    Image(systemName: "chevron.compact.up")
                        .font(.system(size: 52, weight: .semibold))
                        .foregroundColor(.black.opacity(0.45))
                        .offset(y: arrowOffset)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity)
                        .onAppear {
                            withAnimation(
                                Animation
                                    .easeInOut(duration: 0.3)
                                    .repeatForever(autoreverses: true)
                            ) {
                                arrowOffset = -8
                            }
                        }
                }
                .padding(.horizontal, 40)
                
                Spacer()
            }
        }
    }
    
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                onNext()
            }
        }
    }
}

#Preview {
    OnboardingNotification(onNext: {}, onBack: {}, progress: 0.88)
}
