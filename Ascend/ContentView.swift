//
//  ContentView.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedPage = 0

    var body: some View {
        TabView(selection: $selectedPage) {
            OnboardingStepOneView()
                .tag(0)

            OnboardingStepTwoView()
                .tag(1)

            HomeScreenView()
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct HomeScreenView: View {
    @State private var selectedDayIndex: Int = 2

    private let calendarDays: [CalendarDay] = [
        CalendarDay(label: "MON", number: "10", isComplete: true),
        CalendarDay(label: "TUE", number: "11", isComplete: true),
        CalendarDay(label: "WED", number: "12", isComplete: false),
        CalendarDay(label: "THU", number: "13", isComplete: false),
        CalendarDay(label: "FRI", number: "14", isComplete: false),
        CalendarDay(label: "SAT", number: "15", isComplete: false),
        CalendarDay(label: "SUN", number: "16", isComplete: false)
    ]

    private let tasks: [TaskItem] = [
        TaskItem(title: "Morning peptide dose", time: "7:00 AM", isComplete: true),
        TaskItem(title: "Hydration check-in", time: "12:30 PM", isComplete: false),
        TaskItem(title: "Evening stack", time: "8:00 PM", isComplete: false)
    ]

    private let metrics: [MetricCardData] = [
        MetricCardData(title: "Fiber", value: "18g", target: "Goal: 25g", icon: "leaf.fill", background: Color(red: 0.97, green: 0.93, blue: 1.0)),
        MetricCardData(title: "Water", value: "64oz", target: "Goal: 90oz", icon: "drop.fill", background: Color(red: 0.91, green: 0.96, blue: 1.0)),
        MetricCardData(title: "Protein", value: "98g", target: "Goal: 120g", icon: "bolt.fill", background: Color(red: 1.0, green: 0.95, blue: 0.93)),
        MetricCardData(title: "Activity", value: "9k", target: "Goal: 12k steps", icon: "figure.walk", background: Color(red: 0.92, green: 0.95, blue: 0.90))
    ]

    private let logEntries: [LogEntry] = [
        LogEntry(title: "Energy", detail: "High all afternoon"),
        LogEntry(title: "Sleep", detail: "7h 45m • HRV +5%"),
        LogEntry(title: "Focus", detail: "Deep work blocks completed")
    ]

    private var todayString: String {
        DateFormatter.ascendHome.string(from: Date())
    }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            Color(red: 0.96, green: 0.97, blue: 1.0)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 24) {
                        HomeTopBar(dateString: todayString)

                        DaySelectorView(days: calendarDays, selectedIndex: $selectedDayIndex)

                        PeptideDayCard(tasks: tasks)

                        MedicationLevelCard()

                        HabitSummaryGrid(metrics: metrics)

                        GoalCard()

                        SelectedLogCard(entries: logEntries)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 36)
                    .padding(.bottom, 140)
                }

                BottomNavBar()
                    .padding(.horizontal, 24)
                    .padding(.vertical, 20)
                    .background(
                        Color.white
                            .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                            .shadow(color: Color.black.opacity(0.05), radius: 20, x: 0, y: -8)
                    )
                    .padding(.horizontal, 16)
                    .padding(.bottom, 8)
            }

            FloatingPlusButton()
                .padding(.trailing, 36)
                .padding(.bottom, 110)
        }
    }
}

private struct HomeTopBar: View {
    let dateString: String

    var body: some View {
        HStack(alignment: .center) {
            HStack(spacing: 10) {
                Circle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color(red: 0.53, green: 0.42, blue: 0.93),
                                Color(red: 0.35, green: 0.23, blue: 0.72)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .frame(width: 36, height: 36)

                Text("Ascend")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(Color(red: 0.16, green: 0.15, blue: 0.37))
            }

            Spacer()

            HStack(spacing: 16) {
                HStack(spacing: 6) {
                    Image(systemName: "calendar")
                        .font(.system(size: 16, weight: .medium))
                    Text(dateString.uppercased())
                        .font(.system(size: 14, weight: .semibold))
                }
                .foregroundColor(Color(red: 0.40, green: 0.39, blue: 0.58))

                HStack(spacing: 6) {
                    Image(systemName: "flame.fill")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(Color(red: 0.98, green: 0.57, blue: 0.28))
                    Text("12")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color(red: 0.32, green: 0.29, blue: 0.53))
                }
            }
        }
    }
}

