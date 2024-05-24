//
//  InputStepView.swift
//  PlanIO
//
//  Created by 신혜연 on 5/20/24.
//

import SwiftUI

struct InputStepView: View {
    @Environment(InputData.self) private var inputData
    
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
        .frame(width: 550)
    }
    
    @ViewBuilder
    private func stepIcon(_ step: InputStep) -> some View {
        HStack(spacing: 0) {
            if step != .schedule {
                Rectangle()
                    .frame(width: rectangleWidth(for: step), height: 5)
                    .foregroundColor(inputData.selectedStep.rawValue >= step.rawValue ? .planIOYellow : .planIOLightGray)
            }
            
            ZStack {
                Circle()
                    .frame(width: 54, height: 54)
                    .foregroundColor(backgroundColor(for: step))
                
                Image(systemName: step.imageName)
                    .font(.system(size: 22))
            }
        }
    }
    
    private func backgroundColor(for step: InputStep) -> Color {
        if inputData.selectedStep.rawValue >= step.rawValue {
            return .planIOYellow
        } else {
            return .planIOLightGray
        }
    }
    
    private func rectangleWidth(for step: InputStep) -> CGFloat {
        switch step {
        case .scope:
            return 110
        case .book:
            return 110
        case .time:
            return 110
        default:
            return 0
        }
    }
}

#Preview {
    InputStepView()
}
