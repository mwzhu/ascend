//
//  JourneyView.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

struct JourneyView: View {
    @Binding var isPresented: Bool
    @State private var selectedTimeRange = "1 days"
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [
                    Color(hex: "FFB877"),
                    Color(hex: "FFD9AA"),
                    Color(hex: "FFE5CC"),
                    Color(hex: "FFF5EB")
                ]),
                center: .center,
                startRadius: 100,
                endRadius: 500
            )
            .ignoresSafeArea()
            
            VStack(spacing: 16) {
                JourneyMainCard(dismiss: { isPresented = false }, selectedTimeRange: selectedTimeRange)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
        .navigationBarHidden(true)
    }
}

struct JourneyMainCard: View {
    let dismiss: () -> Void
    let selectedTimeRange: String
    
    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 0) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 21, weight: .regular))
                            .foregroundColor(.gray.opacity(0.5))
                    }
                    
                    Spacer()
                    
                    Text("MY ASCEND JOURNEY")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {}) {
                        Text(selectedTimeRange)
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 5)
                            .background(
                                UnevenRoundedRectangle(cornerRadii: .init(
                                    topLeading: 8,
                                    bottomLeading: 8,
                                    bottomTrailing: 0,
                                    topTrailing: 0
                                ))
                                .fill(Color(hex: "FF7300"))
                            )
                    }
                }
                .padding(.leading, 16)
                .padding(.top, 16)
                
                HStack(alignment: .top, spacing: 10) {
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.3))
                        .frame(width: 240, height: 250)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 90))
                                .foregroundColor(.gray.opacity(0.5))
                        )
                    
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.4))
                        .frame(width: 45, height: 45)
                        .overlay(
                            Image(systemName: "person.fill")
                                .font(.system(size: 26))
                                .foregroundColor(.gray.opacity(0.6))
                        )
                        .padding(8)
                }
                
                VStack(spacing: 8) {
                    InfoStatCard(label: "DATE", value: "11/3/25", valueColor: .black)
                    InfoStatCard(label: "BMI", value: "22", valueColor: .black)
                    InfoStatCard(label: "WEIGHT", value: "149lbs", valueColor: Color(hex: "FF7300"))
                    InfoStatCard(label: "WEIGHT DIFF", value: "--", valueColor: .black)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 14)
            
            HStack(alignment: .top, spacing: 0) {
                HStack(spacing: 14) {
                    VStack(spacing: 8) {
                        FaceRow(title: "Face Overall", value: 69)
                        FaceRow(title: "Face Definition", value: 88)
                        FaceRow(title: "Face Puffiness", value: 34)
                    }
                    VStack(spacing: 8) {
                        FaceRow(title: "Skin Clarity", value: 66)
                        FaceRow(title: "Skin Tone", value: 50)
                        FaceRow(title: "Skin Radiance", value: 20)
                    }
                }
                .frame(width: 240)
                .padding(.leading, 10)
                
                Spacer()
                
                LevelStarsComponent()
                    .padding(.top, 28)
                    .padding(.trailing, 4)
            }
            .padding(.bottom, 10)
            
            WeightProgressChart()
                .padding(.horizontal, 16)
                .padding(.bottom, 10)
            
            HStack(spacing: 8) {
                Image(systemName: "bolt.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color(hex: "FF7300")
)
                Text("Ascend")
                    .font(.system(size: 17, weight: .bold))
                    .foregroundColor(.black)
                
                Spacer()
                
                HStack(spacing: 6) {
                    ForEach(0..<6) { _ in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.07))
                            .frame(width: 28, height: 38)
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray.opacity(0.1))
                            )
                    }
                }
                .padding(.trailing, 0)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
            }
            .background(Color.white)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.gray.opacity(0.15), lineWidth: 2.5)
            )
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 4)
            
            VStack(spacing: 4) {
                HStack(spacing: 11) {
                    ForEach(0..<6) { index in
                        Rectangle()
                            .fill(index == 2 ? Color.black : Color.gray.opacity(0.6))
                            .frame(width: index == 2 ? 2 : 1.25, height: index == 2 ? 50 : 22)
                    }
                }
                .padding(.bottom, 4)
                
                Text("Nov 2")
                    .font(.system(size: 17))
                    .foregroundColor(.gray)
            }
            .padding(.top, 40)
        }
    }
}

