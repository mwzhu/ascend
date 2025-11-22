//
//  PeptidesView.swift
//  Ascend
//
//  Created by Michael Zhu on 11/3/25.
//

import SwiftUI

struct PeptidesView: View {
    @Binding var showLogPopup: Bool
    var onLogPeptide: (() -> Void)?
    @State private var selectedDate = Date()
    @State private var showDateCircles = false
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Top Row - Logo, Date, Streak
                HStack {
                    Text("Peptides")
                        .font(.system(size: 26, weight: .bold))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button(action: {
                        showDateCircles.toggle()
                    }) {
                        HStack(spacing: 6) {
                            Image(systemName: "calendar")
                                .font(.system(size: 19))
                                .foregroundColor(.gray).opacity(0.5)
                            Text(dateString)
                                .font(.system(size: 15, weight: .semibold))
                        }
                        .foregroundColor(.black)
                    }
                    
                    Spacer()
                        .frame(width: 20)
                    
                    HStack(spacing: 6) {
                        Image(systemName: "flame.fill")
                            .font(.system(size: 19))
                            .foregroundColor(.orange).opacity(0.7)
                        Text("7")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 12)
                .padding(.bottom, 2)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 12) {
                        // Date Circles Row
                        if showDateCircles {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(0..<14) { index in
                                        let date = Calendar.current.date(byAdding: .day, value: index - 7, to: Date())!
                                        DateCircle(
                                            date: date,
                                            isSelected: Calendar.current.isDate(date, inSameDayAs: selectedDate),
                                            circleStyle: index % 3 == 0 ? .blank : (index % 3 == 1 ? .grayWithIcon : .orangeWithIcon)
                                        ) {
                                            selectedDate = date
                                        }
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        } else {
                            Spacer().frame(height: 1)
                        }
                        
                        // Combined Protocol Stack Card
                        CombinedProtocolStackCard()
                        
                        // Side Effects Card
                        SideEffectsCard()
                        
                        // Selected Date's Log
                        LogCard()
                        
                        Spacer().frame(height: 80)
                    }
                    .padding(.top, 10)
                }
                
                Spacer()
            }
            
            // Plus Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    if !showLogPopup {
                        Button(action: {
                            showLogPopup = true
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 25, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(width: 63, height: 63)
                                .background(Color.black)
                                .clipShape(Circle())
                                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        .padding(.trailing, 20)
                        .padding(.bottom, 17)
                    }
                }
            }
            
            if showLogPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .transition(.opacity)
                    .zIndex(2)
                    .onTapGesture {
                        showLogPopup = false
                    }

                LogOptionsPopup(
                    isPresented: $showLogPopup,
                    onLogPeptide: onLogPeptide
                )
                .transition(.scale(scale: 0.9, anchor: .bottomTrailing).combined(with: .opacity))
                .zIndex(3)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: showLogPopup)
    }
    
    var dateString: String {
        if Calendar.current.isDateInToday(selectedDate) {
            return "Today"
        }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, yyyy"
        return formatter.string(from: selectedDate)
    }
}

struct PeptideInfo: Identifiable {
    let id = UUID()
    let name: String
    let dosage: String
    let schedule: [String]
    let timeOfDay: String
    let location: String
    let purpose: String
}

struct ProtocolStack: Identifiable {
    let id = UUID()
    var name: String
    let radarValues: [Double]
    let peptides: [PeptideInfo]
}

struct CombinedProtocolStackCard: View {
    let categories = [
        "Recovery/Healing",
        "Performance",
        "Body Composition",
        "Longevity",
        "Cognitive/Mood",
        "Skin/Appearance"
    ]
    
