import SwiftUI

struct OnboardingPeptides: View {
    @State private var selectedPeptides: Set<String> = []
    let onNext: () -> Void
    
    let peptides = [
        "GHK-Cu",
        "BPC-157",
        "TB-500",
        "Tirzepatide",
        "Semaglutide",
        "Retatrutide",
        "CJC-1295",
        "Ipamorelin",
        "Sermorelin",
        "Melanotan II",
        "Semax",
        "Selank",
        "Tesamorelin",
        "AOD 9604",
        "MOTS-c",
        "IGF-1",
        "Other"
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
                                .frame(width: geometry.size.width * 0.1, height: 4)
                        }
                    }
                    .frame(height: 4)
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 20)
                
                // Header Text
                Text("Which peptides do you plan to use?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                // Subtitle Text
                Text("If you're not sure, pick your best guess — you can always change it later.")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                
                // Peptide Buttons - Scrollable
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        ForEach(peptides, id: \.self) { peptide in
                            MultiSelectButton(
                                title: peptide,
                                isSelected: selectedPeptides.contains(peptide),
                                action: {
                                    if selectedPeptides.contains(peptide) {
                                        selectedPeptides.remove(peptide)
                                    } else {
                                        selectedPeptides.insert(peptide)
                                    }
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
                        .background(selectedPeptides.isEmpty ? Color.black.opacity(0.3) : Color.black)
                        .cornerRadius(28)
                }
                .disabled(selectedPeptides.isEmpty)
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
            }
        }
    }
}

struct MultiSelectButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isSelected ? .white : .black)
                
                Spacer()
                
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(isSelected ? Color.black : Color.gray.opacity(0.05))
            .cornerRadius(12)
        }
    }
}

#Preview {
    OnboardingPeptides(onNext: {})
}
