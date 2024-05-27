//
//  CellView.swift
//  PlanIO
//
//  Created by Seol WooHyeok on 5/22/24.
//

import SwiftData
import SwiftUI

// MARK: - 일자 셀 뷰
struct CellView: View {
    let fromAchieveView: Bool
    
    // 현실의 날짜보다 이전인가? && 어디 뷰에서 넘어왔는가?
    var isEditable: Bool
    
    @Environment(\.modelContext) private var modelContext
    var date: Date
    @Query var tasks: [Task]
    @State private var showedTaskCount: Int = 0
    
    @Binding var draggingTarget: Task?
    @Binding var draggingTargetDate: Date
    
    var isMonthCalendar: Bool = true
    
    init(fromAchieveView: Bool, date: Date, draggingTarget: Binding<Task?>, draggingTargetDate: Binding<Date>, isMonthCalendar: Bool = true) {
        self.date = date
        self._draggingTarget = draggingTarget
        self._draggingTargetDate = draggingTargetDate
        self.isMonthCalendar = isMonthCalendar
        
        self.fromAchieveView = fromAchieveView

        let predicate = #Predicate<Task> {
            $0.date == date
        }
        
        _tasks = Query(filter: predicate, sort: \.title)
        
        // isEditable 정해주는 과정
        
