//
//  PlanNavigationSplitView.swift
//  PlanIO
//
//  Created by 대여품 on 5/23/24.
//

import SwiftData
import SwiftUI

struct SidebarView: View {
    let fromAchieveView: Bool

    @Environment(InputData.self) private var inputData
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Task.title) var tasks: [Task]
    
    @Binding var draggingTarget: Task?
    @Binding var draggingTargetDate: Date
    
    @State var showPopover: Bool = false
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Text("학습 계획")
                    .font(.title2).bold()
                Spacer()
                Text("+")
                    .font(.title)
                    .foregroundStyle(.planIODarkYellow)
                    .onTapGesture {
                        // Task 추가 기능 구현
                        showPopover.toggle()
                    }
            }
            .padding(.horizontal, 15)
            .popover(isPresented: $showPopover) {
                TaskAddView(showPopover: $showPopover, addDataFunc: addData)
            }
            
            SidebarTaskListView(draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
            
            Spacer()
            
            if fromAchieveView == false {
                Button {
                    // 자동배치 기능
                    TaskManager.distributeTasks(tasks: tasks, endDate: inputData.scienceTestDate ?? Date(), availableTimes: inputData.availableTimePerDay)
                } label: {
                    HStack {
                        Spacer()
                        Text("자동배치")
                            .font(.footnote).bold()
                            .foregroundStyle(Color.black)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    .padding(10)
                    .background(Color.planIOYellow)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .shadow(color: .black.opacity(0.3), radius: 1.5, x: 0, y: 1)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 12)
                }
            }
        }
        .onAppear {
            // 임시 Task를 넣어서 실험하기 위함
            if tasks.isEmpty {
                for idx in 0..<2 {
                    let task = Task(title: "concept \(idx) this is very long tasks, here we go, I like potato", type: .concept, status: .none)
                    
                    modelContext.insert(task)
                }
                
                for idx in 0..<2 {
                    let task = Task(title: "practice \(idx)", type: .practice, status: .none)
                    
                    modelContext.insert(task)
                }
                
                for idx in 0..<2 {
                    let task = Task(title: "other \(idx)", type: .other, status: .none)
                    
                    modelContext.insert(task)
                }
            }
        }
    }
    
    func addData(data: Task) {
        modelContext.insert(data)
    }
}
