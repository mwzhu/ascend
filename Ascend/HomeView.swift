//
//  HomeView.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

enum Tab {
    case home
    case peptides
    case progress
    case library
    case account
}

enum JourneySource {
    case results
    case account
}

enum LogShotSource {
    case home
    case peptides
    case results
}

func extractNumericValue(from string: String) -> Double {
    let pattern = #"-?\d+\.?\d*"#
    if let regex = try? NSRegularExpression(pattern: pattern),
       let match = regex.firstMatch(in: string, range: NSRange(string.startIndex..., in: string)),
       let range = Range(match.range, in: string) {
        return Double(string[range]) ?? 0
    }
    return 0
}

struct HomeView: View {
    @State private var selectedDate = Date()
    @State private var showDateCircles = false
    @State private var selectedTab: Tab = .home
    @State private var showJourney = false
    @State private var showLogPopup = false
    @State private var journeySource: JourneySource = .account
    @State private var showLogShot = false
    @State private var logShotSource: LogShotSource = .home
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                currentView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if !showJourney && !showLogPopup {
                    BottomNavBar(selectedTab: $selectedTab)
                }
            }
            
            if showJourney {
                JourneyView(isPresented: $showJourney, source: journeySource, selectedTab: $selectedTab)
                    .transition(.move(edge: .trailing))
                    .zIndex(1)
            }

            if showLogPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .zIndex(2)
                    .onTapGesture {
                        showLogPopup = false
                    }

                LogOptionsPopup(
                    isPresented: $showLogPopup,
                    onLogPeptide: {
                        logShotSource = determineLogShotSource()
                        showLogPopup = false
                        showLogShot = true
                    }
                )
                .transition(.scale(scale: 0.9, anchor: .bottomTrailing).combined(with: .opacity))
                .zIndex(3)
            }
            
            if showLogShot {
                LogShot(
                    isPresented: $showLogShot,
                    source: logShotSource,
                    selectedTab: $selectedTab
                )
                .transition(.move(edge: .trailing))
                .zIndex(4)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: showJourney)
        .animation(.easeInOut(duration: 0.2), value: showLogPopup)
        .animation(.easeInOut(duration: 0.3), value: showLogShot)
    }
    
    private func determineLogShotSource() -> LogShotSource {
        switch selectedTab {
        case .home:
            return .home
        case .peptides:
            return .peptides
        case .progress:
            return .results
        default:
            return .home
        }
    }
    
    @ViewBuilder
    private var currentView: some View {
        switch selectedTab {
        case .home:
            HomeContentView(
                selectedDate: $selectedDate,
                showDateCircles: $showDateCircles,
                showLogPopup: $showLogPopup
            )
        case .peptides:
            PeptidesView(
                showLogPopup: $showLogPopup,
                onLogPeptide: {
                    logShotSource = .peptides
                    showLogPopup = false
                    showLogShot = true
                }
            )
        case .progress:
            ResultsView(
                showJourney: $showJourney,
                journeySource: $journeySource,
                showLogPopup: $showLogPopup,
                onLogPeptide: {
                    logShotSource = .results
                    showLogPopup = false
                    showLogShot = true
                }
            )
        case .library:
            LibraryView()
        case .account:
            AccountView(showJourney: $showJourney, journeySource: $journeySource)
        }
    }
}

