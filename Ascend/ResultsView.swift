//
//  ResultsView.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

struct ResultsView: View {
    @Binding var showJourney: Bool
    @Binding var journeySource: JourneySource
    @Binding var showLogPopup: Bool
    @State private var selectedDate = Date()
    @State private var showDateCircles = false
    @State private var showBookButton = false
    @State private var hasAnimatedBookButton = false
    
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
                            VStack(spacing: 12) {
                                BMICard()
                                DifferenceCard(valueText: "25.1lbs")
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        // Timeline
                        TimelineCard()
                        
                        // Selected Date's Log
                        LogCard()
                        .padding(.bottom, 10)

                        VStack(alignment: .leading, spacing: 0) {
                            Text("OPTIONS")
                                .font(.system(size: 11, weight: .regular))
                                .foregroundColor(.gray.opacity(0.8))
                                .padding(.horizontal, 20)
                                .padding(.bottom, 8)
                            
                            NavigationRow(icon: "scalemass.fill", title: "Weight Settings")
                            NavigationRow(icon: "heart.text.clipboard.fill", title: "Show All Weight Logs")
                        }
                        .padding(.bottom, 15)
                    
                    }
                    .padding(.top, 10)
                }
                
            }
            
            // Floating Buttons
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    VStack(spacing: 16) {
                        Button(action: {
                            journeySource = .results
                            showJourney = true
                        }) {
                            Image(systemName: "book.fill")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 63, height: 63)
                                .background(
                                    Circle()
                                        .fill(Color(red: 0.78, green: 0.78, blue: 0.78))
                                )
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
                        }
                        .opacity(showBookButton ? 1 : 0)
                        .offset(y: showBookButton ? 0 : 48)
                        .scaleEffect(showBookButton ? 1 : 0.5, anchor: .bottom)
                        
                        if !showLogPopup {
                            Button(action: {
                                showLogPopup = true
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 25, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(width: 63, height: 63)
                                    .background(Color.black)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                            }
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 17)
                }
            }
            
            if showLogPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .zIndex(2)
                    .onTapGesture {
                        showLogPopup = false
                    }

                LogOptionsPopup(isPresented: $showLogPopup)
                    .transition(.scale(scale: 0.9, anchor: .bottomTrailing).combined(with: .opacity))
                    .zIndex(3)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showLogPopup)
        .onAppear {
            guard !hasAnimatedBookButton else {
                showBookButton = true
                return
            }
            
            hasAnimatedBookButton = true
            showBookButton = false
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                    showBookButton = true
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
        .padding(14)
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
                .font(.system(size: 11))
                .foregroundColor(.gray.opacity(0.7))
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 10)
                    .frame(width: 120, height: 120)
                
                Circle()
                    .trim(from: 0, to: 1.0)
                    .stroke(
                        Color(hex: "B366FF"),
                        style: StrokeStyle(lineWidth: 10, lineCap: .round)
                    )
                    .frame(width: 120, height: 120)
                    .rotationEffect(.degrees(-90))
                
                Text("100%")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 6)
        }
        .frame(maxWidth: .infinity)
        .padding(14)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct BMICard: View {
    var body: some View {
        VStack(alignment: .leading, spacing:2.5) {
            HStack {
                Image(systemName: "waveform.path.ecg")
                    .font(.system(size: 17))
                    .foregroundColor(Color(hex: "B366FF"))
                Text("BMI")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
                Image(systemName: "info.circle")
                    .font(.system(size: 13))
                    .foregroundColor(.gray.opacity(0.7))
            }
            .padding(.bottom, 6)
            Text("22")
                .font(.system(size: 23, weight: .bold))
                .foregroundColor(.black)
            Text("Nov 3, 2:15 PM")
                .font(.system(size: 11))
                .foregroundColor(.gray.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(14)
        .background(Color.black.opacity(0.05))
        .cornerRadius(10)
    }
}

struct DifferenceCard: View {
    let valueText: String
    
    private var arrowIcon: String {
        let numericValue = extractNumericValue(from: valueText)
        return numericValue < 0 ? "arrow.down.right" : "arrow.up.right"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing:2.5) {
            HStack {
                Image(systemName: arrowIcon)
                    .font(.system(size: 17))
                    .foregroundColor(Color(hex: "B366FF"))
                Text("Difference")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
            }
            .padding(.bottom, 6)
            Text(valueText)
                .font(.system(size: 23, weight: .bold))
                .foregroundColor(.black)
            Text("From 174lbs, 11/02/25")
                .font(.system(size: 11))
                .foregroundColor(.gray.opacity(0.7))
        }
        .frame(maxWidth: .infinity)
        .padding(14)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
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
                            .frame(width: geometry.size.width * 0.33, height: 10)
                        
                        RoundedRectangle(cornerRadius: 3)
                            .fill(Color(hex: "B366FF").opacity(0.4))
                            .frame(width: geometry.size.width * 0.67, height: 10)
                    }
                }
            }
            .frame(height: 10)
        }
        .padding(14)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

#Preview {
    ResultsView(showJourney: .constant(false), journeySource: .constant(.results), showLogPopup: .constant(false))
}
