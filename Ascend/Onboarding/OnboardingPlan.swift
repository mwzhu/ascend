import SwiftUI

struct OnboardingPlan: View {
    let onNext: () -> Void
    let onBack: () -> Void
    let progress: Double
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                headerSection
                
                ScrollView {
                    VStack(spacing: 20) {
                        checkmarkIcon
                        headerText
                        timelineCard
                        shotAndWaterRow
                        proteinAndFiberRow
                    }
                }
                
                nextButton
            }
        }
    }
    
    private var headerSection: some View {
        HStack(spacing: 20) {
            Button(action: onBack) {
                Image(systemName: "chevron.left")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.black)
            }
            
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 4)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.black)
                        .frame(width: geometry.size.width * progress, height: 4)
                }
            }
            .frame(height: 4)
        }
        .padding(.horizontal, 24)
        .padding(.top, 20)
        .padding(.bottom, 20)
    }
    
    private var checkmarkIcon: some View {
        ZStack {
            Circle()
                .fill(Color.black)
                .frame(width: 44, height: 44)
            
            Image(systemName: "checkmark")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(.top, 10)
    }
    
    private var headerText: some View {
        VStack(spacing: 0) {
            Text("Congratulations your personal")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.black)
            HStack(spacing: 4) {
                Text("MeAgain")
                    .font(.system(size: 24, weight: .bold))
                    .italic()
                    .foregroundColor(.black)
                Text("plan is ready!")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
            }
        }
        .multilineTextAlignment(.center)
        .padding(.horizontal, 32)
    }
    
    private var timelineCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 6) {
                Image(systemName: "calendar")
                    .font(.system(size: 16))
                    .foregroundColor(Color(hex: "C89FD9"))
                Text("Timeline - Dream Goal")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.black)
            }
            
            VStack(spacing: 10) {
                HStack {
                    Text("26kg")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                    Spacer()
                    Text("57kg")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.black)
                    Spacer()
                    Text("50kg")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.gray)
                }
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 20)
                    
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(hex: "C89FD9"))
                        .frame(width: 180, height: 20)
                }
                
                HStack {
                    Text("Today, 1:53 PM")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Today, 1:53 PM")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                    Spacer()
                    Text("Sep 17, 2025")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(16)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(16)
        .padding(.horizontal, 24)
    }
    
    private var shotAndWaterRow: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(alignment: .leading, spacing: 12) {
                HStack(spacing: 6) {
                    Image(systemName: "syringe")
                        .font(.system(size: 16))
                        .foregroundColor(Color(hex: "8B9FD9"))
                    Text("Shot Schedule")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Friday")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    Text("Daily")
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(14)
            
            VStack(spacing: 8) {
                Image(systemName: "drop.fill")
                    .font(.system(size: 16))
                    .foregroundColor(Color(hex: "6BB6FF"))
                
                Text("Water")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.15))
                        .frame(width: 70, height: 100)
                    
                    VStack {
                        Spacer()
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(hex: "6BB6FF").opacity(0.6))
                            .frame(width: 70, height: 70)
                    }
                    .frame(width: 70, height: 100)
                    
                    Text("68oz")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            .padding(14)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(14)
        }
        .padding(.horizontal, 24)
    }
    
    private var proteinAndFiberRow: some View {
        HStack(alignment: .top, spacing: 12) {
            VStack(spacing: 8) {
                Image(systemName: "circle")
                    .font(.system(size: 16))
                    .foregroundColor(Color(hex: "FFB347"))
                
                Text("Protein")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                
                ZStack {
                    Circle()
                        .stroke(Color(hex: "FFB347").opacity(0.3), lineWidth: 8)
                        .frame(width: 70, height: 70)
                    
                    Circle()
                        .trim(from: 0, to: 1.0)
                        .stroke(Color(hex: "FFB347"), lineWidth: 8)
                        .frame(width: 70, height: 70)
                        .rotationEffect(.degrees(-90))
                    
                    Text("68g")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                }
            }
            .padding(14)
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(14)
            
            VStack(alignment: .leading, spacing: 8) {
                HStack(spacing: 6) {
                    Image(systemName: "leaf.fill")
                        .font(.system(size: 16))
                        .foregroundColor(Color(hex: "90C956"))
                    Text("Fiber")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("25g")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.black)
                
                ZStack(alignment: .leading) {
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 14)
                    
                    RoundedRectangle(cornerRadius: 6)
                        .fill(Color(hex: "90C956"))
                        .frame(maxWidth: .infinity)
                        .frame(height: 14)
                }
            }
            .padding(14)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.gray.opacity(0.05))
            .cornerRadius(14)
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 20)
    }
    
    private var nextButton: some View {
        Button(action: onNext) {
            Text("Let's get started")
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(Color(hex: "7B68EE"))
                .cornerRadius(26)
        }
        .padding(.horizontal, 28)
        .padding(.bottom, 16)
    }
}

#Preview {
    OnboardingPlan(onNext: {}, onBack: {}, progress: 1.0)
}

