//
//  TaskLow.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct TaskRow: View {
    let task: Task
    
    var body: some View {
        HStack {
            Text(task.title)
                .font(.footnote).bold()
                .foregroundStyle(Color.black)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            TaskStatusButton(status: task.status)
        }
        .padding(10)
        .padding(.leading, 6)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .shadow(color: .black.opacity(0.3), radius: 1.5, x: 0, y: 1)
    }
}
