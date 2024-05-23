//
//  TodayTaskView.swift
//  PlanIO
//
//  Created by Anjin on 5/19/24.
//

import SwiftData
import SwiftUI

struct TodayTaskView: View {
    @Environment(\.modelContext) private var modelContext
    
    @State private var happy: Bool = false
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("오늘의 할 일")
                    .font(.title).bold()
                    .padding(.leading, 6)
                
                Button {
//                    print("tasks before \(tasks)")
                    
                    let task = Task(title: "1-1-1. 자극을 전달하는 신경계", type: .concept, status: .complete)
                    modelContext.insert(task)
                    try? modelContext.save()
                    
                    happy.toggle()
                    
//                    print("tasks after \(tasks)")
                } label: {
                    Text("task 추가")
                }
                
                Spacer()
                
                NavigationLink {
                    
                } label: {
                    HStack {
                        Text("전체보기")
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(Color.planIOGray)
                }
            }
            .frame(height: 40)
            
            ScrollView {
                VStack(spacing: 40) {
                    // 개념
                    TodayTaskListView(type: .concept)
                    
                    // 응용
                    TodayTaskListView(type: .practice)
                    
                    // 기타
                    TodayTaskListView(type: .other)
                }
                .padding(.vertical, 30)
                .padding(.horizontal, 24)
            }
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
        }
    }
}

#Preview {
    AchieveView()
}
