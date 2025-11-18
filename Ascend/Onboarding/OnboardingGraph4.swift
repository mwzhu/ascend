import SwiftUI

struct OnboardingGraph4: View {
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
                                .frame(width: geometry.size.width * 0.15, height: 4)
                        }
                    }
                    .frame(height: 4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                // Header Text
                Text("Ascend creates long-term results")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 70)
                
                // Timeline Graph Section
                VStack(spacing: 24) {
                    ProgressTimelineGraph()
                        .frame(height: 280)
                        .padding(.horizontal, 24)
                    
                    Text("Based on Ascend's historical data, weight loss is usually delayed at first, but after 7 days, you can burn fat like crazy!")
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(.black.opacity(0.8))
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

struct ProgressTimelineGraph: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            VStack(alignment: .leading, spacing: 0) {
                // Title
                Text("Your weight transition")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.black)
                    .padding(.bottom, 20)
                
                ZStack(alignment: .topLeading) {
                    // Grid lines
                    VStack(spacing: height * 0.25) {
                        ForEach(0..<4) { _ in
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 1)
                        }
                    }
                    .padding(.top, 20)
                    
                    Canvas { context, size in
                        let point1X: CGFloat = 20
                        let point2X = size.width * 0.45
                        let point3X = size.width - 20
                        
                        let point1Y = size.height * 0.65
                        let point2Y = size.height * 0.48
                        let point3Y = size.height * 0.08
                        
                        // Fill areas under the path
                        let fill1 = Path { path in
                            path.move(to: CGPoint(x: point1X, y: point1Y))
                            path.addLine(to: CGPoint(x: point2X, y: point2Y))
                            path.addLine(to: CGPoint(x: point2X, y: size.height))
                            path.addLine(to: CGPoint(x: point1X, y: size.height))
                            path.closeSubpath()
                        }
                        
                        let fill2 = Path { path in
                            path.move(to: CGPoint(x: point2X, y: point2Y))
                            path.addLine(to: CGPoint(x: point3X, y: point3Y))
                            path.addLine(to: CGPoint(x: point3X, y: size.height))
                            path.addLine(to: CGPoint(x: point2X, y: size.height))
                            path.closeSubpath()
                        }
                        
                        context.fill(fill1, with: .color(Color.gray.opacity(0.15)))
                        context.fill(fill2, with: .color(Color(hex: "D4A574").opacity(0.3)))
                        
                        // Draw the main path
                        let progressPath = Path { path in
                            path.move(to: CGPoint(x: point1X, y: point1Y))
                            path.addLine(to: CGPoint(x: point2X, y: point2Y))
                            path.addLine(to: CGPoint(x: point3X, y: point3Y))
                        }
                        
                        context.stroke(
                            progressPath,
                            with: .color(Color(hex: "FF7300")),
                            lineWidth: 3
                        )
                    }
                    .frame(height: height * 0.7)
                    .padding(.top, 20)
                    
                    // Data points
                    ZStack(alignment: .topLeading) {
                        // First circle (3 days)
                        Circle()
                            .fill(Color.white)
                            .frame(width: 16, height: 16)
                            .overlay(
                                Circle()
                                    .stroke(.black, lineWidth: 2.5)
                            )
                            .offset(x: 12, y: height * 0.65 + 12)
                        
                        // Second circle (7 days)
                        Circle()
                            .fill(Color.white)
                            .frame(width: 16, height: 16)
                            .overlay(
                                Circle()
                                    .stroke(.black, lineWidth: 2.5)
                            )
                            .offset(x: width * 0.45 - 8, y: height * 0.48 + 12)
                        
                        // Trophy (30 days)
                        ZStack {
                            Circle()
                                .fill(Color(hex: "D4A574"))
                                .frame(width: 40, height: 40)
                            
                            Image(systemName: "trophy.fill")
                                .font(.system(size: 18))
                                .foregroundColor(.white)
                        }
                        .offset(x: width - 40, y: height * 0.08)
                    }
                }
                
                // Timeline labels
                ZStack(alignment: .topLeading) {
                    Text("3 Days")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                        .offset(x: 0, y: 0)
                    
                    Text("7 Days")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                        .offset(x: width * 0.45 - 30, y: 0)
                    
                    Text("30 Days")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black)
                        .offset(x: width - 60, y: 0)
                }
                .padding(.top, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    OnboardingGraph4(onNext: {})
}