private struct DaySelectorView: View {
    let days: [CalendarDay]
    @Binding var selectedIndex: Int

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(days.indices, id: \.self) { index in
                    Button {
                        selectedIndex = index
                    } label: {
                        DayChip(day: days[index], isSelected: selectedIndex == index)
                    }
                    .buttonStyle(.plain)
                }
            }
        }
    }
}

private struct DayChip: View {
    let day: CalendarDay
    let isSelected: Bool

    var body: some View {
        VStack(spacing: 8) {
            Text(day.label)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(isSelected ? .white.opacity(0.9) : Color(red: 0.45, green: 0.44, blue: 0.60))

            ZStack {
                Circle()
                    .fill(Color.white)

                if isSelected {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [
                                    Color(red: 0.53, green: 0.42, blue: 0.93),
                                    Color(red: 0.35, green: 0.23, blue: 0.72)
                                ],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                }
            }
            .frame(width: 60, height: 60)
            .shadow(color: isSelected ? Color(red: 0.35, green: 0.23, blue: 0.72).opacity(0.28) : Color.clear, radius: 14, x: 0, y: 12)

                Text(day.number)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(isSelected ? .white : Color(red: 0.33, green: 0.31, blue: 0.54))
            }

            Circle()
                .fill(day.isComplete ? Color(red: 0.40, green: 0.80, blue: 0.64) : Color.clear)
                .frame(width: 8, height: 8)
        }
    }


private struct PeptideDayCard: View {
    let tasks: [TaskItem]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Peptide Day")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(Color(red: 0.18, green: 0.17, blue: 0.33))
                Spacer()
                Text("Today")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(red: 0.49, green: 0.47, blue: 0.72))
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color(red: 0.93, green: 0.92, blue: 0.98))
                    .cornerRadius(12)
            }

            VStack(spacing: 12) {
                ForEach(tasks) { task in
                    TaskRow(task: task)
                }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.04), radius: 18, x: 0, y: 12)
        )
    }
}

private struct TaskRow: View {
    let task: TaskItem

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: task.isComplete ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 24, weight: .semibold))
                .foregroundColor(task.isComplete ? Color(red: 0.40, green: 0.80, blue: 0.64) : Color(red: 0.80, green: 0.80, blue: 0.90))

            VStack(alignment: .leading, spacing: 4) {
                Text(task.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(red: 0.20, green: 0.19, blue: 0.36))
                Text(task.time)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(Color(red: 0.54, green: 0.52, blue: 0.72))
            }

            Spacer()
        }
    }
}

private struct MedicationLevelCard: View {
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(
                    LinearGradient(
                        colors: [
                            Color(red: 0.39, green: 0.27, blue: 0.76),
                            Color(red: 0.24, green: 0.17, blue: 0.53)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .shadow(color: Color(red: 0.24, green: 0.17, blue: 0.53).opacity(0.25), radius: 24, x: 0, y: 16)

            VStack(alignment: .leading, spacing: 18) {
                HStack {
                    Text("Medication Level")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "waveform.path.ecg")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(.white.opacity(0.9))
                }

                Text("Current dose • 1.2 mg")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white.opacity(0.8))

                ProgressView(value: 0.72)
                    .progressViewStyle(.linear)
                    .tint(Color.white)

                HStack {
                    Text("72% to weekly goal")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.white)
                    Spacer()
                    Text("Next dose: 8:00 PM")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white.opacity(0.8))
                }
            }
            .padding(24)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 180)
    }
}

private struct HabitSummaryGrid: View {
    let metrics: [MetricCardData]

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(metrics) { metric in
                HabitMetricCard(metric: metric)
            }
        }
    }
}

