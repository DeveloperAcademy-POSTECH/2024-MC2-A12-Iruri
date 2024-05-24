//
//  EntireStatusView.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct EntireStatusView: View {
    let totalRate: Int = 78
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("시험까지 실천한 계획")
                        .font(.body).bold()
                    Text("앞으로 같이 힘내보자")
                        .font(.caption).bold()
                        .foregroundStyle(Color.planIOSemiLightGray)
                }
                
                Spacer()
                
                HStack {
// 바뀌어야하는 숫자
                    Text("\(totalRate)")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundStyle(Color.planIODarkYellow)
                    Text("%")
                        .font(.system(size: 16, weight: .black))
                        .foregroundStyle(Color.planIODarkGray)
                        .padding(.top, 25)
                }
            }
// 막대 그래프
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.planIOLightYellow)
                    
                // 성취에 따라 달라지는 막대기
                GeometryReader { geo in
                    Rectangle()
                        .foregroundColor(.planIODarkYellow)
                        .frame(width: geo.size.width * CGFloat(totalRate) / 100)
                        .cornerRadius(22)
                }
            }
            .frame(height: 22)
            .cornerRadius(22)
        }
    }
}

#Preview {
    AchieveView()
}
