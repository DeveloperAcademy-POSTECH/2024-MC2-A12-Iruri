//
//  AchieveView.swift
//  PlanIO
//
//  Created by Anjin on 5/17/24.
//

import SwiftUI

struct AchieveView: View {
    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text("실천해보자")
                    .font(.title).bold()
                    .foregroundStyle(Color.planIODarkYellow)
                
                Spacer()
                
                Image(systemName: "person")
            }
            .padding(.horizontal, 40)
            
            Divider()
            
            HStack(spacing: 24) {
                // 오늘의 할 일
                TodayTaskView()
                    .frame(width: 340)
                
                VStack(spacing: 24) {
                    // 전체 공부 현황
                    EntireStatusView()
                        .achieveComponentBackground()
                        .achieveComponentTitle("전체 공부 현황")
                    
                    HStack(spacing: 24) {
                        // 오늘 공부 현황
                        VStack(spacing: 12) {
                            // 오늘의 성취
                            TodayAchieveView()
                                .achieveComponentBackground()
                            
                            // 남은 기간
                            RemainTimeView()
                                .achieveComponentBackground()
                        }
                        .achieveComponentTitle("오늘 공부 현황")
                        
                        // 오늘의 한 마디
                        TodayAdviceView()
                            .achieveComponentBackground()
                            .achieveComponentTitle("오늘의 한 마디")
                    }
                }
            }
            .padding(.horizontal, 60)
            .padding(.bottom, 40)
        }
        .background(Color.planIOLightGray)
    }
}

#Preview {
    AchieveView()
}
