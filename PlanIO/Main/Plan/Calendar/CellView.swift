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
    @Environment(\.modelContext) private var modelContext
    
    var date: Date
    
    @Query var tasks: [Task]
    
    @Binding var draggingTarget: Task?
    @Binding var draggingTargetDate: Date
    
    init(date: Date, draggingTarget: Binding<Task?>, draggingTargetDate: Binding<Date>) {
        self.date = date
        self._draggingTarget = draggingTarget
        self._draggingTargetDate = draggingTargetDate

        let predicate = #Predicate<Task> {
            $0.date == date
        }
        
        _tasks = Query(filter: predicate, sort: \.title)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                ZStack {
                    if date.isToday() {
                        Circle()
                            .foregroundStyle(Color.planIODarkYellow)
                            .frame(width: 25, height: 25)
                    }
                    
                    Text(cleanDate(date: date))
                        .font(.footnote).bold()
                        .foregroundStyle(dateColor())
                }
                .padding(.top, 10)
                .padding(.trailing, 14)
            }
            
            ForEach(tasks) { task in
                Text(task.title)
                    .foregroundStyle(.black)
                    .overlay(Rectangle().opacity(0.1))
                    .draggable(task.title) {
                        Image(systemName: "tree.fill")
                            .onAppear {
                                draggingTarget = task
                                draggingTargetDate = date
                            }
                    }
            }
            Spacer()
        }
        .frame(height: 150)
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
    }
    
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
}

extension Date {
    func isToday() -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(self)
    }
}
