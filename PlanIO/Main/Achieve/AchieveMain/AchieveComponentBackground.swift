//
//  AchieveComponentBackground.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct AchieveComponentBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(20)
            .background(.white)
            .cornerRadius(10)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 2)
    }
}

extension View {
    func achieveComponentBackground() -> some View {
        modifier(AchieveComponentBackground())
    }
}