struct InfoStatCard: View {
    let label: String
    let value: String
    let valueColor: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 11, weight: .medium))
                .foregroundColor(.black)
            
            Text(value)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(valueColor)
        }
        .frame(width: 110)
        .padding(.vertical, 10)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.25), lineWidth: 1.5)
        )
    }
}

struct FaceRow: View {
    let title: String
    let value: Int

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(title)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(.black.opacity(0.7))

                    Spacer()

                    Text("\(value)")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.6))
                }

                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 7)

                        RoundedRectangle(cornerRadius: 4)
                            .fill(Color.black.opacity(0.6))
                            .frame(width: geometry.size.width * CGFloat(value) / CGFloat(100), height: 7)
                    }
                }
                .frame(height: 8)
            }
            .frame(width: 110) // Added fixed width
        }
    }
}

struct LevelStarsComponent: View {
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            HStack(spacing: 2) {
                Text("LEVEL")
                    .font(.system(size: 11, weight: .regular))
                    .foregroundColor(.black.opacity(0.75))
                Text("-/5")
                    .font(.system(size: 11))
                    .foregroundColor(.black.opacity(0.75))
            }
            
            HStack(spacing: 0) {
                ForEach(0..<5) { _ in
                    Image(systemName: "star.fill")
                        .font(.system(size: 16))
                        .foregroundColor(.gray.opacity(0.25))
                }
            }
        }
        .padding(.trailing, 8)
    }
}

struct WeightProgressChart: View {
    let minValue: Int = 144
    let maxValue: Int = 149
    let currentValue: CGFloat = 145.0
    let progressFill: CGFloat = 0.33
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                )
                .padding(.bottom, 12)
                .padding(.top, 13)
            
            HStack(alignment: .bottom, spacing: 0) {
                VStack(alignment: .leading, spacing: 3) {
                    ForEach(Array(stride(from: maxValue, through: minValue, by: -2)), id: \.self) { value in
                        Text("\(value)")
                            .font(.system(size: 11))
                            .foregroundColor(.gray.opacity(0.9))
                            .frame(height: 37, alignment: .center)
                    }
                }
                .frame(width: 30)
                .padding(.leading, 6)
                .padding(.vertical, 12)
                
                ZStack(alignment: .topLeading) {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(width: 1)
                    
                    GeometryReader { geometry in
                        let labelHeight: CGFloat = 20
                        let valueRange = CGFloat(maxValue - minValue)
                        
                        ZStack {
                            ForEach((minValue...maxValue - 1).reversed(), id: \.self) { value in
                                let index = maxValue - value
                                let yPosition = CGFloat(index) * labelHeight
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 1)
                                    .frame(width: geometry.size.width)
                                    .offset(y: yPosition)
                            }
                            
                            let barYPosition = (CGFloat(maxValue) - currentValue) * labelHeight
                            
                            HStack(spacing: 0) {
                                Rectangle()
                                    .fill(Color(hex: "FF7300"))
                                    .frame(width: geometry.size.width * progressFill)
                                
                                Rectangle()
                                    .fill(Color.gray.opacity(0.1))
                                    .frame(width: geometry.size.width * (1 - progressFill))
                            }
                            .frame(height: 3)
                            .offset(y: barYPosition)
                        }
                    }
                }
                .padding(.trailing, 12)
                .padding(.vertical, 12)
            }
        }
        .frame(height: 130)
    }
}

#Preview {
    JourneyView(isPresented: .constant(true))
}

