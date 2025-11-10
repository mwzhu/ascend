import SwiftUI

struct OnboardingStepOneView: View {
    private let backgroundGradient = LinearGradient(
        colors: [
            Color(red: 0.10, green: 0.09, blue: 0.22),
            Color(red: 0.27, green: 0.20, blue: 0.55)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            VStack(spacing: 36) {
                Spacer(minLength: 16)

                PhonePreview()

                VStack(alignment: .leading, spacing: 14) {
                    Text("Stay on top of your peptide journey")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundStyle(.white)
                        .multilineTextAlignment(.leading)

                    Text("See your current dose, progres metrics, and daily goals all in one place.")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white.opacity(0.75))
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)

                ProgressDotsView(activeIndex: 0, total: 3)

                Button(action: {}) {
                    Text("Get Started")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.69, green: 0.52, blue: 0.98),
                                    Color(red: 0.42, green: 0.29, blue: 0.84)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(18)
                        .shadow(color: .black.opacity(0.25), radius: 18, x: 0, y: 16)
                }
                .buttonStyle(.plain)

                Spacer(minLength: 32)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 48)
        }
    }
}

struct OnboardingStepTwoView: View {
    @State private var selectedLevel: Int? = nil

    private let backgroundGradient = LinearGradient(
        colors: [
            Color.white,
            Color(red: 0.95, green: 0.95, blue: 1.0)
        ],
        startPoint: .top,
        endPoint: .bottom
    )

    private let selectionGradient = LinearGradient(
        colors: [
            Color(red: 0.54, green: 0.40, blue: 0.92),
            Color(red: 0.31, green: 0.20, blue: 0.70)
        ],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )

    private let options = [
        "I'm new to this",
        "I've got some experience",
        "I'm a peptide expert"
    ]

    var body: some View {
        ZStack {
            backgroundGradient
                .ignoresSafeArea()

            VStack(alignment: .leading, spacing: 32) {
                ProgressView(value: 0.66)
                    .progressViewStyle(.linear)
                    .tint(Color(red: 0.36, green: 0.25, blue: 0.82))

                VStack(alignment: .leading, spacing: 12) {
                    Text("Ready to ascend?")
                        .font(.system(size: 32, weight: .bold, design: .rounded))
                        .foregroundColor(Color(red: 0.13, green: 0.11, blue: 0.27))

                    Text("Where are you with your peptide journey?")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(Color(red: 0.31, green: 0.30, blue: 0.45))
                }

                VStack(spacing: 16) {
                    ForEach(Array(options.enumerated()), id: \.offset) { index, option in
                        Button {
                            selectedLevel = index
                        } label: {
                            HStack {
                                Text(option)
                                    .font(.system(size: 18, weight: .semibold))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 16, weight: .semibold))
                            }
                            .foregroundColor(selectedLevel == index ? .white : Color(red: 0.18, green: 0.17, blue: 0.33))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(Color.white)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .fill(selectionGradient)
                                    .opacity(selectedLevel == index ? 1 : 0)
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 20, style: .continuous)
                                    .stroke(Color(red: 0.83, green: 0.82, blue: 0.93), lineWidth: 1.2)
                                    .opacity(selectedLevel == index ? 0 : 1)
                            )
                            .shadow(color: selectedLevel == index ? Color(red: 0.31, green: 0.20, blue: 0.70).opacity(0.25) : .clear, radius: 12, x: 0, y: 14)
                        }
                        .buttonStyle(.plain)
                    }
                }

                Spacer()

                Button(action: {}) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.36, green: 0.25, blue: 0.82),
                                    Color(red: 0.21, green: 0.18, blue: 0.54)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(18)
                        .shadow(color: Color(red: 0.27, green: 0.19, blue: 0.64).opacity(0.25), radius: 16, x: 0, y: 12)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 32)
            .padding(.vertical, 48)
        }
    }
}

private struct PhonePreview: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .fill(Color.white.opacity(0.08))

            VStack(alignment: .leading, spacing: 16) {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.2))
                    .frame(height: 24)
                    .overlay(
                        HStack {
                            Circle()
                                .fill(Color.white.opacity(0.7))
                                .frame(width: 12, height: 12)
                            Spacer()
                            RoundedRectangle(cornerRadius: 6)
                                .fill(Color.white.opacity(0.4))
                                .frame(width: 80, height: 12)
                        }
                        .padding(.horizontal, 16)
                    )

                VStack(alignment: .leading, spacing: 12) {
                    RoundedRectangle(cornerRadius: 18)
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.69, green: 0.52, blue: 0.98),
                                    Color(red: 0.48, green: 0.37, blue: 0.86)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .frame(height: 120)

                    VStack(spacing: 8) {
                        ForEach(0..<3) { _ in
                            RoundedRectangle(cornerRadius: 14)
                                .fill(Color.white.opacity(0.2))
                                .frame(height: 52)
                        }
                    }

                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.white.opacity(0.4), lineWidth: 1)
                        .frame(height: 96)
                }
                .padding(.horizontal, 18)

                Spacer()
            }
            .padding(.top, 32)
            .padding(.bottom, 28)
        }
        .frame(width: 240, height: 480)
        .overlay(
            RoundedRectangle(cornerRadius: 36, style: .continuous)
                .stroke(Color.white.opacity(0.2), lineWidth: 1.2)
        )
        .shadow(color: .black.opacity(0.35), radius: 30, x: 0, y: 24)
    }
}

private struct ProgressDotsView: View {
    let activeIndex: Int
    let total: Int

    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<total, id: \.self) { index in
                Circle()
                    .fill(index == activeIndex ? Color.white : Color.white.opacity(0.35))
                    .frame(width: index == activeIndex ? 12 : 10, height: index == activeIndex ? 12 : 10)
                    .opacity(index == activeIndex ? 1.0 : 0.8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


