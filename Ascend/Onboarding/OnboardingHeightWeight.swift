import SwiftUI

struct OnboardingHeightWeight: View {
    @State private var isMetric = false
    @State private var heightImperial = "5'11\""
    @State private var heightCm = 180
    @State private var weightLbs = 117
    @State private var weightKg = 75
    let onNext: () -> Void
    let onBack: () -> Void
    let progress: Double
    
    // Generate imperial height options
    let imperialHeights: [String] = {
        var heights: [String] = []
        for feet in 4...7 {
            for inches in 0...11 {
                heights.append("\(feet)'\(inches)\"")
            }
        }
        return heights
    }()
    
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
                Text("Your Height & Weight")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                // Subtitle Text
                Text("Your current height and weight help us calculate your BMI and personalize your daily nutrition and activity goals.")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                
                Spacer()
                
                // Height and Weight Pickers
                HStack(spacing: 20) {
                    // Height Picker
                    VStack(spacing: 12) {
                        Text("Height")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                        
                        if isMetric {
                            Picker("", selection: $heightCm) {
                                ForEach(100...250, id: \.self) { cm in
                                    Text("\(cm)cm")
                                        .tag(cm)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 150)
                            .clipped()
                        } else {
                            Picker("", selection: $heightImperial) {
                                ForEach(imperialHeights, id: \.self) { height in
                                    Text(height)
                                        .tag(height)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 150)
                            .clipped()
                        }
                    }
                    
                    // Weight Picker
                    VStack(spacing: 12) {
                        Text("Weight")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.black)
                        
                        if isMetric {
                            Picker("", selection: $weightKg) {
                                ForEach(30...200, id: \.self) { kg in
                                    Text("\(kg)kg")
                                        .tag(kg)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 150)
                            .clipped()
                        } else {
                            Picker("", selection: $weightLbs) {
                                ForEach(60...400, id: \.self) { lbs in
                                    Text("\(lbs)lbs")
                                        .tag(lbs)
                                }
                            }
                            .pickerStyle(.wheel)
                            .frame(height: 150)
                            .clipped()
                        }
                    }
                }
                .padding(.horizontal, 24)
                
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

#Preview {
    OnboardingHeightWeight(onNext: {}, onBack: {}, progress: 0.40)
}
