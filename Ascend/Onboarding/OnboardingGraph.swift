import SwiftUI

struct OnboardingGraph: View {
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
                
                // Graph Section
                VStack(spacing: 0) {
                    WeightLossGraph()
                        .frame(height: 240)
                        .padding(.horizontal, 24)
                    
                    Text("82% of Ascend users maintain their results even 6 months later")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundColor(.black.opacity(0.8))
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 24)
                        .padding(.top, 24)
                }
                .padding(.vertical, 32)
                .background(Color.gray.opacity(0.075))
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

struct WeightLossGraph: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Your Weight")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                    
                    ZStack(alignment: .topTrailing) {
                        Canvas { context, size in
                            let startX: CGFloat = 8
                            let startY: CGFloat = size.height * 0.40

                            let traditionalPath = Path { path in
                                path.move(to: CGPoint(x: size.width*0.4, y: size.height*0.55))
                                path.addCurve(
                                    to: CGPoint(x: size.width * 0.6, y: size.height * 0.4),
                                    control1: CGPoint(x: size.width * 0.47, y: size.height * 0.55),
                                    control2: CGPoint(x: size.width * 0.55, y: size.height * 0.42)
                                )
                                path.addCurve(
                                    to: CGPoint(x: size.width * 0.8, y: size.height * 0.6),
                                    control1: CGPoint(x: size.width * 0.65, y: size.height * 0.42),
                                    control2: CGPoint(x: size.width * 0.7, y: size.height * 0.55),
                                )
                                path.addCurve(
                                    to: CGPoint(x: size.width, y: size.height * 0.3),
                                    control1: CGPoint(x: size.width * 0.85, y: size.height * 0.55),
                                    control2: CGPoint(x: size.width * 0.9, y: size.height * 0.48),
                                )
                            }

                            let betweenPathsFill = Path { path in
                                path.move(to: CGPoint(x: size.width*0.4, y: size.height*0.55))
                                path.addCurve(
                                    to: CGPoint(x: size.width * 0.6, y: size.height * 0.4),
                                    control1: CGPoint(x: size.width * 0.47, y: size.height * 0.55),
                                    control2: CGPoint(x: size.width * 0.55, y: size.height * 0.42)
                                )
                                path.addCurve(
                                    to: CGPoint(x: size.width * 0.8, y: size.height * 0.6),
                                    control1: CGPoint(x: size.width * 0.65, y: size.height * 0.42),
                                    control2: CGPoint(x: size.width * 0.7, y: size.height * 0.55),
                                )
                                path.addCurve(
                                    to: CGPoint(x: size.width, y: size.height * 0.3),
                                    control1: CGPoint(x: size.width * 0.85, y: size.height * 0.55),
                                    control2: CGPoint(x: size.width * 0.9, y: size.height * 0.48),
                                )
                                path.addLine(to: CGPoint(x: size.width, y: size.height * 0.9))
                                path.addCurve(
                                    to: CGPoint(x: size.width * 0.5, y: size.height * 0.65),
                                    control1: CGPoint(x: size.width * 0.85, y: size.height * 0.85),
                                    control2: CGPoint(x: size.width * 0.7, y: size.height * 0.8)
                                )
                                path.addCurve(
                                    to: CGPoint(x: size.width*0.4, y: size.height*0.55),
                                    control1: CGPoint(x: size.width * 0.4, y: size.height * 0.55),
                                    control2: CGPoint(x: size.width * 0.3, y: size.height * 0.4)
                                )
                                path.closeSubpath()
                            }
                            
                            context.fill(
                                betweenPathsFill,
                                with: .linearGradient(
                                    Gradient(colors: [
                                        Color(red: 0.85, green: 0.4, blue: 0.4).opacity(0.2),
                                        Color(red: 0.85, green: 0.4, blue: 0.4).opacity(0.05)
                                    ]),
                                    startPoint: CGPoint(x: size.width / 2, y: 0),
                                    endPoint: CGPoint(x: size.width / 2, y: size.height)
                                )
                            )
                            
                            context.stroke(
                                traditionalPath,
                                with: .color(Color(red: 0.85, green: 0.4, blue: 0.4).opacity(0.9)),
                                lineWidth: 2.5
                            )
                            
                            let ascendPath = Path { path in
                                path.move(to: CGPoint(x: startX, y: startY))
                                path.addCurve(
                                    to: CGPoint(x: size.width * 0.5, y: size.height * 0.65),
                                    control1: CGPoint(x: size.width * 0.3, y: size.height * 0.4),
                                    control2: CGPoint(x: size.width * 0.4, y: size.height * 0.55)
                                )
                                path.addCurve(
                                    to: CGPoint(x: size.width, y: size.height * 0.9),
                                    control1: CGPoint(x: size.width * 0.7, y: size.height * 0.8),
                                    control2: CGPoint(x: size.width * 0.85, y: size.height * 0.85)
                                )
                            }
                            
                            context.stroke(
                                ascendPath,
                                with: .color(Color(hex: "FF7300").opacity(0.4)),
                                lineWidth: 2.5
                            )
                            
                            let ascendFillPath = Path { path in
                                path.move(to: CGPoint(x: startX, y: startY))
                                path.addCurve(
                                    to: CGPoint(x: size.width * 0.5, y: size.height * 0.65),
                                    control1: CGPoint(x: size.width * 0.3, y: size.height * 0.4),
                                    control2: CGPoint(x: size.width * 0.4, y: size.height * 0.55)
                                )
                                path.addCurve(
                                    to: CGPoint(x: size.width, y: size.height * 0.9),
                                    control1: CGPoint(x: size.width * 0.7, y: size.height * 0.8),
                                    control2: CGPoint(x: size.width * 0.85, y: size.height * 0.85)
                                )
                                path.addLine(to: CGPoint(x: size.width, y: size.height))
                                path.addLine(to: CGPoint(x: startX, y: size.height))
                                path.closeSubpath()
                            }
                            
                            context.fill(
                                ascendFillPath,
                                with: .linearGradient(
                                    Gradient(colors: [
                                        Color(hex: "FF7300").opacity(0.2),
                                        Color(hex: "FF7300").opacity(0.03)
                                    ]),
                                    startPoint: CGPoint(x: size.width / 2, y: 0),
                                    endPoint: CGPoint(x: size.width / 2, y: size.height)
                                )
                            )
                        }
                        
                        Circle()
                            .fill(Color.white)
                            .frame(width: 12, height: 12)
                            .overlay(
                                Circle()
                                    .stroke(Color(hex: "FF7300").opacity(0.4), lineWidth: 2)
                            )
                            .position(x: 10, y: height * 0.33)
                        
                        Circle()
                            .fill(Color.white)
                            .frame(width: 12, height: 12)
                            .overlay(
                                Circle()
                                    .stroke(Color(hex: "FF7300").opacity(0.4), lineWidth: 2)
                            )
                            .position(x: width, y: height * 0.73)
                        
                        VStack(alignment: .trailing, spacing: 4) {
                            Text("Traditional Diets")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(Color(red: 0.85, green: 0.4, blue: 0.4))
                        }
                        .offset(x: -12, y: height * 0.25)
                        
                        HStack(alignment: .center, spacing: 8) {
                            Image(systemName: "applelogo")
                                .font(.system(size: 14))
                                .foregroundColor(.black)
                            Text("ASCEND")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.black)
                        }
                        .position(x: 40, y: height * 0.78)
                    }
                    .padding(.bottom, 10)
                    
                    HStack {
                        Text("Month 1")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.black)
                        Spacer()
                        Text("Month 6")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundColor(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingGraph(onNext: {})
}
