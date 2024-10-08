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
    @Environment(InputData.self) private var inputData
    
    @Query var tasks: [Task]
    
    @State var draggingTarget: Task?
    @State var draggingTargetDate: Date = Date(year: 0, month: 0, day: 0)
    @State private var selectedScreen: ScreenSelection? = .month
    
    // 주간 캘린더의 현재 페이지 위치
    @State var savedWeekIdx: Int = 0
    
    var fromAchieveView: Bool = false
  
    init(fromAchieveView: Bool = false, draggingTarget: Task? = nil) {
        self.fromAchieveView = fromAchieveView
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
                SidebarView(fromAchieveView: fromAchieveView, draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
                    .background(.planIOLightGray)
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
                    
                    HStack {
                        HStack {
                            Text("3학년 1학기")
                                .foregroundStyle(Color.planIODarkGray)
                            
                            Text("기말고사")
                                .foregroundStyle(Color.planIODarkYellow)
                        }
                        .font(.title2).fontWeight(.heavy)
                        
                        Spacer()
                        
                        if fromAchieveView == false {
                            Button {
                                NavigationUtil.popToRootView()
                            } label: {
                                HStack {
                                    Text("계획 완료")
                                        .fontWeight(.black)
                                    
                                    Image(systemName: "chevron.right")
                                        .resizable()
                                        .frame(width: 10, height: 18)
                                        .foregroundStyle(tasks.isEmpty ? Color.planIODarkYellow : Color.planIOSemiLightGray)
                                }
                                .foregroundStyle(tasks.isEmpty ? Color.planIODarkYellow : Color.planIOSemiLightGray)
                            }
                            .disabled(tasks.isEmpty == false)
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    selectedView
                        .padding(.horizontal, 20)
                }
            }
        }
    }
    
    @ViewBuilder
    var selectedView: some View {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        let endDateComponents = Calendar.current.dateComponents([.year, .month, .day],
                                                                from: inputData.scienceTestDate ?? Date())
        
        if let year = components.year, let month = components.month, let day = components.day, let endYear = endDateComponents.year, let endMonth = endDateComponents.month, let endDay = endDateComponents.day {
            switch selectedScreen {
            case .month:
                MonthCalendarView(fromAchieveView: fromAchieveView, startDate: Date(year: year, month: month, day: day), endDate: Date(year: endYear, month: endMonth, day: endDay), draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
                    .padding(.horizontal, 20)
            case .week:
                WeekCalendarView(fromAchieveView: fromAchieveView, startDate: Date(year: year, month: month, day: day), endDate: Date(year: endYear, month: endMonth, day: endDay), draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate, savedWeekIdx: $savedWeekIdx)
                    .padding(.horizontal, 20)
            case .none:
                MonthCalendarView(fromAchieveView: fromAchieveView, startDate: Date(year: year, month: month, day: day), endDate: Date(year: endYear, month: endMonth, day: endDay), draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
                    .padding(.horizontal, 20)
            }
        }
    }
}
