//
//  PlanNavigationTaskListView.swift
//  PlanIO
//
//  Created by 대여품 on 5/23/24.
//

import SwiftUI
import SwiftData

struct PlanNavigationTaskListView: View {
    @Query(sort: \Task.title) var tasks: [Task]
    @State private var isConceptSectionExpanded: Bool = true
    @State private var isPracticeSectionExpanded: Bool = true
    @State private var isOtherSectionExpanded: Bool = true
    
    private let valueListRowInsets: [CGFloat] = [3,-5,3,-5]
    
    var body: some View {
        let conceptTasks: [Task] = tasks.filter { $0.type == .concept }
        let practiceTasks: [Task] = tasks.filter { $0.type == .practice }
        let otherTasks: [Task] = tasks.filter { $0.type == .other }
        let toggleup = Image(systemName: "chevron.up")
        let toggledown = Image(systemName: "chevron.down")

        
        
        VStack(alignment: .leading, spacing: 0) {
            List(){
                
                // 개념
                HStack{
                    Text(TaskType.concept.title)
                        .font(.body).bold()
                        .foregroundStyle(Color.planIODarkGray)
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    Button {
                        isConceptSectionExpanded.toggle()
                    }label: {
                        isConceptSectionExpanded ? toggleup : toggledown
                    }
                }
                .listRowInsets(EdgeInsets(top: valueListRowInsets[0], leading: valueListRowInsets[1], bottom: valueListRowInsets[2], trailing: valueListRowInsets[3]))
                
                if isConceptSectionExpanded{
                    ForEach(conceptTasks.indices) { index in
                        let task = conceptTasks[index]
                        PlanNavigationTaskRow(task: task)
                    }
                }
                
                
                // 응용
                HStack{
                    Text(TaskType.practice.title)
                        .font(.body).bold()
                        .foregroundStyle(Color.planIODarkGray)
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    Button {
                        isPracticeSectionExpanded.toggle()
                    }label: {
                        isPracticeSectionExpanded ? toggleup : toggledown
                    }
                }
                .listRowInsets(EdgeInsets(top: valueListRowInsets[0], leading: valueListRowInsets[1], bottom: valueListRowInsets[2], trailing: valueListRowInsets[3]))
                
                if isPracticeSectionExpanded{
                    ForEach(practiceTasks.indices) { index in
                        let task = practiceTasks[index]
                        PlanNavigationTaskRow(task: task)
                    }
                }
                
                
                // 기타
                HStack{
                    Text(TaskType.other.title)
                        .font(.body).bold()
                        .foregroundStyle(Color.planIODarkGray)
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    Button {
                        isOtherSectionExpanded.toggle()
                    }label: {
                        isOtherSectionExpanded ? toggleup : toggledown
                    }
                }
                .listRowInsets(EdgeInsets(top: valueListRowInsets[0], leading: valueListRowInsets[1], bottom: valueListRowInsets[2], trailing: valueListRowInsets[3]))
                
                if isOtherSectionExpanded{
                    ForEach(otherTasks.indices) { index in
                        let task = otherTasks[index]
                        PlanNavigationTaskRow(task: task)
                    }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task.self, configurations: config)
    
    for i in TaskManager.dummy3 {
        container.mainContext.insert(i)
    }
    
    return PlanView().modelContainer(container)

}