struct HomeContentView: View {
    @Binding var selectedDate: Date
    @Binding var showDateCircles: Bool
    @Binding var showLogPopup: Bool
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Row - Logo, Date, Streak
                HStack {
                    Text("ASCEND")
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
                        
                        // To Do List
                        ToDoListCard()
                        
                        // Health Metrics Grid
                        HStack(alignment: .top, spacing: 12) {
                            VStack(spacing: 12) {
                                CaloriesCard(icon: "bolt.fill", title: "Calories ", value: "6666.5", goal: "8888", color: .orange)
                                ProteinCard(icon: "fork.knife", title: "Protein", value: "666", goal: "888.9g", color: .purple)
                                OtherCard(metrics: [
                                    OtherMetric(label: "Fiber", value: "485", goal: "1648kcal"),
                                    OtherMetric(label: "Carbs", value: "8", goal: "226g"),
                                    OtherMetric(label: "Fat", value: "31.5", goal: "43g")
                                ])
                            }
                            .frame(maxWidth: .infinity, alignment: .top)
                            
                            VStack(spacing: 12) {
                                WaterCard(icon: "drop.fill", title: "Water", value: "120oz", goal: "160.3oz", color: .blue)
                                GoalCard(icon: "fork.knife", title: "Goal", value: "222lbs", goal: "222lbs", color: .green)                            }
                            .frame(maxWidth: .infinity, alignment: .top)
                        }
                        .padding(.horizontal, 20)
                        
                        ActivityCard(
                            icon: "figure.run",
                            title: "Activity",
                            value: "3504",
                            goal: "5000",
                            color: .red,
                            workoutValue: "60",
                            workoutGoal: "30min"
                        )
                            .padding(.horizontal, 20)
                        
                        // Selected Date's Log
                        LogCard()
                        .padding(.bottom, 10)
                        
                        VStack(alignment: .leading, spacing: 0) {
                            Text("OPTIONS")
                                .font(.system(size: 11, weight: .regular))
                                .foregroundColor(.gray.opacity(0.8))
                                .padding(.horizontal, 20)
                                .padding(.bottom, 8)
                            
                            NavigationRow(icon: "scalemass.fill", title: "Lifestyle Goal Settings")
                        }
                        .padding(.bottom, 12)
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
                        .padding(.trailing, 20)
                        .padding(.bottom, 17)
                    }
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

enum DateCircleStyle {
    case blank
    case grayWithIcon
    case orangeWithIcon
}

struct DateCircle: View {
    let date: Date
    let isSelected: Bool
    let circleStyle: DateCircleStyle
    let onTap: () -> Void
    
    private var dayLetter: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEEE"
        return formatter.string(from: date)
    }
    
    var body: some View {
        Button(action: onTap) {
            VStack(spacing: 3) {
                ZStack {
                    Circle()
                        .fill(circleBackground)
                        .frame(width: 26, height: 26)
                    
                    Circle()
                        .strokeBorder(
                            style: StrokeStyle(
                                lineWidth: 1,
                                dash: [4, 4]
                            )
                        )
                        .foregroundColor(borderColor)
                        .frame(width: circleSize, height: circleSize)
                    
                    if showIcon {
                        Image(systemName: "syringe.fill")
                            .font(.system(size: 12))
                            .foregroundColor(iconColor)
                    }
                }
                .frame(height: 38)
                
                Text(dayLetter)
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(.black)
            }
            .padding(.vertical, 2)
            .padding(.horizontal, 4)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(isSelected ? Color.gray.opacity(0.14) : Color.clear)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private var circleSize: CGFloat {
        switch circleStyle {
        case .orangeWithIcon:
            return 26
        case .blank, .grayWithIcon:
            return 30
        }
    }
    
    private var circleBackground: Color {
        switch circleStyle {
        case .blank:
            return Color.gray.opacity(0.11)
        case .grayWithIcon:
            return Color.gray.opacity(0.11)
        case .orangeWithIcon:
            return Color(hex: "FF7300")
        }
    }
    
    private var borderColor: Color {
        return Color(hex: "FF7300")
    }
    
    private var showIcon: Bool {
        switch circleStyle {
        case .blank:
            return false
        case .grayWithIcon, .orangeWithIcon:
            return true
        }
    }
    
    private var iconColor: Color {
        switch circleStyle {
        case .grayWithIcon:
            return Color.gray.opacity(0.55)
        case .orangeWithIcon:
            return .white
        case .blank:
            return .clear
        }
    }
}

struct ToDoListCard: View {
    @State private var isExpanded = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Button(action: {
                withAnimation(.easeInOut(duration: 0.3)) {
                    isExpanded.toggle()
                }
            }) {
                HStack {
                    Text("Peptide Day")
                        .font(.system(size: 30, weight: .bold))
                        .foregroundStyle(
                            LinearGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color(hex: "FF7300"), location: 0.0),
                                    .init(color: Color(hex: "FF8000"), location: 0.15),
                                    .init(color: Color(hex: "FF8F00"), location: 0.35),
                                    .init(color: Color(hex: "FFA200"), location: 0.5),
                                    .init(color: Color(hex: "FFB300"), location: 0.7),
                                    .init(color: Color(hex: "FFC400"), location: 0.85),
                                    .init(color: Color(hex: "FFD700"), location: 1.0)
                                ]),
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .shadow(color: Color(hex: "FFB300").opacity(0.25), radius: 4, x: 0, y: 0)
                    Spacer()
                    Text(isExpanded ? "See Less" : "See More")
                        .font(.system(size: 14))
                        .foregroundColor(.gray.opacity(0.5))
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 16)
            }
            .buttonStyle(PlainButtonStyle())
            .zIndex(1)
            
