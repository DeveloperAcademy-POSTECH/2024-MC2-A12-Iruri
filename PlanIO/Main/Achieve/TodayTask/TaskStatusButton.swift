//
//  TaskStatusButton.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct TaskStatusButton: View {
    let status: TaskStatus
    
    var body: some View {
        Text(status.title)
            .font(.caption)
            .foregroundStyle(status.color)
            .frame(width: 50, height: 22)
            .background(backgroundColor())
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay {
                RoundedRectangle(cornerRadius: 12)
                    .inset(by: 0.5)
                    .stroke(status.color, lineWidth: 1)
            }
    }
    
    private func backgroundColor() -> Color {
        switch status {
        case .complete: Color.planIOLightBlue
        case .inProgress: Color.planIOLightYellow
        case .incomplete: Color.planIORed
        case .none: Color.planIOLightGray
        }
    }
}