private struct HabitMetricCard: View {
    let metric: MetricCardData

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: metric.icon)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(Color(red: 0.35, green: 0.23, blue: 0.72))
                .padding(10)
                .background(
                    Circle()
                        .fill(Color.white.opacity(0.6))
                )

            Text(metric.title)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(Color(red: 0.23, green: 0.22, blue: 0.41))

            Text(metric.value)
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(Color(red: 0.18, green: 0.17, blue: 0.33))

            Text(metric.target)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(Color(red: 0.49, green: 0.47, blue: 0.72))
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 24, style: .continuous)
                .fill(metric.background)
        )
    }
}

private struct GoalCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Goal Focus")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0.19, green: 0.18, blue: 0.38))
                Spacer()
                Image(systemName: "target")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Color(red: 0.35, green: 0.23, blue: 0.72))
            }

            Text("Dial in sleep routines this week. Aim for lights-out by 10:30 PM and note recovery changes.")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(Color(red: 0.40, green: 0.39, blue: 0.58))
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.04), radius: 18, x: 0, y: 12)
        )
    }
}

private struct SelectedLogCard: View {
    let entries: [LogEntry]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text("Selected Date's Log")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(Color(red: 0.20, green: 0.19, blue: 0.36))
                Spacer()
                Image(systemName: "ellipsis")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(Color(red: 0.54, green: 0.52, blue: 0.72))
            }

            VStack(spacing: 12) {
                ForEach(entries) { entry in
                    VStack(alignment: .leading, spacing: 6) {
                        Text(entry.title.uppercased())
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Color(red: 0.53, green: 0.42, blue: 0.93))
                        Text(entry.detail)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(Color(red: 0.26, green: 0.24, blue: 0.45))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .fill(Color(red: 0.97, green: 0.97, blue: 1.0))
                    )
                }
            }
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 28, style: .continuous)
                .fill(Color.white)
                .shadow(color: Color.black.opacity(0.04), radius: 18, x: 0, y: 12)
        )
    }
}

private struct FloatingPlusButton: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "plus")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(.white)
                .frame(width: 62, height: 62)
                .background(
                    LinearGradient(
                        colors: [
                            Color(red: 0.53, green: 0.42, blue: 0.93),
                            Color(red: 0.35, green: 0.23, blue: 0.72)
                        ],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .clipShape(Circle())
                .shadow(color: Color(red: 0.35, green: 0.23, blue: 0.72).opacity(0.35), radius: 24, x: 0, y: 18)
        }
        .buttonStyle(.plain)
    }
}

private struct BottomNavBar: View {
    var body: some View {
        HStack(spacing: 36) {
            NavIcon(isActive: true, systemName: "house.fill", title: "Home")
            NavIcon(isActive: false, systemName: "chart.bar", title: "Metrics")
            NavIcon(isActive: false, systemName: "leaf", title: "Habits")
            NavIcon(isActive: false, systemName: "bell", title: "Alerts")
            NavIcon(isActive: false, systemName: "person", title: "Profile")
        }
        .frame(maxWidth: .infinity)
    }
}

private struct NavIcon: View {
    let isActive: Bool
    let systemName: String
    let title: String

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: systemName)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(isActive ? Color(red: 0.35, green: 0.23, blue: 0.72) : Color(red: 0.65, green: 0.64, blue: 0.78))
            Circle()
                .fill(isActive ? Color(red: 0.35, green: 0.23, blue: 0.72) : Color.clear)
                .frame(width: 6, height: 6)
        }
    }
}

private struct CalendarDay: Identifiable {
    let id = UUID()
    let label: String
    let number: String
    let isComplete: Bool
}

private struct TaskItem: Identifiable {
    let id = UUID()
    let title: String
    let time: String
    let isComplete: Bool
}

private struct MetricCardData: Identifiable {
    let id = UUID()
    let title: String
    let value: String
    let target: String
    let icon: String
    let background: Color
}

private struct LogEntry: Identifiable {
    let id = UUID()
    let title: String
    let detail: String
}

private extension DateFormatter {
    static let ascendHome: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, MMM d"
        return formatter
    }()
}

#Preview {
    ContentView()
}