            VStack(spacing: 0) {
                ToDoItem(title: "Morning injection", time: "8:00 AM", isChecked: true)
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 1)
                    .overlay(
                        Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                            .foregroundColor(.gray.opacity(0.3))
                    )
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                
                ToDoItem(title: "Thymosin Beta-4 (100mg)", time: "2:00 PM", isChecked: false)
                
                Rectangle()
                    .fill(Color.clear)
                    .frame(height: 1)
                    .overlay(
                        Rectangle()
                            .stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                            .foregroundColor(.gray.opacity(0.3))
                    )
                    .padding(.horizontal, 20)
                    .padding(.vertical, 12)
                
                ToDoItem(title: "Evening injection", time: "8:00 PM", isChecked: false)
            }
            .padding(.bottom, isExpanded ? 20 : 0)
            .frame(height: isExpanded ? nil : 0, alignment: .top)
            .opacity(isExpanded ? 1 : 0)
            .clipped()
            .allowsHitTesting(isExpanded)
            .zIndex(0)
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [4, 4]))
                .foregroundColor(.gray.opacity(0.3))
                .padding(6)
        )
        .padding(.horizontal, 20)
    }
}

struct ToDoItem: View {
    let title: String
    let time: String
    let isChecked: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.gray.opacity(0.32), lineWidth: 2)
                    .frame(width: 18, height: 18)
                    .background(
                        RoundedRectangle(cornerRadius: 6)
                            .fill(Color.clear)
                    )
                
                if isChecked {
                    Image(systemName: "checkmark")
                        .font(.system(size: 8, weight: .black))
                        .foregroundColor(.black)
                }
            }
            .frame(width: 24, height: 24)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isChecked ? .gray.opacity(0.6) : .black)
                    .strikethrough(isChecked, color: .gray.opacity(0.6))
            }
            
            Spacer()
            
            Text(time)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.gray.opacity(0.9))
        }
        .padding(.horizontal, 20)
    }
}

struct CaloriesCard: View {
    let icon: String
    let title: String
    let value: String
    let goal: String
    let color: Color
    @State private var quantity: Int = 1
    
    private var progress: CGFloat {
        let valueNum = extractNumericValue(from: value)
        let goalNum = extractNumericValue(from: goal)
        return min(max(valueNum / goalNum, 0), 1)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(color)
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.black)
                              
