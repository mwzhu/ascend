import SwiftUI

struct LogShot: View {
    @Binding var isPresented: Bool
    let source: LogShotSource
    @Binding var selectedTab: Tab
    
    @State private var selectedDate = Date()
    @State private var painLevel: Double = 0
    @State private var isDatePickerVisible = false
    
    private var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d, h:mma"
        return formatter.string(from: selectedDate)
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                ZStack {
                    HStack {
                        Button(action: {
                            withAnimation {
                                // Navigate back to the source tab
                                switch source {
                                case .home:
                                    selectedTab = .home
                                case .peptides:
                                    selectedTab = .peptides
                                case .results:
                                    selectedTab = .progress
                                }
                                isPresented = false
                            }
                        }) {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 21, weight: .regular))
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    Text("Peptide Log")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                }
                .padding(.top, 16)
                .padding(.bottom, 24)

                VStack(spacing: 24) {
                    VStack(alignment: .leading, spacing: 12) {
                        Button(action: {
                            withAnimation {
                                isDatePickerVisible.toggle()
                            }
                        }) {
                            HStack {
                                Label("Date", systemImage: "calendar")
                                    .font(.system(size: 15, weight: .semibold))
                                    .foregroundColor(.black)
                                Spacer()
                                Text(formattedDate)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.black.opacity(0.9))
                            }
                            .padding(.vertical, 4)
                        }
                        
                        if isDatePickerVisible {
                            Divider()
                            
                            DatePicker("", selection: $selectedDate, displayedComponents: [.hourAndMinute, .date])
                                .labelsHidden()
                                .datePickerStyle(.wheel)
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.gray).opacity(0.1))
                    )
                    .padding(.horizontal, 20)

                    if !isDatePickerVisible {
                        Spacer().frame(height: 216)
                    }
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("Today's Peptide")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                            .padding(.bottom, 14)
                        
                        LogRow(icon: "cross.case.fill", title: "Profile")
                        LogRow(icon: "cross.case.fill", title: "Treatment")
                        LogRow(icon: "bolt.fill", title: "Daily Lifestyle Goals")
                        LogRow(icon: "target", title: "Weight Goals")
                        SliderRow(icon: "face.smiling", title: "Pain Level", value: $painLevel)
                    }
                    
                    Button(action: {}) {
                        Text("Log Shot")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(red: 124/255, green: 84/255, blue: 248/255))
                            .cornerRadius(18)
                    }
                    .padding(.horizontal, 20)
                }
                
            }
        }
        .background(Color.white)
    }
}

#Preview {
    LogShot(isPresented: .constant(true), source: .home, selectedTab: .constant(.home))
}

struct LogRow: View {
    let icon: String
    let title: String
    var iconColor: Color = Color.gray.opacity(0.5)
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {}) {
                HStack(spacing: 10) {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(iconColor)
                        .frame(width: 28)
                    
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black.opacity(0.9))
                    
                    Spacer()
                    
                    Text("placeholder")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black.opacity(0.9))

                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.gray.opacity(0.5))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color.white)
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 0.5)
                .padding(.leading, 56)
        }
    }
}

struct SliderRow: View {
    let icon: String
    let title: String
    @Binding var value: Double
    var iconColor: Color = Color.gray.opacity(0.5)
    var range: ClosedRange<Double> = 0...10
    var step: Double = 1
    
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 12) {
                HStack(spacing: 10) {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(iconColor)
                        .frame(width: 28)
                    
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black.opacity(0.9))
                    
                    Spacer()
                    
                    Text("\(Int(value))")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black.opacity(0.9))
                }
                
                GeometryReader { geometry in
                    let padding: CGFloat = 40
                    let circleRadius: CGFloat = 12.5
                    let fullTrackWidth = geometry.size.width - padding
                    let circleTravelWidth = fullTrackWidth - (2 * circleRadius)
                    let progress = CGFloat((value - range.lowerBound) / (range.upperBound - range.lowerBound))
                    let circleCenterX = padding + circleRadius + (circleTravelWidth * progress)
                    let filledWidth = circleCenterX - padding + circleRadius
                    
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color(red: 124/255, green: 84/255, blue: 248/255).opacity(0.3))
                            .frame(width: fullTrackWidth, height: 8)
                            .cornerRadius(4)
                            .padding(.leading, padding)
                        
                        Rectangle()
                            .fill(Color(red: 124/255, green: 84/255, blue: 248/255))
                            .frame(width: min(filledWidth, fullTrackWidth), height: 8)
                            .cornerRadius(4)
                            .padding(.leading, padding)
                        
                        Circle()
                            .fill(Color(red: 124/255, green: 84/255, blue: 248/255))
                            .frame(width: 25, height: 25)
                            .offset(x: circleCenterX - circleRadius)
                            .gesture(
                                DragGesture(minimumDistance: 0)
                                    .onChanged { dragValue in
                                        let adjustedX = dragValue.location.x - padding - circleRadius
                                        let clampedX = max(0, min(adjustedX, circleTravelWidth))
                                        let newValue = range.lowerBound + (range.upperBound - range.lowerBound) * Double(clampedX / circleTravelWidth)
                                        value = min(max(newValue, range.lowerBound), range.upperBound)
                                        if step > 0 {
                                            value = round(value / step) * step
                                        }
                                    }
                            )
                    }
                }
                .frame(height: 25)
            }
            .padding(.horizontal, 20)
            .padding(.top, 12)
            .padding(.bottom, 2)
            .background(Color.white)

        }
    }
}
