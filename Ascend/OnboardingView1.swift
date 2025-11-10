//
//  OnboardingView1.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

struct OnboardingView1: View {
    let onGetStarted: () -> Void
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
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
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .font(.system(size: 60))
                                .foregroundColor(.black.opacity(0.6))
                        }
                    )
                    .padding(.bottom, 60)
                
                // Header
                Text("Stay on top of your peptide journey")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 16)
                
                // Subtitle
                Text("See your current dose, progress metrics, and daily goals all in one place.")
                    .font(.system(size: 16))
                    .foregroundColor(.black.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                
                // Progress Dots
                HStack(spacing: 8) {
                    Circle()
                        .fill(Color.black)
                        .frame(width: 8, height: 8)
                    Circle()
                        .fill(Color.black.opacity(0.3))
                        .frame(width: 8, height: 8)
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