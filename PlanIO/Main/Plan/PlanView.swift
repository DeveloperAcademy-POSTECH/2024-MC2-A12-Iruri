//
//  PlanView.swift
//  PlanIO
//
//  Created by Anjin on 5/17/24.
//

import SwiftData
import SwiftUI

enum ScreenSelection: String, CaseIterable, Identifiable {
    case month = "월간"
    case week = "주간"
    
    var id: String { self.rawValue }
}

struct PlanView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query var tasks: [Task]
    
    @State var draggingTarget: Task?
    @State var draggingTargetDate: Date = Date(year: 0, month: 0, day: 0)
    @State private var selectedScreen: ScreenSelection? = .month
    
    // 주간 캘린더의 현재 페이지 위치
    @State var savedWeekIdx: Int = 0
    
    init(draggingTarget: Task? = nil) {
        self.draggingTarget = draggingTarget
        
        let dateDefault = Date(year: 0, month: 0, day: 0)
        
        let predicate = #Predicate<Task> {
            $0.date == dateDefault
        }
        
        _tasks = Query(filter: predicate, sort: \.title)
    }
    
    var body: some View {
        NavigationSplitView {
            VStack {
                 PlanNavigationSplitView(draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
                    .background(.planIOLightGray)
                
//                SideBarView(draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
            }
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
                    
                    NavigationLink {
                        EmptyView()
                    } label: {
                        HStack {
                            Spacer()
                            Text("다음 단계")
                                .font(.title3)
                                .fontWeight(.black)
                            Image(systemName: "chevron.right")
                                .font(.title2)
                                .fontWeight(.heavy)
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 10)
                    }
                    .disabled(!tasks.isEmpty)
                    
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
