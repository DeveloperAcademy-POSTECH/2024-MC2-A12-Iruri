//
//  PlanView.swift
//  PlanIO
//
//  Created by Anjin on 5/17/24.
//

import SwiftUI

enum ScreenSelection: String, CaseIterable, Identifiable {
    case month = "월간"
    case week = "주간"
    
    var id: String { self.rawValue }
}

struct PlanView: View {
    @State var draggingTarget: Task?
    @State var draggingTargetDate: Date = Date(year: 0, month: 0, day: 0)
    @State private var selectedScreen: ScreenSelection? = .month
    
    // 주간 캘린더의 현재 페이지 위치
    @State var savedWeekIdx: Int = 0
    
    var body: some View {
        NavigationSplitView {
            VStack {
                 PlanNavigationSplitView().background(.planIOLightGray)
//                SideBarView(draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
            }
            .navigationTitle("Title")
            .navigationSplitViewColumnWidth(min: 200, ideal: 250)

        } detail: {
            ZStack {
                VStack {
                    HStack {
                        Picker("Screen Picker", selection: $selectedScreen) {
                            ForEach(ScreenSelection.allCases) { screen in
                                Text(screen.rawValue).tag(screen as ScreenSelection?)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(width: 150)
                    }
                    .padding(.top, 0)
                    
                    HStack {
                        Text("hello")
                        Spacer()
                        Text("hello")
                            .fontWeight(.black)
                    }
                    
                    selectedView
                }
            }
        }
    }
    
    @ViewBuilder
    var selectedView: some View {
        switch selectedScreen {
        case .month:
            MonthCalendarView(startDate: Date(year: 2024, month: 5, day: 12), endDate: Date(year: 2024, month: 5, day: 19), draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
                .padding(.horizontal, 20)
        case .week:
            WeekCalendarView(startDate: Date(year: 2024, month: 5, day: 12), endDate: Date(year: 2024, month: 5, day: 19), draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate, savedWeekIdx: $savedWeekIdx)
                .padding(.horizontal, 20)
        case .none:
            MonthCalendarView(startDate: Date(year: 2024, month: 5, day: 12), endDate: Date(year: 2024, month: 5, day: 19), draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
                .padding(.horizontal, 20)
        }
    }
}
