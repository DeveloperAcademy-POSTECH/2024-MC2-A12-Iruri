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
            .font(.caption).fontWeight(.semibold)
            .foregroundStyle(.black)
            .frame(width: 50, height: 22)
            .background(status.lightColor)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
