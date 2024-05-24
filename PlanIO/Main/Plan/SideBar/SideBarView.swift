//
//  SideBarView.swift
//  PlanIO
//
//  Created by Seol WooHyeok on 5/23/24.
//

import SwiftData
import SwiftUI

struct SideBarView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Task.title) var tasks: [Task]
    
    @Binding var draggingTarget: Task?
    @Binding var draggingTargetDate: Date
    
    var body: some View {
        ScrollView {
            ForEach(tasks) { task in
                if task.date == Date(year: 0, month: 0, day: 0) {
                    Text(task.title)
                        .draggable(task.id.uuidString) {
                            Image(systemName: "tree.fill")
                                .onAppear {
                                    // 사이드바에서 드래그 된 목록은 Date가 0년 0월 0일
                                    draggingTarget = task
                                    draggingTargetDate = Date(year: 0, month: 0, day: 0)
                                }
                        }
                }
            }
        }
        .onAppear {
            _ = [TaskStatus.complete, TaskStatus.inProgress, TaskStatus.incomplete, TaskStatus.none]
            
            // 임시 Task를 넣어서 실험하기 위함
            if tasks.isEmpty {
                for idx in 0..<10 {
                    let task = Task(title: "task \(idx)", type: .concept, status: .complete)
                    modelContext.insert(task)
                }
            }
        }
    }
}
