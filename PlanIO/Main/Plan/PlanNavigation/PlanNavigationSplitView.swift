//
//  PlanNavigationSplitView.swift
//  PlanIO
//
//  Created by 대여품 on 5/23/24.
//

import SwiftData
import SwiftUI

struct PlanNavigationSplitView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Task.title) var tasks: [Task]
    
    @Binding var draggingTarget: Task?
    @Binding var draggingTargetDate: Date
    
    var body: some View {
        VStack {
            HStack {
                Text("학습 계획")
                    .font(.title).bold()
                Spacer()
                Text("+")
                    .onTapGesture {
                        // Task 추가 기능 구현
                    }
            }
            .padding(.horizontal, 10)
            
            PlanNavigationTaskListView(draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
            
            Spacer()
            
            Button {
                // 자동배치 기능
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
        .onAppear {
            // 임시 Task를 넣어서 실험하기 위함
            if tasks.isEmpty {
                for idx in 0..<4 {
                    let task = Task(title: "concept \(idx) this is very long tasks, here we go, I like potato", type: .concept, status: .none)
                    
                    modelContext.insert(task)
                }
                
                for idx in 0..<2 {
                    let task = Task(title: "practice \(idx)", type: .practice, status: .none)
                    
                    modelContext.insert(task)
                }
                
                for idx in 0..<5 {
                    let task = Task(title: "other \(idx)", type: .other, status: .none)
                    
                    modelContext.insert(task)
                }
                
            }
        }
    }
}
