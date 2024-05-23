//
//  TodayTaskListView.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftData
import SwiftUI

struct TodayTaskListView: View {
    let type: TaskType
    @Query(sort: \Task.title) var tasks: [Task]
    
    @State private var selectedTask: Task?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(type.title)
                    .font(.body).bold()
                    .foregroundStyle(Color.planIODarkGray)
                    .padding(.leading, 10)
                
                Spacer()
            }
            
            if tasks.isEmpty == false {
                ForEach(tasks) { task in
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
                        
                        if let selectedTask = selectedTask, task == selectedTask {
//                            StatusSelectPopUp(taskId: task.id, selectedTask: $selectedTask)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AchieveView()
}
