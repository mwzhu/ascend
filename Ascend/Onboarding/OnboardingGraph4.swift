import SwiftUI

struct OnboardingGraph4: View {
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
                Text("You have great potential to crush your goals")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 70)
                
                // Timeline Graph Section
                VStack(spacing: 8) {
                    ProgressTimelineGraph()
                        .frame(height: 280)
                        .padding(.horizontal, 24)
                    
                    Text("Based on Ascend's historical data, weight loss is usually delayed at first, but after 7 days, you can burn fat like crazy!")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black.opacity(0.65))
                        .multilineTextAlignment(.center)
                        .lineSpacing(2)
                        .padding(.horizontal, 30)
                }
                .padding(.vertical, 30)
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
                    .font(.system(size: 21, weight: .semibold))
                    .foregroundColor(.black.opacity(0.85))
                    .padding(.bottom, 20)
                
                ZStack(alignment: .topLeading) {
                    Canvas { context, size in
                        // Dot positions
                        let dot1X: CGFloat = 0
                        let dot2X = size.width * 0.25
                        let dot3X = size.width * 0.5
                        let trophyX = size.width
                        
                        let dot1Y = size.height * 0.7 + 10
                        let dot2Y = size.height * 0.7 + 3
                        let dot3Y = size.height * 0.5
                        let trophyY: CGFloat = 0
                        
                        // Draw horizontal grid lines (dotted)
                        for i in 0..<5 {
                            let y = CGFloat(i) * size.height * 0.25
                            let gridLine = Path { path in
                                path.move(to: CGPoint(x: 0, y: y))
                                path.addLine(to: CGPoint(x: size.width, y: y))
                            }
                            context.stroke(
                                gridLine,
                                with: .color(Color.gray.opacity(0.2)),
                                style: StrokeStyle(lineWidth: 1, dash: [2, 2])
                            )
                        }
                        
                        // Draw dotted vertical lines from first 3 dots
                        let dottedLine1 = Path { path in
                            path.move(to: CGPoint(x: dot1X, y: dot1Y))
                            path.addLine(to: CGPoint(x: dot1X, y: size.height))
                        }
                        
                        let dottedLine2 = Path { path in
                            path.move(to: CGPoint(x: dot2X, y: dot2Y))
                            path.addLine(to: CGPoint(x: dot2X, y: size.height))
                        }
                        
                        let dottedLine3 = Path { path in
                            path.move(to: CGPoint(x: dot3X, y: dot3Y))
                            path.addLine(to: CGPoint(x: dot3X, y: size.height))
                        }
                        
                        context.stroke(
                            dottedLine1,
                            with: .color(Color.gray.opacity(0.3)),
                            style: StrokeStyle(lineWidth: 1, dash: [2, 2])
                        )
                        
                        context.stroke(
                            dottedLine2,
                            with: .color(Color.gray.opacity(0.3)),
                            style: StrokeStyle(lineWidth: 1, dash: [2, 2])
                        )
                        
                        context.stroke(
                            dottedLine3,
                            with: .color(Color.gray.opacity(0.3)),
                            style: StrokeStyle(lineWidth: 1, dash: [2, 2])
                        )
                        
                        // Fill areas under the path - extend to bottom (using curves)
                        let fill1 = Path { path in
                            path.move(to: CGPoint(x: dot1X, y: dot1Y))
                            // Curve from dot1 to dot2
                            let control1X = (dot1X + dot2X) / 2
                            let control1Y = dot1Y
                            path.addQuadCurve(
                                to: CGPoint(x: dot2X, y: dot2Y),
                                control: CGPoint(x: control1X, y: control1Y)
                            )
                            path.addLine(to: CGPoint(x: dot2X, y: size.height))
                            path.addLine(to: CGPoint(x: dot1X, y: size.height))
                            path.closeSubpath()
                        }
                        
                        let fill2 = Path { path in
                            path.move(to: CGPoint(x: dot2X, y: dot2Y))
                            // Curve from dot2 to dot3
                            let control2X = (dot2X + dot3X) / 2
                            let control2Y = (dot2Y + dot3Y) / 2
                            path.addQuadCurve(
                                to: CGPoint(x: dot3X, y: dot3Y),
                                control: CGPoint(x: control2X + 10, y: control2Y)
                            )
                            path.addLine(to: CGPoint(x: dot3X, y: size.height))
                            path.addLine(to: CGPoint(x: dot2X, y: size.height))
                            path.closeSubpath()
                        }
                        
                        let fill3 = Path { path in
                            path.move(to: CGPoint(x: dot3X, y: dot3Y))
                            // Curve from dot3 to trophy
                            let control3X = (dot3X + trophyX) / 2
                            let control3Y = (dot3Y + trophyY) / 2
                            path.addQuadCurve(
                                to: CGPoint(x: trophyX, y: trophyY),
                                control: CGPoint(x: control3X - 20, y: control3Y)
                            )
                            path.addLine(to: CGPoint(x: trophyX, y: size.height))
                            path.addLine(to: CGPoint(x: dot3X, y: size.height))
                            path.closeSubpath()
                        }
                        
                        // Gradient 1: First circle to 3rd circle (gray to light orange)
                        context.fill(
                            fill1,
                            with: .linearGradient(
                                Gradient(colors: [
                                    Color.gray.opacity(0.15),
                                    Color(hex: "FF7300").opacity(0.1)
                                ]),
                                startPoint: CGPoint(x: dot1X, y: size.height / 2),
                                endPoint: CGPoint(x: dot3X, y: size.height / 2)
                            )
                        )
                        
                        context.fill(
                            fill2,
                            with: .linearGradient(
                                Gradient(colors: [
                                    Color.gray.opacity(0.15),
                                    Color(hex: "FF7300").opacity(0.1)
                                ]),
                                startPoint: CGPoint(x: dot1X, y: size.height / 2),
                                endPoint: CGPoint(x: dot3X, y: size.height / 2)
                            )
                        )
                        
                        // Gradient 2: 3rd circle to trophy (light orange to darker orange)
                        context.fill(
                            fill3,
                            with: .linearGradient(
                                Gradient(colors: [
                                    Color(hex: "FF7300").opacity(0.1),
                                    Color(hex: "FF7300").opacity(0.25)
                                ]),
                                startPoint: CGPoint(x: dot3X, y: size.height / 2),
                                endPoint: CGPoint(x: trophyX, y: size.height / 2)
                            )
                        )
                        
                        // Draw the main path with gradient (curved)
                        let progressPath = Path { path in
                            path.move(to: CGPoint(x: dot1X, y: dot1Y))
                            
                            // Curve from dot1 to dot2
                            let control1X = (dot1X + dot2X) / 2
                            let control1Y = dot1Y
                            path.addQuadCurve(
                                to: CGPoint(x: dot2X, y: dot2Y),
                                control: CGPoint(x: control1X, y: control1Y)
                            )
                            
                            // Curve from dot2 to dot3
                            let control2X = (dot2X + dot3X) / 2
                            let control2Y = (dot2Y + dot3Y) / 2
                            path.addQuadCurve(
                                to: CGPoint(x: dot3X, y: dot3Y),
                                control: CGPoint(x: control2X + 10, y: control2Y )
                            )
                            
                            // Curve from dot3 to trophy
                            let control3X = (dot3X + trophyX) / 2
                            let control3Y = (dot3Y + trophyY) / 2
                            path.addQuadCurve(
                                to: CGPoint(x: trophyX, y: trophyY),
                                control: CGPoint(x: control3X - 20, y: control3Y)
                            )
                        }
                        
                        context.stroke(
                            progressPath,
                            with: .linearGradient(
                                Gradient(stops: [
                                    .init(color: Color.black, location: 0.0),
                                    .init(color: Color(hex: "FF7300").opacity(0.7), location: 0.5),
                                    .init(color: Color(hex: "FF7300"), location: 1.0)
                                ]),
                                startPoint: CGPoint(x: dot1X, y: 0),
                                endPoint: CGPoint(x: trophyX, y: 0)
                            ),
                            lineWidth: 3
                        )
                    }
                    .frame(height: height * 0.7)
                    
                    // Data points - positioned to match line exactly
                    GeometryReader { geo in
                        let canvasHeight = height * 0.7
                        
                        // First circle
                        Circle()
                            .fill(Color.white)
                            .frame(width: 13, height: 13)
                            .overlay(
                                Circle()
                                    .stroke(.black, lineWidth: 2)
                            )
                            .position(x: 0, y: canvasHeight * 0.7 + 10)
                        
                        // Second circle
                        Circle()
                            .fill(Color.white)
                            .frame(width: 13, height: 13)
                            .overlay(
                                Circle()
                                    .stroke(.black, lineWidth: 2)
                            )
                            .position(x: geo.size.width * 0.25, y: canvasHeight * 0.7 + 3)

                        // Third circle
                        Circle()
                            .fill(Color.white)
                            .frame(width: 13, height: 13)
                            .overlay(
                                Circle()
                                    .stroke(.black, lineWidth: 2)
                            )
                            .position(x: geo.size.width * 0.5, y: canvasHeight * 0.5)
                        
                        // Trophy
                        ZStack {
                            Circle()
                                .fill(Color(hex: "FF7300"))
                                .frame(width: 32, height: 32)
                            
                            Image(systemName: "trophy.fill")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                        }
                        .position(x: geo.size.width, y: 0)
                    }
                    .frame(height: height * 0.7)
                }
                
                // Timeline labels
                ZStack(alignment: .topLeading) {
                    Text("3 Days")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.black)
                        .offset(x: width * 0.06, y: 0)
                    
                    Text("7 Days")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.black)
                        .offset(x: width * 0.32, y: 0)
                    
                    Text("30 Days")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.black)
                        .offset(x: width * 0.68, y: 0)
                }
                .padding(.top, 8)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

#Preview {
    OnboardingGraph4(onNext: {}, onBack: {}, progress: 0.80)
}