        // 들어온 날짜의 컴포넌트
        let inputDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: date)
        
        let currentDateComponent =
            Calendar.current.dateComponents([.year, .month, .day], from: Date())
        
        var inputDate = Date()
        var currentDate = Date()
        
        if let inputYear = inputDateComponent.year, let inputMonth = inputDateComponent.month, let inputDay = inputDateComponent.day, let curYear = currentDateComponent.year, let curMonth = currentDateComponent.month, let curDay = currentDateComponent.day {
            
            currentDate = Date(year: curYear, month: curMonth, day: curDay)
            
            inputDate = Date(year: inputYear, month: inputMonth, day: inputDay)
        }
        
        if fromAchieveView == true && currentDate > inputDate {
            isEditable = false
        } else {
            self.isEditable = true
        }
    }
    
    var body: some View {
        if isEditable == true {
            VStack {
                HStack {
                    Spacer()
                    
                    // 날짜
                    ZStack {
                        if date.isToday() {
                            Circle()
                                .foregroundStyle(Color.planIODarkYellow)
                        }
                        
                        Text(cleanDate(date: date))
                            .font(.footnote).bold()
                            .foregroundStyle(dateColor())
                    }
                    .frame(width: 25, height: 25)
                    .padding(.top, 10)
                    .padding(.trailing, 14)
                }
                
                // Task
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(isMonthCalendar ? Array(tasks.prefix(4)) : tasks) { task in
                        taskRow(task)
                            .draggable(task.title) {
                                taskRow(task)
                                    .onAppear {
                                        draggingTarget = task
                                        draggingTargetDate = date
                                    }
                            }
                    }
                }
                .padding(.horizontal, 6)
                
                if isMonthCalendar && tasks.count > 4 {
                    Text("+ \(tasks.count - 4)")
                        .font(.system(size: 10)).bold()
                        .foregroundStyle(Color.planIODarkGray)
                        .padding(.horizontal, 6)
                }
                
                Spacer(minLength: 0)
            }
            .background(isWeekend(date: date) ? .planIOFilledYellow : .white)
            .dropDestination(for: String.self) { _, _ in
                if draggingTargetDate == Date(year: 0, month: 0, day: 0) {
                    // task -> calendar 로의 정보 이동
                    if let target = draggingTarget {
                        let newTask = Task(title: target.title, type: target.type, status: target.status, date: date)
                        modelContext.insert(newTask)
                    }
                    
                    // 끌려온 녀석은 삭제됩니다.
                    if let target = draggingTarget {
                        modelContext.delete(target)
                    }
                } else {
                    // calendar -> calendar 로의 정보 이동
                    if let target = draggingTarget {
                        let newTask = Task(title: target.title, type: target.type, status: target.status, date: date)
                        modelContext.insert(newTask)
                    }
                    
                    if let target = draggingTarget {
                        modelContext.delete(target)
                    }
                }
                
                return false
            }
        } else {
            VStack {
                HStack {
                    Spacer()
                    
                    // 날짜
                    ZStack {
                        if date.isToday() {
                            Circle()
                                .foregroundStyle(Color.planIODarkYellow)
                        }
                        
                        Text(cleanDate(date: date))
                            .font(.footnote).bold()
                            .foregroundStyle(dateColor())
                    }
                    .frame(width: 25, height: 25)
                    .padding(.top, 10)
                    .padding(.trailing, 14)
                }
                
                // Task
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(isMonthCalendar ? Array(tasks.prefix(4)) : tasks) { task in
                        if isEditable == true {
                            taskRow(task)
                                .draggable(task.title) {
                                    taskRow(task)
                                        .onAppear {
                                            draggingTarget = task
                                            draggingTargetDate = date
                                        }
                                }
                        } else {
                            taskRow(task)
                        }
                    }
                }
                .padding(.horizontal, 6)
                
                if isMonthCalendar && tasks.count > 4 {
                    Text("+ \(tasks.count - 4)")
                        .font(.system(size: 10)).bold()
                        .foregroundStyle(Color.planIODarkGray)
                        .padding(.horizontal, 6)
                }
                
                Spacer(minLength: 0)
            }
            .background(isWeekend(date: date) ? .planIOFilledYellow : .white)
        }
    }
    
    struct DroppableContainer<Content: View>: View {
        let content: () -> Content
        
        init(@ViewBuilder content: @escaping () -> Content) {
            self.content = content
        }
        
        var body: some View {
            VStack {
                Text("Header")
                    .font(.largeTitle)
                    .padding()
                
                content()
                
                Text("Footer")
                    .font(.footnote)
                    .padding()
            }
            .border(Color.gray, width: 1)
            .padding()
        }
    }
    
    @ViewBuilder
    private func taskRow(_ task: Task) -> some View {
        HStack {
            Text("[\(task.type.rawValue)] \(task.title)")
                .font(.system(size: 10)).bold(task.status != .none)
                .lineLimit(isMonthCalendar ? 1 : 10000)
                .foregroundStyle(task.status == .none ? .black : .planIOSemiLightGray)
            
            Spacer(minLength: 0)
        }
        .padding(4)
        .background(cellBackground(task: task))
        .clipShape(RoundedRectangle(cornerRadius: 2))
        .shadow(color: .black.opacity(task.status == .none ? 0.1 : 0.0), radius: 2, x: 0, y: 0)
    }
    
    // Task의 상태에 따른 cell의 배경색
    private func cellBackground(task: Task) -> Color {
        switch task.status {
        case .complete: Color.planIOLightBlue
        case .inProgress: Color.planIOLightYellow
        case .incomplete: Color.planIOLightRed
        case .none: Color.white
        }
    }
    
    // 날짜의 글자 색상
    private func dateColor() -> Color {
        let calendar = Calendar.current
        if calendar.isDateInToday(self.date) {
            return Color.white
        } else if calendar.isDateInWeekend(self.date) {
            return Color.planIODarkYellow
        } else {
            return Color.planIODarkGray
        }
    }
    
    private func queryTasks(date: Date) -> [Task] {
        let sort = [SortDescriptor<Task>(\.title, order: .forward)]
        let todaysTask = FetchDescriptor<Task>(predicate: #Predicate { $0.date == date }, sortBy: sort)
        
        // 데이터 쿼리
        do {
            let tasks = try modelContext.fetch(todaysTask)
            
            // 비어있지 않다면 tasks 반환
            if !tasks.isEmpty {
                return tasks
            }
        } catch {
            print("오늘의 plan을 가져오는 데 실패함!")
        }
        
        return []
    }
    
    private func cleanDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    private func isWeekend(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInWeekend(date)
    }
}
