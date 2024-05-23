//
//  PlanView.swift
//  PlanIO
//
//  Created by Anjin on 5/17/24.
//

import SwiftUI

struct PlanView: View {
    @State var draggingTarget: Task?
    @State var draggingTargetDate: Date = Date(year: 0, month: 0, day: 0)
    
    var body: some View {
        NavigationSplitView {
            VStack {
                SideBarView(draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
            }
            .navigationTitle("Title")
        } detail: {
            ZStack {
                VStack {
                    HStack {
                        Text("hello")
                        Spacer()
                        Text("hello")
                            .fontWeight(.black)
                    }
                    
                    Spacer()
                    
                    MonthCalendarView(startDate: Date(year: 2024, month: 5, day: 12), endDate: Date(year: 2024, month: 6, day: 15), draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
                        .padding(.horizontal, 20)
                }
            }
        }
    }
}
