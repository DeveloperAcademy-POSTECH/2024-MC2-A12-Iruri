//
//  StatusSelectPopUp.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct StatusSelectPopUp: View {
    var selectAction: (TaskStatus) -> Void
    
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            
            HStack {
                ForEach(TaskStatus.allCases, id: \.self) { status in
                    Button {
                        selectAction(status)
                    } label: {
                        Text(status.title)
                            .foregroundStyle(status.color)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 8)
                    }
                    if status != .none { Divider() }
                }
            }
            .padding(.horizontal, 12)
            .background(Color.planIOLightGray)
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .frame(height: 40)
        .offset(y: -40)
    }
}