    @State private var protocols: [ProtocolStack] = [
        ProtocolStack(
            name: "Weight Loss Stack",
            radarValues: [0.75, 0.6, 0.85, 0.5, 0.7, 0.65],
            peptides: [
                PeptideInfo(name: "Semaglutide", dosage: "2.5mg", schedule: ["Mon", "Wed", "Fri"], timeOfDay: "8:00 AM", location: "Abdomen", purpose: "Weight Management"),
                PeptideInfo(name: "BPC-157", dosage: "250mcg", schedule: ["Daily"], timeOfDay: "9:00 AM", location: "Thigh", purpose: "Recovery & Healing"),
                PeptideInfo(name: "CJC-1295", dosage: "100mcg", schedule: ["Tue", "Thu", "Sat"], timeOfDay: "10:00 PM", location: "Arm", purpose: "Performance & Longevity")
            ]
        ),
        ProtocolStack(
            name: "Performance Stack",
            radarValues: [0.6, 0.9, 0.7, 0.65, 0.75, 0.5],
            peptides: [
                PeptideInfo(name: "CJC-1295", dosage: "200mcg", schedule: ["Daily"], timeOfDay: "10:00 PM", location: "Arm", purpose: "Performance & Longevity"),
                PeptideInfo(name: "Ipamorelin", dosage: "250mcg", schedule: ["Daily"], timeOfDay: "10:00 PM", location: "Abdomen", purpose: "Growth Hormone Release")
            ]
        ),
        ProtocolStack(
            name: "Recovery Stack",
            radarValues: [0.95, 0.5, 0.6, 0.7, 0.65, 0.75],
            peptides: [
                PeptideInfo(name: "BPC-157", dosage: "500mcg", schedule: ["Daily"], timeOfDay: "8:00 AM", location: "Injury Site", purpose: "Healing & Recovery"),
                PeptideInfo(name: "TB-500", dosage: "2mg", schedule: ["Mon", "Wed", "Fri"], timeOfDay: "9:00 AM", location: "Thigh", purpose: "Tissue Repair")
            ]
        )
    ]
    
    @State private var currentProtocolIndex = 0
    @State private var isEditingName = false
    @State private var tempName = ""
    @State private var currentPeptidePage = 0
    
    var currentProtocol: ProtocolStack {
        protocols[currentProtocolIndex]
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                if isEditingName {
                    TextField("Stack Name", text: $tempName, onCommit: {
                        if !tempName.isEmpty {
                            protocols[currentProtocolIndex].name = tempName
                        }
                        isEditingName = false
                    })
                    .font(.system(size: 18, weight: .semibold))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    Text(currentProtocol.name)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: {
                        tempName = currentProtocol.name
                        isEditingName = true
                    }) {
                        Image(systemName: "pencil")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "bookmark")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "paperplane")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                }
            }
            
            HStack {
                Button(action: {
                    if currentProtocolIndex > 0 {
                        currentProtocolIndex -= 1
                        currentPeptidePage = 0
                    }
                }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 20))
                        .foregroundColor(currentProtocolIndex > 0 ? .black : .black.opacity(0.3))
                }
                .disabled(currentProtocolIndex == 0)
                
                Spacer()
                
                RadarChart(categories: categories, values: currentProtocol.radarValues)
                    .frame(height: 240)
                
                Spacer()
                
                Button(action: {
                    if currentProtocolIndex < protocols.count - 1 {
                        currentProtocolIndex += 1
                        currentPeptidePage = 0
                    }
                }) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20))
                        .foregroundColor(currentProtocolIndex < protocols.count - 1 ? .black : .black.opacity(0.3))
                }
                .disabled(currentProtocolIndex == protocols.count - 1)
            }
            
            Divider()
                .background(Color.black.opacity(0.1))
            
            VStack(alignment: .leading, spacing: 6) {
                VStack(spacing: 4) {
                    TabView(selection: $currentPeptidePage) {
                        ForEach(Array(currentProtocol.peptides.enumerated()), id: \.element.id) { index, peptide in
                            PeptideCardInline(peptide: peptide)
                                .tag(index)
                        }
                    }
                    .tabViewStyle(.page(indexDisplayMode: .never))
                    .frame(height: 120)
                    
                    HStack(spacing: 6) {
                        ForEach(0..<currentProtocol.peptides.count, id: \.self) { index in
                            Circle()
                                .fill(currentPeptidePage == index ? Color.black : Color.black.opacity(0.2))
                                .frame(width: 5, height: 5)
                        }
                    }
                    .padding(.top, 4)
                }
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.05))
        .cornerRadius(16)
        .padding(.horizontal, 20)
    }
}

struct PeptideRadarCard: View {
    let categories = [
        "Recovery/Healing",
        "Performance",
        "Body Composition",
        "Longevity",
        "Cognitive/Mood",
        "Skin/Appearance"
    ]
    
    let values: [Double] = [0.75, 0.6, 0.85, 0.5, 0.7, 0.65]
    