                HStack(spacing: 0) {
                    Image(systemName: "minus")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 16, height: 16)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                    
                    Text("888")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black.opacity(0.9))
                        .frame(minWidth: 30)
                    
                    Image(systemName: "plus")
                        .font(.system(size: 9, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 16, height: 16)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(Circle())
                } 
            }
            .padding(.bottom, 14)
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(value)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.black)
                Text("/ \(goal)")
                    .font(.system(size: 11))
                    .foregroundColor(.black.opacity(0.25))
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 9)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(color)
                        .frame(width: geometry.size.width * progress, height: 9)
                }
            }
            .frame(height: 9)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct CupShape: InsettableShape {
    var insetAmount: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let insetRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        var path = Path()
        
        let topInset: CGFloat = insetRect.width * 0.06
        let bottomInset: CGFloat = insetRect.width * 0.14
        let cornerRadius: CGFloat = insetRect.width * 0.15
        
        let topLeft = CGPoint(x: insetRect.minX + topInset, y: insetRect.minY)
        let topRight = CGPoint(x: insetRect.maxX - topInset, y: insetRect.minY)
        let bottomLeft = CGPoint(x: insetRect.minX + bottomInset, y: insetRect.maxY)
        let bottomRight = CGPoint(x: insetRect.maxX - bottomInset, y: insetRect.maxY)
        
        path.move(to: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y))
        path.addLine(to: CGPoint(x: topRight.x - cornerRadius, y: topRight.y))
        path.addQuadCurve(to: CGPoint(x: topRight.x, y: topRight.y + cornerRadius),
                          control: topRight)
        path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y - cornerRadius))
        path.addQuadCurve(to: CGPoint(x: bottomRight.x - cornerRadius, y: bottomRight.y),
                          control: bottomRight)
        path.addLine(to: CGPoint(x: bottomLeft.x + cornerRadius, y: bottomLeft.y))
        path.addQuadCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y - cornerRadius),
                          control: bottomLeft)
        path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y + cornerRadius))
        path.addQuadCurve(to: CGPoint(x: topLeft.x + cornerRadius, y: topLeft.y),
                          control: topLeft)
        path.closeSubpath()
        
        return path
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var shape = self
        shape.insetAmount += amount
        return shape
    }
}

struct ActivityCard: View {
    let icon: String
    let title: String
    let value: String
    let goal: String
    let color: Color
    let workoutValue: String
    let workoutGoal: String
    
