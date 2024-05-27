//
//  InputView.swift
//  PlanIO
//
//  Created by Anjin on 5/17/24.
//

import SwiftUI

struct InputView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(InputData.self) private var inputData
    
    @State private var cellColors: [[Color]] = Array(repeating: Array(repeating: Color.white, count: 7), count: 12)
    @State private var isAnyCellFilled: Bool = false
    @State private var isNextButtonEnabled = false
    
    var isExamScheduleChecked: Bool { inputData.scienceTestDate != nil }
    
    @State private var showCalendarView = false
    
    var body: some View {
        VStack(spacing: 16) {
            InputStepView()
            
            // 펭귄이오
            HStack(spacing: 20) {
                Spacer()
                Image("PlanIOHalf")
                    .resizable()
                    .frame(width: 125, height: 125)
                    .shadow(color: .black.opacity(0.3), radius: 7.5, x: 0, y: 10)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        InputTriangle()
                            .fill(Color.planIOLightGray)
                            .frame(width: 15, height: 35)
                        
                        HStack(spacing: 0) {
                            Text(inputData.selectedStep.speechBubbleText)
                                .multilineTextAlignment(.center)
                                .bold()
                                .frame(width: 420, height: 50)
                        }
                        .padding(.vertical, 18)
                        .background(Color.planIOLightGray)
                        .clipShape(RoundedRectangle(cornerRadius: 13))
                    }
                }
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                switch inputData.selectedStep {
                case .schedule:
                    TestDateView(isNextButtonEnabled: $isNextButtonEnabled)
                case .scope:
                    TestScopeView()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                case .book:
                    SelectBookView()
                case .time:
                    CheckTimeView(cellColors: $cellColors, isAnyCellFilled: $isAnyCellFilled)
                }
                Spacer()
                
                HStack { Spacer() }
            }
            
            HStack {
                Button(action: {
                    inputData.selectedStep = inputData.selectedStep.previousStep() ?? .schedule
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 266, height: 60)
                            .foregroundColor(inputData.selectedStep != .schedule ? .planIOYellow : .planIOGray)
                            .shadow(color: .planIOGray, radius: 3, y: 2 )
                        Text("이전으로")
                            .foregroundColor(inputData.selectedStep != .schedule ? .black : .planIODarkGray)
                            .bold()
                    }
                })
                .disabled(inputData.selectedStep == .schedule)
                
                Button(action: {
                    if inputData.selectedStep != .time {
                        inputData.selectedStep = inputData.selectedStep.nextStep() ?? .schedule
                    } else {
                        saveAvailableTime()
                        TaskManager.makeTask(modelContext: modelContext, scopes: inputData.scopes)
                        showCalendarView = true
                    }
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 266, height: 60)
                            .foregroundColor(isNextButtonInactive() == false ? .planIOYellow : .planIOGray)
                            .shadow(color: .planIOGray, radius: 3, y: 2 )
                        Text("다음으로")
                            .foregroundColor(isNextButtonInactive() == false ? .black : .planIODarkGray)
                            .bold()
                    }
                })
                .disabled(isNextButtonInactive())
                .navigationDestination(isPresented: $showCalendarView) {
                    PlanView().navigationBarBackButtonHidden() }
            }
        }
        .padding(.bottom, 30)
        Spacer()
    }
    
    private func isNextButtonInactive() -> Bool {
        switch inputData.selectedStep {
        case .schedule:
            return isExamScheduleChecked == false
        case .scope:
            return inputData.scopes.isEmpty
        case .book:
            return false
        case .time:
            return isAnyCellFilled == false
        }
    }
    
    private func saveAvailableTime() {
        inputData.availableTimePerDay = Array(repeating: 0, count: 7)
        
        cellColors.forEach { weeks in
            for day in 0 ..< 7 where weeks[day] == Color.planIOYellow {
                inputData.availableTimePerDay[day] += 1
            }
        }
        
        print("available \(inputData.availableTimePerDay)")
    }
}

struct InputTriangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    InputView()
}