    @State private var stackName = "User's Stack"
    @State private var isEditingName = false
    @State private var tempName = ""
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                if isEditingName {
                    TextField("Stack Name", text: $tempName, onCommit: {
                        if !tempName.isEmpty {
                            stackName = tempName
                        }
                        isEditingName = false
                    })
                    .font(.system(size: 18, weight: .semibold))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                } else {
                    Text(stackName)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button(action: {
                        tempName = stackName
                        isEditingName = true
                    }) {
                        Image(systemName: "pencil")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "bookmark")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                    
                    Button(action: {}) {
                        Image(systemName: "paperplane")
                            .font(.system(size: 16))
                            .foregroundColor(.black)
                    }
                }
            }
            
            RadarChart(categories: categories, values: values)
                .frame(height: 240)
        }
        .padding(20)
        .background(Color.black.opacity(0.05))
        .cornerRadius(16)
        .padding(.horizontal, 20)
    }
}

struct RadarChart: View {
    let categories: [String]
    let values: [Double]
    
    var body: some View {
        GeometryReader { geometry in
            let center = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
            let radius = min(geometry.size.width, geometry.size.height) / 2 - 50
            let angleStep = (2 * .pi) / Double(categories.count)
            
            ZStack {
                ForEach(1..<4) { level in
                    RadarPolygon(sides: categories.count, radius: radius * Double(level) / 3.0)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 1)
                }
                
                RadarDataShape(values: values, radius: radius)
                    .fill(Color(hex: "FF7300").opacity(0.2))
                
                RadarDataShape(values: values, radius: radius)
                    .stroke(Color(hex: "FF7300"), lineWidth: 2)
                
                ForEach(0..<categories.count, id: \.self) { index in
                    let angle = angleStep * Double(index) - .pi / 2
                    let endPoint = CGPoint(
                        x: center.x + cos(angle) * radius,
                        y: center.y + sin(angle) * radius
                    )
                    
                    Path { path in
                        path.move(to: center)
                        path.addLine(to: endPoint)
                    }
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                    
                    let labelRadius = radius + 30
                    let labelPoint = CGPoint(
                        x: center.x + cos(angle) * labelRadius,
                        y: center.y + sin(angle) * labelRadius
                    )
                    
                    Text(categories[index])
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .frame(width: 80)
                        .position(labelPoint)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct RadarPolygon: Shape {
    let sides: Int
    let radius: Double
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let angleStep = (2 * .pi) / Double(sides)
        
        var path = Path()
        
        for i in 0..<sides {
            let angle = angleStep * Double(i) - .pi / 2
            let point = CGPoint(
                x: center.x + cos(angle) * radius,
                y: center.y + sin(angle) * radius
            )
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        path.closeSubpath()
        return path
    }
}

struct RadarDataShape: Shape {
    let values: [Double]
    let radius: Double
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let angleStep = (2 * .pi) / Double(values.count)
        
        var path = Path()
        
        for i in 0..<values.count {
            let angle = angleStep * Double(i) - .pi / 2
            let distance = radius * values[i]
            let point = CGPoint(
                x: center.x + cos(angle) * distance,
                y: center.y + sin(angle) * distance
            )
            
            if i == 0 {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }
        
        path.closeSubpath()
        return path
    }
}

struct PeptideProtocolCard: View {
    let peptides = [
        PeptideInfo(name: "Semaglutide", dosage: "2.5mg", schedule: ["Mon", "Wed", "Fri"], timeOfDay: "8:00 AM", location: "Abdomen", purpose: "Weight Management"),
        PeptideInfo(name: "BPC-157", dosage: "250mcg", schedule: ["Daily"], timeOfDay: "9:00 AM", location: "Thigh", purpose: "Recovery & Healing"),
        PeptideInfo(name: "CJC-1295", dosage: "100mcg", schedule: ["Tue", "Thu", "Sat"], timeOfDay: "10:00 PM", location: "Arm", purpose: "Performance & Longevity")
    ]
    
    @State private var currentPage = 0
    
    var body: some View {
        VStack(spacing: 6) {
            TabView(selection: $currentPage) {
                ForEach(Array(peptides.enumerated()), id: \.element.id) { index, peptide in
                    PeptideCard(peptide: peptide)
                        .padding(.horizontal, 20)
                        .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 180)
            
            HStack(spacing: 6) {
                ForEach(0..<peptides.count, id: \.self) { index in
                    Circle()
                        .fill(currentPage == index ? Color.black : Color.black.opacity(0.2))
                        .frame(width: 6, height: 6)
                }
            }
            .padding(.bottom, 6)
        }
    }
}

struct PeptideCard: View {
    let peptide: PeptideInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(peptide.name)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
                Text(peptide.dosage)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(Color(hex: "FF7300"))
            }
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Image(systemName: "calendar")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.5))
                        .frame(width: 20)
                    Text(peptide.schedule.joined(separator: ", "))
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.7))
                }
                
                HStack {
                    Image(systemName: "clock")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.5))
                        .frame(width: 20)
                    Text(peptide.timeOfDay)
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.7))
                }
                
                HStack {
                    Image(systemName: "mappin.circle")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.5))
                        .frame(width: 20)
                    Text(peptide.location)
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.7))
                }
                
                HStack {
                    Image(systemName: "target")
                        .font(.system(size: 12))
                        .foregroundColor(.black.opacity(0.5))
                        .frame(width: 20)
                    Text(peptide.purpose)
                        .font(.system(size: 14))
                        .foregroundColor(.black.opacity(0.7))
                }
            }
        }
        .padding(16)
        .background(Color.black.opacity(0.05))
        .cornerRadius(16)
    }
}

