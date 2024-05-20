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
                    .frame(width: 360)
                
                VStack(spacing: 24) {
                    // 전체 공부 현황
                    Rectangle()
                        .frame(height: 160)
                        .overlay {
                            Text("전체 공부 현황\n다다? 블리시?")
                                .foregroundStyle(Color.white)
                        }
                    
                    HStack(spacing: 24) {
                        VStack(spacing: 12) {
                            // 오늘의 성취
                            Rectangle()
                                .overlay {
                                    Text("오늘의 성취\n다다? 블리시?")
                                        .foregroundStyle(Color.white)
                                }
                            
                            // 남은 기간
                            Rectangle()
                                .overlay {
                                    Text("남은 기간\n이오")
                                        .foregroundStyle(Color.white)
                                }
                        }
                        
                        // 오늘의 한마디
                        Rectangle()
                            .overlay {
                                Text("오늘의 한마디\n다다? 블리시?")
                                    .foregroundStyle(Color.white)
                            }
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
