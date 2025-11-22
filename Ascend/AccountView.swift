//
//  AccountView.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

struct AccountView: View {
    @Binding var showJourney: Bool
    @Binding var journeySource: JourneySource
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Account")
                    .font(.system(size: 26, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 18)
                
                // VStack(spacing: 12) {
                //     HStack(spacing: 12) {
                //         InfoCard(icon: "scalemass.fill", title: "Weight", value: "148.9lbs")
                //         InfoCard(icon: "ruler.fill", title: "Height", value: "5'9\"")
                //     }
                    
                //     HStack(spacing: 12) {
                //         InfoCard(icon: "calendar", title: "Birthday", value: "11/15/2002")
                //         InfoCard(icon: "figure.stand", title: "Gender", value: "Male")
                //     }
                // }
                // .padding(.horizontal, 20)
                // .padding(.bottom, 24)
                
                // NavigationRow(icon: "person.fill", title: "Personal Details", iconColor: .gray)
                //     .padding(.bottom, 24)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("My Ascend Journey")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.gray.opacity(0.6))
                        .padding(.horizontal, 20)
                    
                    Button(action: {
                        journeySource = .account
                        showJourney = true
                    }) {
                        JourneyCard()
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.bottom, 24)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("SETTINGS")
                        .font(.system(size: 11, weight: .light))
                        .foregroundColor(.gray.opacity(0.8))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                    
                    NavigationRow(icon: "cross.case.fill", title: "Profile")
                    NavigationRow(icon: "cross.case.fill", title: "Treatment")
                    NavigationRow(icon: "bolt.fill", title: "Daily Lifestyle Goals")
                    NavigationRow(icon: "target", title: "Weight Goals")
                    NavigationRow(icon: "slider.horizontal.3", title: "Units")
                    NavigationRow(icon: "calendar", title: "Schedule")

                }
                .padding(.bottom, 24)

                                
                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Widgets")
                            .font(.system(size: 13, weight: .medium))
                            .foregroundColor(.gray.opacity(0.6))
                        
                        Spacer()
                        
                        Button(action: {}) {
                            Text("How to add?")
                                .font(.system(size: 13, weight: .medium))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    HealthWidgetCard()
                }
                .padding(.bottom, 24)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("ACCOUNT")
                        .font(.system(size: 11, weight: .light))
                        .foregroundColor(.gray.opacity(0.8))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                    
                    NavigationRow(icon: "person.fill", title: "Secure Your Account", badge: "Secure Now", badgeColor: .orange)
                }
                .padding(.bottom, 24)

                VStack(alignment: .leading, spacing: 0) {
                    Text("OTHER")
                        .font(.system(size: 11, weight: .light))
                        .foregroundColor(.gray.opacity(0.8))
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                    
                    NavigationRow(icon: "hand.thumbsup.fill", title: "Terms and Conditions")
                    NavigationRow(icon: "arrow.up.arrow.down.circle.fill", title: "Privacy Policy")
                    NavigationRow(icon: "arrow.up.arrow.down.circle.fill", title: "Support Email")
                    NavigationRow(icon: "hand.thumbsup.fill", title: "Delete Account")
                }
                
                Spacer().frame(height: 100)
            }
        }
        .background(Color.white)
    }
}

struct InfoCard: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                Text(title)
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(.black)
            }
            
            Text(value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(Color.white)
        .cornerRadius(12)
    }
}

struct NavigationRow: View {
    let icon: String
    let title: String
    var badge: String? = nil
    var badgeColor: Color = .purple
    var iconColor: Color = Color.gray.opacity(0.5)
    
    var body: some View {
        VStack(spacing: 0) {
            Button(action: {}) {
                HStack(spacing: 10) {
                    Image(systemName: icon)
                        .font(.system(size: 20))
                        .foregroundColor(iconColor)
                        .frame(width: 28)
                    
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.black.opacity(0.9))
                    
                    if let badge = badge {
                        Text(badge)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(badgeColor)
                            .cornerRadius(8)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 18, weight: .regular))
                        .foregroundColor(.gray.opacity(0.5))
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(Color.white)
            }
            
            Rectangle()
                .fill(Color.gray.opacity(0.2))
                .frame(height: 0.5)
                .padding(.leading, 56)
        }
    }
}

