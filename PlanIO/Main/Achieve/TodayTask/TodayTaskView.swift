//
//  TodayTaskView.swift
//  PlanIO
//
//  Created by Anjin on 5/19/24.
//

import SwiftUI

struct TodayTaskView: View {
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("오늘의 할 일")
                    .font(.title).bold()
                
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
                    TodayTaskListView(type: .concept, tasks: Task.dummy3)
                    
                    // 응용
                    TodayTaskListView(type: .practice, tasks: Task.dummy3)
                    
                    // 기타
                    TodayTaskListView(type: .other, tasks: Task.dummy3)
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
