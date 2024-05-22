//
//  InputStepView.swift
//  PlanIO
//
//  Created by 신혜연 on 5/20/24.
//

import SwiftUI

struct InputStepView: View {
    @State private var inputData = InputData()
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 0) {
                ForEach(InputStep.allCases, id: \.self) { step in
                    stepIcon(step)
                }
            }
            
            HStack {
                ForEach(InputStep.allCases, id: \.self) { step in
                    Text(step.title)
                        .bold()
                        .font(.system(size: 16))
                    
                    if step != .time {
                        Spacer()
                    }
                }
            }
        }
        .frame(width: 500)
    }
    
    @ViewBuilder
    private func stepIcon(_ step: InputStep) -> some View {
        HStack(spacing: 0) {
            if step != .schedule {
                Rectangle()
                    .frame(height: 5)
                    .foregroundColor(backgroundColor())
            }
            
            ZStack {
                Circle()
                    .frame(width: 54, height: 54)
                    .foregroundColor(backgroundColor())
                
                Image(systemName: step.imageName)
                    .font(.system(size: 22))
            }
        }
    }
    
    // TODO: step에 맞춰 색상 변경
    private func backgroundColor() -> Color {
        switch inputData.seletedStep {
        case .schedule: .planIOYellow
        case .scope: .planIOLightGray
        case .book: .planIOLightGray
        case .time: .planIOLightGray
        }
    }
}

#Preview {
    InputView()
}
