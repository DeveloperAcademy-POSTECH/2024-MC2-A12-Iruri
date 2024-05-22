//
//  InputView.swift
//  PlanIO
//
//  Created by Anjin on 5/17/24.
//

import SwiftUI

struct InputView: View {
    @State private var isNextButtonEnabled = false
    @State private var inputData: InputData = InputData()
    @State private var testDate: Date?
    
    var isExamScheduleChecked: Bool { testDate != nil }
    
    var body: some View {
        VStack(spacing: 20) {
            InputStepView()
            
            // 펭귄이오
            HStack(spacing: 20) {
                Spacer()
                Image("PlanIOCharacter")
                    .resizable()
                    .frame(width: 125, height: 125)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack(spacing: 0) {
                        Triangle()
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
                    TestDateView(isNextButtonEnabled: $isNextButtonEnabled, testDate: $testDate)
                case .scope, .book, .time:
                    TestScopeView()
                        .clipShape(RoundedRectangle(cornerRadius: 12))
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
                    inputData.selectedStep = inputData.selectedStep.nextStep() ?? .schedule
                }, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 266, height: 60)
                            .foregroundColor(isExamScheduleChecked && inputData.selectedStep != .time ? .planIOYellow : .planIOGray)
                            .shadow(color: .planIOGray, radius: 3, y: 2 )
                        Text("다음으로")
                            .foregroundColor(inputData.selectedStep == .time ? .planIODarkGray : (isExamScheduleChecked ? .black : .planIODarkGray))
                            .bold()
                    }
                })
                .disabled(!isExamScheduleChecked || inputData.selectedStep == .time)
            }
        }
        .padding(.vertical, 30)
        Spacer()
    }
}

struct Triangle: Shape {
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
