//
//  ResultsView.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

struct ResultsView: View {
    @State private var selectedDate = Date()
    @State private var showDateCircles = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Row - Logo, Date, Streak
                HStack {
                    Text("Progress")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        showDateCircles.toggle()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "calendar")
                                .font(.system(size: 19))
                                .foregroundColor(.gray).opacity(0.5)
                            Text(dateString)
                                .font(.system(size: 15, weight: .semibold))
                        }
                        .foregroundColor(.black)
                    }
                    
                    Spacer()
                        .frame(width: 20)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 19))
                            .foregroundColor(.orange).opacity(0.7)
                        Text("7")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 2)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        // Date Circles Row
                        if showDateCircles {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(0..<14) { index in
                                        let date = Calendar.current.date(byAdding: .day, value: index - 7, to: Date())!
                                        DateCircle(
                                            date: date,
                                            isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate),
                                            circleStyle: index % 3 == 0 ? .blank : (index % 3 == 1 ? .grayWithIcon : .orangeWithIcon)
                                        ) {
                                            selectedDate = date
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        } else {
                            Spacer().frame(height: 1)
                        }
                        
                        // Weight Chart
                        WeightChartCard()
                        
                        // Progress and BMI Row
                        HStack(spacing: 12) {
                            ProgressCircleCard()
                            BMICard()
                        }
                        .padding(.horizontal, 20)
                        
                        // Difference Card
                        DifferenceCard()
                        
                        // Timeline
                        TimelineCard()
                        
                        // Selected Date's Log
                        LogCard()
                        
                        Spacer().frame(height: 80)
                    }
                    .padding(.top, 10)
                }
                
                Spacer()
            }
            
            // Plus Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {}) {
                        Image(systemName: "plus")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 60, height: 60)
                            .background(Color.black)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 90)
                }
            }
        }
    }
    
    var dateString: String {
        if Calendar.current.isDateInToday(selectedDate) {
            return "Today"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: selectedDate)
    }
}

struct WeightChartCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                HStack(spacing: 6) {
                    Image(systemName: "scalemass.fill")
                        .font(.system(size: 17))
                        .foregroundColor(Color(hex: "B366FF"))
                    Text("Weight(lbs)")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                HStack(spacing: 6) {
                    Button(action: {}) {
                        Text("7d")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.black)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(Color.gray.opacity(0.15))
                            .cornerRadius(6)
                    }
                    Button(action: {}) {
                        Text("30d")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    Button(action: {}) {
                        Text("90d")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                    Button(action: {}) {
                        Text("1y")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.gray)
                    }
                }
            }
            
            VStack(alignment: .trailing, spacing: 3) {
                Text("148.9lbs")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                Text("Nov 17, 1:33 PM")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.top, 4)
            
            GeometryReader { geometry in
                Canvas { context, size in
                    let path = Path { path in
                        path.move(to: CGPoint(x: 0, y: size.height * 0.5))
                        path.addLine(to: CGPoint(x: size.width, y: size.height * 0.5))
                    }
                    context.stroke(path, with: .color(Color(hex: "B366FF")), lineWidth: 2.5)
                    
                    let circleX = size.width * 0.85
                    let circleY = size.height * 0.5
                    context.fill(
                        Path(ellipseIn: CGRect(x: circleX - 5, y: circleY - 5, width: 10, height: 10)),
                        with: .color(Color(hex: "B366FF"))
                    )
                }
            }
            .frame(height: 80)
        }
        .padding(12)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

struct ProgressCircleCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "target")
                    .font(.system(size: 17))
                    .foregroundColor(Color(hex: "B366FF"))
                Text("Progress")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }
            
            Text("Goal Weight: 160lbs")
                .font(.system(size: 12))
                .foregroundColor(.gray)
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 10)
                    .frame(width: 90, height: 90)
                
                Circle()
                    .trim(from: 0, to: 1.0)
                    .stroke(
                        Color(hex: "B366FF"),
                        style: StrokeStyle(lineWidth: 10, lineCap: .round)
                    )
                    .frame(width: 90, height: 90)
                    .rotationEffect(.degrees(-90))
                
                Text("100%")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.black.opacity(0.05))
        .cornerRadius(10)
    }
}

struct BMICard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "waveform.path.ecg")
                    .font(.system(size: 17))
                    .foregroundColor(Color(hex: "B366FF"))
                Text("BMI")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "info.circle")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 3) {
                Text("22")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.black)
                Text("Nov 3, 2:15 PM")
                    .font(.system(size: 11))
                    .foregroundColor(.gray)
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(16)
        .background(Color.black.opacity(0.05))
        .cornerRadius(10)
    }
}

struct DifferenceCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "arrow.down.right")
                    .font(.system(size: 17))
                    .foregroundColor(Color(hex: "B366FF"))
                Text("Difference")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text("-25.1lbs")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                Text("From 174lbs, 11/02/25")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.black.opacity(0.05))
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

struct TimelineCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "calendar")
                    .font(.system(size: 17))
                    .foregroundColor(Color(hex: "B366FF"))
                Text("Timeline")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                
                HStack(spacing: 3) {
                    Text("Est. Date")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text("Nov 17, 2025")
                        .font(.system(size: 11, weight: .semibold))
                        .foregroundColor(.black)
                }
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                .background(Color.gray.opacity(0.15))
                .cornerRadius(6)
            }
            
            HStack(alignment: .center, spacing: 0) {
                VStack(spacing: 3) {
                    Text("174lbs")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                    Text("Nov 2, 2025")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                
                VStack(spacing: 3) {
                    Text("149lbs")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                    Text("Nov 3, 2025")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                
                VStack(spacing: 3) {
                    Text("160lbs")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.black)
                    Text("Today, 1:33 PM")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 3)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 6)
                    
                    HStack(spacing: 0) {
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color(hex: "B366FF"))
                            .frame(width: geometry.size.width * 0.33, height: 6)
                        
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color(hex: "B366FF").opacity(0.4))
                            .frame(width: geometry.size.width * 0.67, height: 6)
                    }
                }
            }
            .frame(height: 6)
        }
        .padding(16)
        .background(Color.black.opacity(0.05))
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

#Preview {
    ResultsView()
}
