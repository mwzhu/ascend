//
//  OnboardingView2.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

struct OnboardingView2: View {
    @State private var selectedOption: Int? = nil
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Progress Bar
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .fill(Color.white.opacity(0.2))
                            .frame(height: 4)
                        
                        Rectangle()
                            .fill(Color.white)
                            .frame(width: geometry.size.width * 0.5, height: 4)
                    }
                }
                .frame(height: 4)
                .padding(.bottom, 60)
                
                // Header
                Text("Ready to ascend?")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 16)
                
                // Subtitle
                Text("Where are you with your peptide journey?")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 60)
                
                // Option Buttons
                VStack(spacing: 16) {
                    OptionButton(
                        title: "I'm new to this",
                        isSelected: selectedOption == 0
                    ) {
                        selectedOption = 0
                    }
                    
                    OptionButton(
                        title: "I've got some experience",
                        isSelected: selectedOption == 1
                    ) {
                        selectedOption = 1
                    }
                    
                    OptionButton(
                        title: "I'm a peptide expert",
                        isSelected: selectedOption == 2
                    ) {
                        selectedOption = 2
                    }
                }
                .padding(.horizontal, 32)
                
                Spacer()
                
                // Continue Button
                Button(action: onContinue) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(selectedOption != nil ? Color.white : Color.white.opacity(0.3))
                        .cornerRadius(28)
                }
                .disabled(selectedOption == nil)
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
            }
        }
    }
}

struct OptionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(isSelected ? .black : .white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(isSelected ? Color.white : Color.white.opacity(0.1))
                .cornerRadius(28)
                .overlay(
                    RoundedRectangle(cornerRadius: 28)
                        .stroke(isSelected ? Color.clear : Color.white.opacity(0.3), lineWidth: 1)
                )
        }
    }
}

#Preview {
    OnboardingView2(onContinue: {})
}