struct PeptideCardInline: View {
    let peptide: PeptideInfo
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(peptide.name)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.black)
                Spacer()
                Text(peptide.dosage)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(Color(hex: "FF7300"))
            }
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    Image(systemName: "calendar")
                        .font(.system(size: 11))
                        .foregroundColor(.black.opacity(0.5))
                        .frame(width: 18)
                    Text(peptide.schedule.joined(separator: ", "))
                        .font(.system(size: 13))
                        .foregroundColor(.black.opacity(0.7))
                }
                
                HStack {
                    Image(systemName: "clock")
                        .font(.system(size: 11))
                        .foregroundColor(.black.opacity(0.5))
                        .frame(width: 18)
                    Text(peptide.timeOfDay)
                        .font(.system(size: 13))
                        .foregroundColor(.black.opacity(0.7))
                }
                
                HStack {
                    Image(systemName: "mappin.circle")
                        .font(.system(size: 11))
                        .foregroundColor(.black.opacity(0.5))
                        .frame(width: 18)
                    Text(peptide.location)
                        .font(.system(size: 13))
                        .foregroundColor(.black.opacity(0.7))
                }
                
                HStack {
                    Image(systemName: "target")
                        .font(.system(size: 11))
                        .foregroundColor(.black.opacity(0.5))
                        .frame(width: 18)
                    Text(peptide.purpose)
                        .font(.system(size: 13))
                        .foregroundColor(.black.opacity(0.7))
                }
            }
        }
        .padding(.horizontal, 20)
    }
}

struct SideEffectsCard: View {
    let sideEffects = [
        SideEffect(name: "Fatigue", severity: 1),
        SideEffect(name: "Injection Anxiety", severity: 2),
        SideEffect(name: "Nausea", severity: 3)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 8) {
                Image(systemName: "face.dashed")
                    .font(.system(size: 20))
                    .foregroundColor(.green.opacity(0.7))
                Text("Side Effects")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
            }
            
            VStack(spacing: 12) {
                ForEach(sideEffects) { effect in
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text(effect.name)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.black)
                            Spacer()
                            Text("\(effect.severity)/10")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                        }
                        
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 8)
                                    .cornerRadius(4)
                                
                                Rectangle()
                                    .fill(Color.green.opacity(0.6))
                                    .frame(width: geometry.size.width * (Double(effect.severity) / 10.0), height: 8)
                                    .cornerRadius(4)
                            }
                        }
                        .frame(height: 8)
                    }
                }
            }
            
            HStack {
                Spacer()
                Text(formattedDate)
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.05))
        .cornerRadius(20)
        .padding(.horizontal, 20)
    }
    
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM d'th' yyyy, h:mm a"
        return formatter.string(from: Date())
    }
}

struct SideEffect: Identifiable {
    let id = UUID()
    let name: String
    let severity: Int
}

// THIS IS ALREADY IMPLEMENTED IN HomeView.swift
// extension Color {
//     init(hex: String) {
//         let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
//         var int: UInt64 = 0
//         Scanner(string: hex).scanHexInt64(&int)
//         let a, r, g, b: UInt64
//         switch hex.count {
//         case 3:
//             (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
//         case 6:
//             (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
//         case 8:
//             (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
//         default:
//             (a, r, g, b) = (1, 1, 1, 0)
//         }
//         self.init(
//             .sRGB,
//             red: Double(r) / 255,
//             green: Double(g) / 255,
//             blue:  Double(b) / 255,
//             opacity: Double(a) / 255
//         )
//     }
// }

#Preview {
    PeptidesView(showLogPopup: .constant(false))
}