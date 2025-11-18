//
//  JourneyView.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

struct JourneyView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTimeRange = "1 days"
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.92, green: 0.88, blue: 0.95),
                    Color(red: 0.88, green: 0.82, blue: 0.92)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 20, weight: .semibold))
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Text("MY GLP-1 JOURNEY")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text(selectedTimeRange)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 8)
                            .background(Color(hex: "7C5DBB"))
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal, 16)
                .padding(.top, 50)
                .padding(.bottom, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 16) {
                        JourneyMainCard()
                        
                        Spacer().frame(height: 60)
                    }
                    .padding(.horizontal, 16)
                }
            }
        }
    }
}

struct JourneyMainCard: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 12) {
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 180, height: 240)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 80))
                                .foregroundColor(.gray.opacity(0.5))
                        )
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 24))
                                .foregroundColor(.gray.opacity(0.6))
                        )
                        .padding(8)
                }
                
                VStack(spacing: 8) {
                    InfoStatCard(label: "DATE", value: "11/3/25", valueColor: .black)
                    InfoStatCard(label: "BMI", value: "22", valueColor: .black)
                    InfoStatCard(label: "WEIGHT", value: "149lbs", valueColor: Color(hex: "7C5DBB"))
                    InfoStatCard(label: "WEIGHT DIFF", value: "--", valueColor: .black)
                }
                .frame(maxWidth: .infinity)
            }
            .padding(16)
            
            VStack(spacing: 12) {
                SideEffectRow(title: "Other", value: 3, max: 10, showLevel: false)
                SideEffectRow(title: "Injection Anxiety", value: 2, max: 10, showLevel: true)
                SideEffectRow(title: "Fatigue", value: 1, max: 10, showLevel: false)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    Text("149")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                        .frame(width: 30, alignment: .trailing)
                    
                    GeometryReader { geometry in
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 1)
                            
                            Path { path in
                                let width = geometry.size.width
                                let startX: CGFloat = 0
                                let endX: CGFloat = width * 0.6
                                let startY: CGFloat = 20
                                let endY: CGFloat = 80
                                
                                path.move(to: CGPoint(x: startX, y: startY))
                                path.addLine(to: CGPoint(x: endX, y: endY))
                            }
                            .stroke(Color(hex: "7C5DBB"), lineWidth: 2.5)
                        }
                        .frame(height: 100)
                    }
                    .frame(height: 100)
                }
                
                HStack(alignment: .top) {
                    Text("147")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                        .frame(width: 30, alignment: .trailing)
                    
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 1)
                    }
                    .frame(height: 1)
                }
                
                HStack(alignment: .top) {
                    Text("144")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                        .frame(width: 30, alignment: .trailing)
                    
                    GeometryReader { geometry in
                        Rectangle()
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 1)
                    }
                    .frame(height: 1)
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
            
            HStack(spacing: 8) {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color(hex: "7C5DBB"))
                Text("MeAgain")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                HStack(spacing: 4) {
                    ForEach(0..<3) { _ in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 40, height: 50)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray.opacity(0.5))
                            )
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            
            VStack(spacing: 4) {
                HStack(spacing: 2) {
                    ForEach(0..<5) { index in
                        Rectangle()
                            .fill(index == 2 ? Color.black : Color.gray.opacity(0.3))
                            .frame(width: index == 2 ? 3 : 1.5, height: index == 2 ? 24 : 16)
                    }
                }
                
                Text("Nov 2")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
            .padding(.bottom, 20)
        }
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
    }
}

struct InfoStatCard: View {
    let label: String
    let value: String
    let valueColor: Color
    
    var body: some View {
        VStack(spacing: 6) {
            Text(label)
                .font(.system(size: 11, weight: .semibold))
                .foregroundColor(.black)
            
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(valueColor)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1)
        )
    }
}

struct SideEffectRow: View {
    let title: String
    let value: Int
    let max: Int
    let showLevel: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(title)
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                
                Spacer()
                
                if showLevel {
                    HStack(spacing: 2) {
                        Text("LEVEL")
                            .font(.system(size: 10, weight: .semibold))
                            .foregroundColor(.black)
                        Text("-/5")
                            .font(.system(size: 10))
                            .foregroundColor(.gray)
                    }
                } else {
                    Text("\(value)/\(max)")
                        .font(.system(size: 12))
                        .foregroundColor(.black)
                }
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 8)
                    
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color.black)
                        .frame(width: geometry.size.width * CGFloat(value) / CGFloat(max), height: 8)
                }
            }
            .frame(height: 8)
            
            if showLevel {
                HStack(spacing: 4) {
                    ForEach(0..<5) { _ in
                        Image(systemName: "star.fill")
                            .font(.system(size: 14))
                            .foregroundColor(.gray.opacity(0.3))
                    }
                }
            }
        }
    }
}

#Preview {
    JourneyView()
}