    private var progress: CGFloat {
        let valueNum = extractNumericValue(from: value)
        let goalNum = extractNumericValue(from: goal)
        return min(max(valueNum / goalNum, 0), 1)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                HStack(spacing: 4) {
                    Image(systemName: icon)
                        .font(.system(size: 16))
                        .foregroundColor(color)
                    
                    Text(title)
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Steps")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.black.opacity(0.8))
                    
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text(value)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.black)
                        Text("/\(goal)")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.black.opacity(0.25))
                    }
                }

                VStack(alignment: .leading, spacing: 2) {
                    Text("Workout")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.black.opacity(0.8))
                    
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text(value)
                            .font(.system(size: 15, weight: .semibold))
                            .foregroundColor(.black)
                        Text("/\(goal)")
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(.black.opacity(0.25))
                    }
                }
            }
            
            let footprintCount = 14
            let filledFootprints = Int((progress * CGFloat(footprintCount)).rounded(.down))
            
            HStack(spacing: 6) {
                ForEach(0..<footprintCount, id: \.self) { index in
                    Image(systemName: "shoeprints.fill")
                        .font(.system(size: 16))
                        .foregroundColor(index < filledFootprints ? Color(red: 0.93, green: 0.1, blue: 0.08) : Color(red: 0.93, green: 0.1, blue: 0.08).opacity(0.35))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct ProteinCard: View {
    let icon: String
    let title: String
    let value: String
    let goal: String
    let color: Color
    @State private var quantity: Int = 1
    
    private var progress: CGFloat {
        let valueNum = extractNumericValue(from: value)
        let goalNum = extractNumericValue(from: goal)
        return min(max(valueNum / goalNum, 0), 1)
    }
    
    var body: some View {
        VStack(spacing: 18) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(color)
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                    
            }
            
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 9)
                    .frame(width: 110, height: 110)
                
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(color, style: StrokeStyle(lineWidth: 9, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                    .frame(width: 110, height: 110)
                
                VStack(spacing: 0) {
                    Text("\(value)/\(goal)")
                        .font(.system(size: 17, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            .multilineTextAlignment(.center)
            .multilineTextAlignment(.center)

            HStack(spacing: 3) {
                Image(systemName: "minus")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 16, height: 16)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
                
                Text("88g")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.black.opacity(0.9))
                    .padding(.horizontal, 4)
                    .fixedSize()
                
                Image(systemName: "plus")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 16, height: 16)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct WaterCard: View {
    let icon: String
    let title: String
    let value: String
    let goal: String
    let color: Color
    @State private var quantity: Int = 1
    
    private var progress: CGFloat {
        let valueNum = extractNumericValue(from: value)
        let goalNum = extractNumericValue(from: goal)
        return min(max(valueNum / goalNum, 0), 1)
    }
    
    var body: some View {
        VStack(spacing: 18) {
            HStack(spacing: 4) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(color)
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.black)
                
                Spacer()
                    
            }
            
            GeometryReader { geometry in
                ZStack {
                    CupShape()
                        .stroke(Color.gray.opacity(0.2), lineWidth: 6)
                    
                    CupShape()
                        .inset(by: 3)
                        .fill(color.opacity(0.6))
                        .mask(
                            VStack {
                                Spacer()
                                Rectangle()
                                    .frame(height: geometry.size.height * progress)
                            }
                        )
                    
                    Text(value)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            .frame(width: 90, height: 110)

            HStack(spacing: 3) {
                Image(systemName: "minus")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 16, height: 16)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
                
                Text("20oz")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.black.opacity(0.9))
                    .padding(.horizontal, 4)
                    .fixedSize()
                
                Image(systemName: "plus")
                    .font(.system(size: 9, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 16, height: 16)
                    .background(Color.gray.opacity(0.2))
                    .clipShape(Circle())
            }
            .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct GoalCard: View {
    let icon: String
    let title: String
    let value: String
    let goal: String
    let color: Color
    @State private var quantity: Int = 1
    
    private var progress: CGFloat {
        let valueNum = extractNumericValue(from: value)
        let goalNum = extractNumericValue(from: goal)
        return min(max(valueNum / goalNum, 0), 1)
    }
    
    private var progressText: String {
        let safeProgress = progress.isFinite ? progress : 0
        let percent = Int((safeProgress * 100).rounded())
        return "\(percent)% of goal"
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(color)
                Text(title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.black)
                Spacer()
            }
            
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                let start = CGPoint(x: width * 0.05, y: height * 0.85)
                let peak = CGPoint(x: width * 0.2, y: height * 0.2)
                let dip = CGPoint(x: width * 0.38, y: height * 0.7)
                let current = CGPoint(x: width * 0.58, y: height * 0.45)
                let projected = CGPoint(x: width * 0.95, y: height * 0.7)
                
                ZStack {
                    Path { path in
                        path.move(to: start)
                        path.addQuadCurve(to: peak, control: CGPoint(x: width * 0.1, y: height * 0.35))
                        path.addQuadCurve(to: current, control: CGPoint(x: width * 0.44, y: height * 0.15))
                    }
                    .stroke(color, style: StrokeStyle(lineWidth: 3.5, lineCap: .round))
                    
                    Path { path in
                        path.move(to: current)
                        path.addQuadCurve(to: projected, control: CGPoint(x: width * 0.75, y: height * 0.55))
                    }
                    .stroke(color.opacity(0.4), style: StrokeStyle(lineWidth: 3.5, lineCap: .round, dash: [6, 6]))
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 16, height: 16)
                        .shadow(color: color.opacity(0.3), radius: 6, x: 0, y: 4)
                        .position(current)
                    
                    Circle()
                        .fill(color)
                        .frame(width: 10, height: 10)
                        .position(current)
                }
            }
            .padding(.vertical, -18)
            .frame(height: 100)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(progressText)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2.5)
                    .background(color)
                    .clipShape(Capsule())
                    .padding(.bottom, 4)
            
                Text(value)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                
                Text(goal)
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(.black.opacity(0.25))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct OtherCard: View {
    let metrics: [OtherMetric]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Other")
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(.black)
                .padding(.bottom, 8)
            
            ForEach(metrics) { metric in
                OtherMetricRow(metric: metric)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(14)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

struct OtherMetric: Identifiable {
    let id = UUID()
    let label: String
    let value: String
    let goal: String
}

struct OtherMetricRow: View {
    let metric: OtherMetric
    
    private var progress: CGFloat {
        let valueNum = extractNumericValue(from: metric.value)
        let goalNum = extractNumericValue(from: metric.goal)
        return min(max(valueNum / goalNum, 0), 1)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 1) {
            HStack {
                Text(metric.label)
                    .font(.system(size: 11, weight: .semibold))
                    .foregroundColor(.black.opacity(0.9))
                
                Spacer()
                
                Text("\(metric.value)/\(metric.goal)")
                    .font(.system(size: 11))
                    .foregroundColor(.black.opacity(0.9))
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.12))
                        .frame(height: 4)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.black)
                        .frame(width: geometry.size.width * progress, height: 4)
                }
            }
            .frame(height: 4)
        }
    }
}

struct LogCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Selected Date's Log")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
            }
            
            LogEntry(time: "8:00 AM", title: "Morning Injection", subtitle: "2.5mg administered")
            LogEntry(time: "9:30 AM", title: "Breakfast", subtitle: "High protein meal")
            LogEntry(time: "2:00 PM", title: "Symptoms", subtitle: "Feeling great, no side effects")
        }
        .padding(20)
        .background(Color.black.opacity(0.05))
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

