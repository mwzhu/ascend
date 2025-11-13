import SwiftUI

struct HealthGoal: Hashable {
    let icon: String
    let title: String
}

struct OnboardingHealthGoals: View {
    @State private var selectedGoals: Set<String> = []
    let onNext: () -> Void
    let maxSelections = 3
    
    let healthGoals: [HealthGoal] = [
        HealthGoal(icon: "⚖️", title: "Weight / Fat Loss"),
        HealthGoal(icon: "💪", title: "Muscle growth"),
        HealthGoal(icon: "🏥", title: "Recovery"),
        HealthGoal(icon: "✨", title: "Skin"),
        HealthGoal(icon: "💇‍♂️", title: "Hair"),
        HealthGoal(icon: "🌙", title: "Sleep"),
        HealthGoal(icon: "🧠", title: "Cognition"),
        HealthGoal(icon: "😌", title: "Stress & Mood"),
        HealthGoal(icon: "💞", title: "Sexual Health"),
        HealthGoal(icon: "⚡️", title: "Energy"),
        HealthGoal(icon: "🧘‍♀️", title: "Hormonal Balance"),
        HealthGoal(icon: "❤️", title: "Metabolic Health"),
        HealthGoal(icon: "👤", title: "Longevity"),
        HealthGoal(icon: "🛡️", title: "Immune Support"),
        HealthGoal(icon: "🦴", title: "Bone & Joint"),
        HealthGoal(icon: "🍵", title: "Gut Health"),
        HealthGoal(icon: "🏃‍♂️", title: "Fitness")
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
                Text("What are your most important health goals?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 16)
                
                // Subtitle Text
                Text("Select up to 3 goals in order of importance to you")
                    .font(.system(size: 12, weight: .light))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 30)
                
                // Health Goal Pills - Wrapped Layout
                ScrollView(showsIndicators: false) {
                    FlexibleView(
                        data: healthGoals,
                        spacing: 12,
                        alignment: .leading
                    ) { goal in
                        HealthGoalPill(
                            icon: goal.icon,
                            title: goal.title,
                            isSelected: selectedGoals.contains(goal.title),
                            action: {
                                if selectedGoals.contains(goal.title) {
                                    selectedGoals.remove(goal.title)
                                } else if selectedGoals.count < maxSelections {
                                    selectedGoals.insert(goal.title)
                                }
                            }
                        )
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
                        .background(selectedGoals.isEmpty ? Color.black.opacity(0.3) : Color.black)
                        .cornerRadius(28)
                }
                .disabled(selectedGoals.isEmpty)
                .padding(.horizontal, 32)
                .padding(.bottom, 20)
            }
        }
    }
}

struct HealthGoalPill: View {
    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                // if isSelected {
                //     Image(systemName: "checkmark")
                //         .font(.system(size: 12, weight: .semibold))
                //         .foregroundColor(.white)
                // }
                
                Text(icon)
                    .font(.system(size: 14))
                
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(isSelected ? .white : .black)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(isSelected ? Color.black : Color.gray.opacity(0.08))
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(isSelected ? Color.black : Color.clear, lineWidth: 1.5)
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    
    @State private var availableWidth: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: alignment, vertical: .top)) {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                }
            
            FlexibleViewContent(
                availableWidth: availableWidth,
                data: data,
                spacing: spacing,
                alignment: alignment,
                content: content
            )
        }
    }
}

struct FlexibleViewContent<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let availableWidth: CGFloat
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    
    var body: some View {
        VStack(alignment: alignment, spacing: spacing) {
            ForEach(computeRows(), id: \.self) { rowElements in
                HStack(spacing: spacing) {
                    ForEach(rowElements, id: \.self) { element in
                        content(element)
                    }
                }
            }
        }
    }
    
    func computeRows() -> [[Data.Element]] {
        var rows: [[Data.Element]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        
        for element in data {
            let elementWidth = element.width(for: content)
            
            if remainingWidth - elementWidth >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow += 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            
            remainingWidth -= (elementWidth + spacing)
        }
        
        return rows
    }
}

extension Hashable {
    func width<Content: View>(for content: (Self) -> Content) -> CGFloat {
        let view = content(self)
        let hostingController = UIHostingController(rootView: view)
        let size = hostingController.view.intrinsicContentSize
        return size.width
    }
}

extension View {
    func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
        background(
            GeometryReader { geometry in
                Color.clear
                    .preference(key: SizePreferenceKey.self, value: geometry.size)
            }
        )
        .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
    }
}

struct SizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

#Preview {
    OnboardingHealthGoals(onNext: {})
}
