//
//  HomeView.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Row - Logo, Date, Streak
                HStack {
                    Text("ASCEND")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    HStack(spacing: 6) {
                        Image(systemName: "calendar")
                            .font(.system(size: 14))
                        Text(dateString)
                            .font(.system(size: 14, weight: .medium))
                    }
                    .foregroundColor(.black)
                    
                    Spacer()
                        .frame(width: 20)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)
                        Text("7")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        // Date Circles Row
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(0..<14) { index in
                                    DateCircle(
                                        day: "\(index + 1)",
                                        isSelected: index == 7
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .padding(.bottom, 10)
                        
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
            
            // Bottom Navigation Bar
            VStack {
                Spacer()
                BottomNavBar()
            }
        }
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d"
        return formatter.string(from: selectedDate)
    }
}

struct DateCircle: View {
    let day: String
    let isSelected: Bool
    
    var body: some View {
        VStack(spacing: 4) {
            Text(day)
                .font(.system(size: 16, weight: isSelected ? .bold : .medium))
                .foregroundColor(isSelected ? .white : .black)
                .frame(width: 50, height: 50)
                .background(isSelected ? Color.black : Color.black.opacity(0.1))
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(isSelected ? Color.clear : Color.black.opacity(0.2), lineWidth: 1)
                )
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
    var body: some View {
        HStack(spacing: 0) {
            NavBarItem(icon: "house.fill", isActive: true)
            NavBarItem(icon: "chart.line.uptrend.xyaxis", isActive: false)
            NavBarItem(icon: "plus.circle", isActive: false)
            NavBarItem(icon: "calendar", isActive: false)
            NavBarItem(icon: "person.fill", isActive: false)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            Color.black.opacity(0.05)
                .background(.ultraThinMaterial)
        )
    }
}

struct NavBarItem: View {
    let icon: String
    let isActive: Bool
    
    var body: some View {
        Button(action: {}) {
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

#Preview {
    HomeView()
}