struct LogEntry: View {
    let time: String
    let title: String
    let subtitle: String
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 2) {
                Text(time)
                    .font(.system(size: 12))
                    .foregroundColor(.black.opacity(0.5))
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                Text(subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.7))
            }
            Spacer()
        }
    }
}

struct LogOptionsPopup: View {
    @Binding var isPresented: Bool
    var onLogPeptide: (() -> Void)?
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 10) {
                VStack(spacing: 12) {
                    primaryAction(icon: "syringe.fill", text: "Log Peptide", tint: Color(hex: "8A6BF2"), action: {
                        onLogPeptide?()
                    })
                    primaryAction(icon: "camera.fill", text: "Log Photos", tint: Color(hex: "F5A623"))
                    primaryAction(icon: "scalemass", text: "Log Weight", tint: Color(hex: "C183FF"))
                    primaryAction(icon: "figure.run", text: "Log Activity", tint: Color(hex: "FF2D55"))
                    primaryAction(icon: "face.smiling", text: "Log Side Effect", tint: Color(hex: "6BD17B"))
                }
                .padding(16)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                
                VStack(spacing: 10) {
                    HStack(spacing: 10) {
                        secondaryCard(icon: "barcode.viewfinder", text: "Scan Food")
                        secondaryCard(icon: "fork.knife", text: "Search Food")
                    }
                    
                    HStack(spacing: 10) {
                        secondaryCard(icon: "plus.forwardslash.minus", text: "Calculator")
                        secondaryCard(icon: "document.viewfinder.fill", text: "Scan COA")
                    }
                }
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 20)
        }
    }
    
    private func primaryAction(icon: String, text: String, tint: Color, action: (() -> Void)? = nil) -> some View {
        Button {
            if let action = action {
                action()
            } else {
                isPresented = false
            }
        } label: {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(tint)
                    .frame(width: 34, height: 34)
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                Text(text)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 10)
            .padding(.horizontal, 6)
            .background(Color.white.opacity(0.05))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func secondaryAction(icon: String, text: String) -> some View {
        Button {
            isPresented = false
        } label: {
            VStack(spacing: 6) {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 48, height: 48)
                    .background(Color.white.opacity(0.08))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                Text(text)
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func secondaryCard(icon: String, text: String) -> some View {
        secondaryAction(icon: icon, text: text)
            .padding(12)
            .frame(maxWidth: .infinity)
            .background(Color.black)
            .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    }
}

struct BottomNavBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 0.8)
            
            HStack(spacing: 0) {
                NavBarItem(icon: "house.fill", isActive: selectedTab == .home) {
                    selectedTab = .home
                }
                NavBarItem(icon: "syringe.fill", isActive: selectedTab == .peptides) {
                    selectedTab = .peptides
                }
                NavBarItem(icon: "chart.line.uptrend.xyaxis", isActive: selectedTab == .progress) {
                    selectedTab = .progress
                }
                NavBarItem(icon: "book.pages.fill", isActive: selectedTab == .library) {
                    selectedTab = .library
                }
                NavBarItem(icon: "person.fill", isActive: selectedTab == .account) {
                    selectedTab = .account
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 6)
        }
        .background(Color.white)
    }
}

struct NavBarItem: View {
    let icon: String
    let isActive: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: icon)
                .font(.system(size: 24))
                .foregroundColor(isActive ? .black : .black.opacity(0.4))
                .frame(maxWidth: .infinity)
        }
    }
}

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3:
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8:
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

#Preview {
    HomeView()
}
