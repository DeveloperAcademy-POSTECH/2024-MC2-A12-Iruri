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
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("오늘의 할 일")
                    .font(.title).bold()
                    .padding(.leading, 6)
                
                Spacer()
                
                NavigationLink {
                    PlanView(fromAchieveView: true)
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
                    ForEach(TaskType.allCases, id: \.self) { type in
                        TodayTaskListView(type: type)
                    }
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