struct HealthWidgetCard: View {
    var body: some View {
        ZStack(alignment: .topTrailing) {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.4, green: 0.5, blue: 0.45),
                    Color(red: 0.3, green: 0.6, blue: 0.55)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            
            ZStack {
                Circle()
                    .fill(Color(red: 0.2, green: 0.7, blue: 0.7).opacity(0.3))
                    .frame(width: 120, height: 120)
                
                Image(systemName: "person.fill")
                    .font(.system(size: 50))
                    .foregroundColor(.brown.opacity(0.6))
            }
            .offset(x: -50, y: 30)
            
            VStack(alignment: .leading, spacing: 8) {
                Image(systemName: "pawprint.fill")
                    .font(.system(size: 28))
                    .foregroundColor(.brown)
                    .padding(.bottom, 4)
                
                WidgetMetric(title: "PROTEIN", value: 0.8, color: .brown)
                WidgetMetric(title: "WATER", value: 0.75, color: .blue)
                WidgetMetric(title: "FIBER", value: 0.6, color: .orange)
                WidgetMetric(title: "ACTIVITY", value: 0.9, color: .green)
            }
            .padding(16)
            .background(Color(red: 0.85, green: 0.78, blue: 0.63))
            .cornerRadius(12)
            .padding(12)
        }
        .frame(height: 160)
        .cornerRadius(16)
        .padding(.horizontal, 20)
    }
}

struct WidgetMetric: View {
    let title: String
    let value: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 10, weight: .bold))
                .foregroundColor(.black)
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color.white.opacity(0.3))
                        .frame(height: 6)
                        .cornerRadius(3)
                    
                    Rectangle()
                        .fill(color)
                        .frame(width: geometry.size.width * value, height: 6)
                        .cornerRadius(3)
                }
            }
            .frame(height: 6)
        }
    }
}

struct JourneyCard: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("MY ASCEND JOURNEY")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text("29 days")
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color(hex: "FF7300"))
                        .clipShape(RoundedCornersShape(corners: [.topLeft, .bottomLeft], radius: 7))
                }
                .padding(.leading, 12)
                .padding(.top, 16)
                .padding(.bottom, 20)
                
                HStack(alignment: .bottom, spacing: 8) {
                    ZStack {
                        RoundedCornersShape(corners: [.topLeft, .topRight], radius: 16)
                            .fill(Color.gray.opacity(0.2))
                        
                        Image(systemName: "person.fill")
                            .font(.system(size: 60))
                            .foregroundColor(.gray.opacity(0.4))
                    }
                    .padding(.top, -12)
                    
                    VStack(spacing: 10) {
                        JourneyStatCard(label: "DATE", value: "11/7/2025", valueColor: .black)
                        JourneyStatCard(label: "BMI", value: "22", valueColor: .black)
                        JourneyStatCard(label: "WEIGHT", value: "148.9lbs", valueColor: Color(hex: "FF7300"))
                    }
                    .frame(width: 120)
                    .padding(.trailing, 8)
                    .padding(.bottom, 12)
                }
                .padding(.leading, 8)
            }
            .background(Color(red: 0.95, green: 0.95, blue: 0.97).opacity(0.8))
            
            VStack {
                Spacer()
                
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.clear,
                        Color(red: 0.95, green: 0.95, blue: 0.97).opacity(0.5),
                        Color(red: 0.95, green: 0.95, blue: 0.97).opacity(0.8)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 100)
            }
        }
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.2), radius: 8, x: 0, y: 6)
        .padding(.horizontal, 12)
    }
}

struct JourneyStatCard: View {
    let label: String
    let value: String
    let valueColor: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(label)
                .font(.system(size: 11, weight: .regular))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
            
            Text(value)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(valueColor)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.2), lineWidth: 1.5)
        )
    }
}

struct RoundedCornersShape: Shape {
    var corners: UIRectCorner
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    AccountView(showJourney: .constant(false), journeySource: .constant(.account))
}
