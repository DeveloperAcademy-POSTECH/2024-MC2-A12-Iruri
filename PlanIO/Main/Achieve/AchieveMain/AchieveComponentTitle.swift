//
//  AchieveComponentTitle.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct AchieveComponentTitle: ViewModifier {
    let title: String
    
    func body(content: Content) -> some View {
        VStack(spacing: 16) {
            HStack {
                Text(title)
                    .font(.title).bold()
                    .padding(.leading, 6)
                
                Spacer()
            }
            .frame(height: 40)
            
            content
        }
    }
}

extension View {
    func achieveComponentTitle(_ title: String) -> some View {
        modifier(AchieveComponentTitle(title: title))
    }
}
