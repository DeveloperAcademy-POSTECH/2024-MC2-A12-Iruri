//
//  StatusSelectPopUp.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct StatusSelectPopUp: View {
    @Binding var task: Task
    @Binding var selectedTask: Task?
    
    var body: some View {
        HStack {
            Spacer()
            
            HStack {
                ForEach(TaskStatus.allCases, id: \.self) { status in
                    if status != .none {
                        Button {
                            task.status = status
                            selectedTask = nil
                        } label: {
                            Text(status.title)
                                .foregroundStyle(status.color)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 12)
                        }
                        if status != .incomplete { Divider() }
                    }
                }
            }
            .padding(.horizontal, 12)
            .background(Color.planIOLightGray)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .frame(height: 40)
        .offset(y: -40)
    }
}
