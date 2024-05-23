//
//  PlanNavigationTaskListView.swift
//  PlanIO
//
//  Created by 대여품 on 5/23/24.
//

import SwiftUI
import SwiftData

struct PlanNavigationTaskListView: View {
    let type: TaskType
    @Query(sort: \Task.title) var tasks: [Task]
    @State private var isSectionExpanded: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // 소제목 부분
            HStack{
                Text(type.title) // 개념, 응용, 기타
                    .font(.body).bold()
                    .foregroundStyle(Color.planIODarkGray)
                    .padding(.leading, 10)
                
                //TODO
                // 토글만들어라
                Spacer()
                
                
                
                Text("^")
                    .onTapGesture {
                        isSectionExpanded.toggle()
                    }// 토글 상태에 따라서 바뀌어 줘야함.
                ///////// 여기서 상테를 변경을 하면
            }
            
            if isSectionExpanded{
                List(){
                    ForEach(tasks.indices) { index in
                        let task = tasks[index]
                        PlanNavigationTaskRow(task: task)
                    }
                    .onDelete(perform: { indexSet in
                        // TODO
                    })
                }
            }
            
        }
    }
}


#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task.self, configurations: config)
    
    for i in TaskManager.dummy3 {
        //            let task = TaskManager.dummy1
        //            let task2 = TaskManager.dummy2
        container.mainContext.insert(i)
    }
    
    return PlanNavigationTaskListView(type: .concept).modelContainer(container)
    
//    return PlanView().modelContainer(container)
    
    
    //    PlanView()
}
