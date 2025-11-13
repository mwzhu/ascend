import SwiftUI

struct OnboardingGraph: View {
    @State private var selectedDose: String = ""
    let onNext: () -> Void
    
    let doses = [
        "Every day",
        "5-6 times a week",
        "3-4 times a week",
        "1-2 times a week",
        "Less than once a week",
        "Custom",
        "Not sure, still figuring it out",
    ]
    
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 0) {
                // Back Button and Progress Bar
                HStack(spacing: 20) {
                    Button(action: {}) {
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
                                .frame(width: geometry.size.width * 0.15, height: 4)
                        }
                    }
                    .frame(height: 4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                // Header Text
                Text("graph 1")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                // Subtitle Text
                Text("It's okay if you're not sure!")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                
                // Dose Buttons - Scrollable
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(doses, id: \.self) { dose in
                            SingleSelectButton(
                                title: dose,
                                isSelected: selectedDose == dose,
                                action: {
                                    selectedDose = dose
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 24)
                }
                
                Spacer()
                
                // Next Button
                Button(action: onNext) {
                    Text("Next")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(selectedDose.isEmpty ? Color.black.opacity(0.3) : Color.black)
                        .cornerRadius(28)
                }
                .disabled(selectedDose.isEmpty)
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
            }
        }
    }
}

#Preview {
    OnboardingGraph(onNext: {})
}
