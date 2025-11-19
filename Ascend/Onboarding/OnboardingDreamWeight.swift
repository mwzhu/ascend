import SwiftUI

struct OnboardingDreamWeight: View {
    @State private var isMetric = false
    @State private var dreamWeightLbs: Double = 110
    @State private var dreamWeightKg: Double = 49.9
    let onNext: () -> Void
    let onBack: () -> Void
    let progress: Double
    
    var displayWeight: String {
        if isMetric {
            return String(format: "%.1f", dreamWeightKg)
        } else {
            return String(format: "%.1f", dreamWeightLbs)
        }
    }
    
    var unit: String {
        isMetric ? "kg" : "lbs"
    }
    
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
                Text("What's Your Dream Weight?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                // Subtitle Text
                Text("Share your goal weight so we can map out your transformation.")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                
                Spacer()
                
                // Dream Weight Display and Slider
                VStack(spacing: 20) {
                    // Weight Display
                    VStack(spacing: 20) {
                        Text("Dream Weight")
                            .font(.system(size: 18, weight: .regular))
                            .foregroundColor(.black)
                        
                        HStack(alignment: .firstTextBaseline, spacing: 4) {
                            Text(displayWeight)
                                .font(.system(size: 36, weight: .heavy))
                                .foregroundColor(.black)
                            Text(unit)
                                .font(.system(size: 24, weight: .regular))
                                .foregroundColor(.black)
                        }
                    }
                    
                    // Ruler Slider
                    VStack(spacing: 16) {
                        RulerSlider(
                            value: isMetric ? $dreamWeightKg : $dreamWeightLbs,
                            range: isMetric ? 30...150 : 66...330,
                            unit: unit
                        )
                    }
                    .padding(.horizontal, 24)
                }
                
                Spacer()
                
                // Imperial/Metric Toggle
                HStack {
                    Spacer()
                    
                    Text("imperial")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(isMetric ? .gray : .black)
                    
                    Toggle("", isOn: $isMetric)
                        .labelsHidden()
                        .tint(.gray)
                        .frame(width: 50)
                    
                    Text("metric")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(isMetric ? .black : .gray)
                    
                    Spacer()
                }
                .padding(.bottom, 30)
                
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

struct RulerSlider: View {
    @Binding var value: Double
    let range: ClosedRange<Double>
    let unit: String
    
    var tickSpacing: CGFloat { 10 }
    
    var body: some View {
        GeometryReader { geometry in
            let totalTicks = Int((range.upperBound - range.lowerBound) * 10)
            let centerOffset = geometry.size.width / 2
            let valueOffset = CGFloat((value - range.lowerBound) * 10) * tickSpacing
            
            VStack(spacing: 8) {
                // Ruler marks
                ZStack {
                    HStack(spacing: 0) {
                        ForEach(0..<totalTicks, id: \.self) { i in
                            let tickValue = range.lowerBound + Double(i) / 10.0
                            let isWholeNumber = Int(tickValue * 10) % 10 == 0
                            let isCenter = abs(tickValue - value) < 0.05
                            
                            VStack(spacing: 8) {
                                Rectangle()
                                    .fill(isCenter ? Color.black : Color.gray.opacity(0.3))
                                    .frame(
                                        width: isCenter ? 2 : 1,
                                        height: isCenter ? 50 : (isWholeNumber ? 38 : 19)
                                    )
                                
                                if isWholeNumber {
                                    Text("\(Int(tickValue))")
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(.gray)
                                        .fixedSize()
                                } else {
                                    Text("")
                                        .font(.system(size: 14))
                                }
                            }
                            .frame(width: tickSpacing, alignment: .top)
                        }
                    }
                    .offset(x: centerOffset - valueOffset)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                let dragOffset = gesture.translation.width
                                let valueChange = -(dragOffset / tickSpacing) * 0.1
                                let newValue = min(max(value + valueChange, range.lowerBound), range.upperBound)
                                value = (newValue * 10).rounded() / 10
                            }
                    )
                }
                .frame(height: 95)
                .clipped()
                
                // Value badge below ruler
                Text(String(format: "%.1f", value) + " " + unit)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.black)
                    .cornerRadius(8)
            }
        }
        .frame(height: 135)
    }
}

#Preview {
    OnboardingDreamWeight(onNext: {}, onBack: {}, progress: 0.48)
}
