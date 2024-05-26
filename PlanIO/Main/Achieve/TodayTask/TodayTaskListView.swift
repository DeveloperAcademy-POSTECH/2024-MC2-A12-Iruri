//
//  TodayTaskListView.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftData
import SwiftUI

/*
 @Query(filter: #Predicate<Movie> { movie in
     movie.releaseDate > now
 }) var unreleasedMovies: [Movie]
 */

struct TodayTaskListView: View {
    let type: TaskType
    
    @Query(sort: \Task.title) var tasks: [Task]
    @Binding var selectedTask: Task?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(type.title)
                    .font(.body).bold()
                    .foregroundStyle(Color.planIODarkGray)
                    .padding(.leading, 10)
                
                Spacer()
            }
            
            // FIXME: 오늘 할 일과 타입에 맞춰 쿼리에 Predicate 넣기
            let todayTasks: [Task] = tasks.filter { $0.date.isToday() }
            let filteredTasks: [Task] = todayTasks.filter { $0.type == type }
            
            if filteredTasks.isEmpty == false {
                ForEach(filteredTasks) { task in
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
                            TaskRow(task: task)
                        }
                        
                        if let selectedTask = selectedTask, task == selectedTask {
                            StatusSelectPopUp { status in
                                withAnimation {
                                    task.status = status
                                }
                                
                                self.selectedTask = nil
                            }
                            .shadow(color: .black.opacity(0.35), radius: 2.5, x: 0, y: 2)
                        }
                    }
                }
            } else {
                Text("할 일이 없어요 ✨")
                    .font(.footnote).bold()
                    .padding(.leading, 30)
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task.self, configurations: config)

    for _ in 1 ..< 10 {
        let task = TaskManager.dummy1
        container.mainContext.insert(task)
    }

    return AchieveView().modelContainer(container)
}
