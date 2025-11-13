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

struct HomeView: View {
    @State private var selectedDate = Date()
    @State private var showDateCircles = false
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                currentView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                BottomNavBar(selectedTab: $selectedTab)
            }
        }
    }
    
    @ViewBuilder
    private var currentView: some View {
        switch selectedTab {
        case .home:
            HomeContentView(selectedDate: $selectedDate, showDateCircles: $showDateCircles)
        case .peptides:
            PeptidesView()
        case .progress:
            ProgressView()
        case .library:
            LibraryView()
        case .account:
            AccountView()
        }
    }
}

struct HomeContentView: View {
    @Binding var selectedDate: Date
    @Binding var showDateCircles: Bool
    
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
                        
                        // Medication Level
                        MedicationLevelCard()
                        
                        // Health Metrics Grid
                        HStack(spacing: 12) {
                            MetricCard(icon: "carrot.fill", title: "Fiber", value: "25g", goal: "30g", color: .orange)
                            MetricCard(icon: "drop.fill", title: "Water", value: "6", goal: "8", color: .blue)
                        }
                        
                        HStack(spacing: 12) {
                            MetricCard(icon: "fork.knife", title: "Protein", value: "80g", goal: "100g", color: .red)
                            MetricCard(icon: "figure.walk", title: "Activity", value: "45m", goal: "60m", color: .green)
                        }
                        
                        MetricCard(icon: "target", title: "Goal", value: "2/3", goal: "Complete", color: .purple, isWide: true)
                        
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
                        .frame(width: circleSize, height: circleSize)
                    
                    Circle()
                        .strokeBorder(
                            style: StrokeStyle(
                                lineWidth: 2,
                                dash: [4, 4]
                            )
                        )
                        .foregroundColor(borderColor)
                        .frame(width: circleSize, height: circleSize)
                    
                    if showIcon {
                        Image(systemName: "syringe.fill")
                            .font(.system(size: iconSize))
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
                    .fill(isSelected ? Color.gray.opacity(0.15) : Color.clear)
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
    
    private var iconSize: CGFloat {
        switch circleStyle {
        case .orangeWithIcon:
            return 12
        case .grayWithIcon:
            return 12
        case .blank:
            return 12
        }
    }
    
    private var circleBackground: Color {
        switch circleStyle {
        case .blank:
            return Color.gray.opacity(0.2)
        case .grayWithIcon:
            return Color.gray.opacity(0.2)
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
            return Color(hex: "FF7300")
        case .orangeWithIcon:
            return .white
        case .blank:
            return .clear
        }
    }
}

struct ToDoListCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Peptide Day")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
            }
            
            ToDoItem(title: "Morning injection", time: "8:00 AM", isChecked: true)
            ToDoItem(title: "Log symptoms", time: "2:00 PM", isChecked: false)
            ToDoItem(title: "Evening injection", time: "8:00 PM", isChecked: false)
        }
        .padding(20)
        .background(Color.black.opacity(0.05))
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}

struct ToDoItem: View {
    let title: String
    let time: String
    let isChecked: Bool
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 24))
                .foregroundColor(isChecked ? .green : .black.opacity(0.3))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.black)
                    .strikethrough(isChecked, color: .black.opacity(0.5))
            }
            
            Spacer()
            
            Text(time)
                .font(.system(size: 14))
                .foregroundColor(.black.opacity(0.5))
        }
    }
}

struct MedicationLevelCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Medication Level")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
            }
            
            HStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Current")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.5))
                    Text("2.5mg")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                ZStack {
                    Circle()
                        .stroke(Color.black.opacity(0.2), lineWidth: 8)
                        .frame(width: 80, height: 80)
                    
                    Circle()
                        .trim(from: 0, to: 0.75)
                        .stroke(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            ),
                            style: StrokeStyle(lineWidth: 8, lineCap: .round)
                        )
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(-90))
                    
                    Text("75%")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.black)
                }
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.05))
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
}

struct MetricCard: View {
    let icon: String
    let title: String
    let value: String
    let goal: String
    let color: Color
    var isWide: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(color)
                Spacer()
            }
            
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.black.opacity(0.7))
            
            HStack(alignment: .firstTextBaseline, spacing: 4) {
                Text(value)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                Text("/ \(goal)")
                    .font(.system(size: 14))
                    .foregroundColor(.black.opacity(0.5))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.black.opacity(0.05))
        .cornerRadius(16)
        .padding(.horizontal, isWide ? 20 : 0)
        .if(!isWide) { view in
            view.padding(.leading, 20)
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
        .cornerRadius(20)
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

struct BottomNavBar: View {
    @Binding var selectedTab: Tab
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 0.5)
            
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
                NavBarItem(icon: "book.fill", isActive: selectedTab == .library) {
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
