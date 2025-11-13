//
//  OnboardingView1.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

struct OnboardingView1: View {
    let onGetStarted: () -> Void
    @State private var currentPage = 0
    
    let pages: [(icon: String, title: String, subtitle: String)] = [
        (
            icon: "chart.line.uptrend.xyaxis",
            title: "Stay on top of your peptide journey",
            subtitle: "See your current dose, progress metrics, and daily goals all in one place."
        ),
        (
            icon: "calendar.badge.clock",
            title: "Track your schedule",
            subtitle: "Never miss a dose with smart reminders and daily logs tailored to your routine."
        ),
        (
            icon: "heart.text.square.fill",
            title: "Monitor your progress",
            subtitle: "Log symptoms, track side effects, and see how your body responds over time."
        ),
        (
            icon: "target",
            title: "Achieve your goals",
            subtitle: "Set personal health targets and watch your progress unfold day by day."
        )
    ]
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        VStack(spacing: 0) {
                            // iPhone Preview
                            RoundedRectangle(cornerRadius: 40)
                                .fill(Color.black.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.black.opacity(0.3), lineWidth: 1)
                                )
                                .frame(width: 220, height: 450)
                                .overlay(
                                    VStack {
                                        Image(systemName: pages[index].icon)
                                            .font(.system(size: 60))
                                            .foregroundColor(.black.opacity(0.6))
                                    }
                                )
                                .padding(.bottom, 60)
                            
                            // Header
                            Text(pages[index].title)
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 16)
                            
                            // Subtitle
                            Text(pages[index].subtitle)
                                .font(.system(size: 16))
                                .foregroundColor(.black.opacity(0.7))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                                .padding(.bottom, 40)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(maxWidth: .infinity)
                
                // Progress Dots
                HStack(spacing: 8) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        Circle()
                            .fill(currentPage == index ? Color.black : Color.black.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, 40)
                
                Spacer()
                
                // Get Started Button
                Button(action: onGetStarted) {
                    Text("Get Started")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.black)
                        .cornerRadius(28)
                }
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }
    }
}

#Preview {
    OnboardingView1(onGetStarted: {})
}