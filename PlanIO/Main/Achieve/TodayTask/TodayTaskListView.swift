//
//  TodayTaskListView.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct TodayTaskListView: View {
    let type: TaskType
    @State var tasks: [Task]
    @State private var selectedTask: Task?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(type.title)
                .font(.body).bold()
                .foregroundStyle(Color.planIODarkGray)
                .padding(.leading, 10)
            
            ForEach(tasks.indices) { index in
                let task = tasks[index]
                ZStack {
                    Button {
                        if selectedTask == nil {
                            withAnimation {
                                selectedTask = task
                            }
                        } else {
                            selectedTask = nil
                        }
                    } label: {
                        TaskLow(task: task)
                    }
                    
//                    TaskLow(task: task)
//                        .onTapGesture {
//                            if selectedTask == nil {
//                                withAnimation {
//                                    selectedTask = task
//                                }
//                            } else {
//                                selectedTask = nil
//                            }
//                        }
                    
                    if let selectedTask = selectedTask, task == selectedTask {
                        StatusSelectPopUp(task: $tasks[index], selectedTask: $selectedTask)
                    }
                }
            }
        }
    }
}

#Preview {
    AchieveView()
}
