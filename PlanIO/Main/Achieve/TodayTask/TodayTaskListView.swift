//
//  TodayTaskListView.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct TodayTaskListView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("개념")
                .font(.body).bold()
                .foregroundStyle(Color.planIODarkGray)
                .padding(.leading, 10)
            
            HStack {
                Text("1. 자극을 전달하는 신경계")
                    .font(.footnote).bold()
                
                Spacer()
                
                Text("완료")
                    .font(.caption)
                    .foregroundStyle(Color.planIODarkBlue)
                    .frame(width: 50, height: 22)
                    .background(Color.planIOLightBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .overlay {
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0.5)
                            .stroke(Color.planIODarkBlue, lineWidth: 1)
                    }
            }
            .padding(10)
            .padding(.leading, 6)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 6))
            .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
        }
    }
}

#Preview {
    TodayTaskListView()
}
