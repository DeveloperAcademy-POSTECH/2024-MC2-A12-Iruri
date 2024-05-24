//
//  MonthCalendar.swift
//  PlanIO
//
//  Created by Seol WooHyeok on 5/18/24.
//

import SwiftUI

struct MonthCalendarView: View {
//    @Environment(\.modelContext) var modelContext
    
    @State var startDate: Date
    @State var endDate: Date
    
    @Binding var draggingTarget: Task?
    @Binding var draggingTargetDate: Date
    
    var body: some View {
        VStack(spacing: 0) {
//            Button {
//                TaskManager.makeTask(modelContext: modelContext, scopes: TextBook.contents)
//            } label: {
//                Text("task 추가")
//            }
            headerView
            calendarGridView
        }
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
                // 캘린더의 요일은 월요일부터 시작입니다.
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .font(.subheadline).fontWeight(.semibold)
                        .foregroundStyle((symbol == "토" || symbol == "일") ? .planIODarkYellow : .black)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.bottom, 2)
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        var firstDayOfWeek: Int {
            getDayOfWeek(for: startDate)
        }
        
        var lastDayOfWeek: Int {
            getDayOfWeek(for: endDate)
        }
        
        return VStack {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 7), spacing: 0) {
                    //  만약 기간이 10일이고, 시작일이 수요일이면 firstDayOfWeek가 3이 되면서 ForEach가 13번 동작합니다.
                    ForEach(0 ..< getDaysBetween(startDate, endDate) + firstDayOfWeek, id: \.self) { index in
                        
                        // index는 0 부터 시작하고, firstDayOfWeek가 3일 경우 (수요일) 월, 화를 빈칸으로 채워야 합니다.
                        // 그럴 경우 2번 반복하면 되기 때문에 firstDayOfWeek - 1 입니다.
                        if index < firstDayOfWeek - 1 {
                            Rectangle()
                                .frame(maxHeight: 160)
                                .foregroundColor(isWeekDay(index: index) ? .planIOFilledYellow : .white)
                                .overlay {
                                    Rectangle()
                                        .inset(by: 0.5)
                                        .stroke(Color.planIOSemiLightGray, lineWidth: 0.3)
                                }
                        } else {
                            VStack(spacing: 0) {
                                // firstDayOfWeek가 3일때 (수요일) 월, 화를 채우고 온 index는 2입니다.
                                // 해당일부터 종료일까지 날짜를 채워야 하기 때문에 +1 하여 날짜를 맞추었습니다.
                                CellView(date: startDate + TimeInterval((index - firstDayOfWeek + 1) * 86400), draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
                            }
                            .background(isWeekDay(index: index) ? .planIOFilledYellow : .white)
                            .frame(maxWidth: .infinity, minHeight: 160, maxHeight: 160, alignment: .center)
                            .overlay {
                                Rectangle()
                                    .inset(by: 0.5)
                                    .stroke(Color.planIOSemiLightGray, lineWidth: 0.3)
                            }
                        }
                    }
                    // 나머지 빈칸을 채웁니다. 종료일이 3(수요일) 이면 나머지 4일을 채워야 하기 때문에 7 - lastDayOfWeek
                    ForEach(0 ..< 7 - lastDayOfWeek, id: \.self) { index in
                        Rectangle()
                            .frame(maxHeight: 160)
                            .foregroundColor(index == 0 || index == 1 ? .planIOFilledYellow : .white)
                            .overlay {
                                Rectangle()
                                    .inset(by: 0.5)
                                    .stroke(Color.planIOSemiLightGray, lineWidth: 0.3)
                            }
                    }
                }
                .overlay {
                    Rectangle()
                        .inset(by: 0.5)
                        .stroke(Color.planIOSemiLightGray, lineWidth: 0.4)
                }
            }
            .scrollIndicators(.hidden)
        }
    }
    
    private func isWeekDay(index: Int) -> Bool {
        let weekday = index + 1
        return (weekday + 1).isMultiple(of: 7) || weekday.isMultiple(of: 7)
    }
    
    // date 간의 차이를 구합니다.
    private func getDaysBetween(_ start: Date, _ end: Date) -> Int {
        let calendar = Calendar.current
        
        // day를 컴포넌트로 설정하여 일 차이를 계산합니다.
        let components = calendar.dateComponents([.day], from: start, to: end)
        
        // 일(day) 컴포넌트의 값을 반환합니다.
        // components.day는 옵셔널이므로, 안전하게 값을 추출합니다.
        return components.day ?? -1
    }
    
    /// 특정 날짜가 무슨 요일인지 정수로 반환하는 함수
    private func getDayOfWeek(for date: Date) -> Int {
        let calendar = Calendar.current

        // .weekday는 1(일요일)부터 7(토요일)까지의 값을 가짐
        let result = calendar.component(.weekday, from: date)
        
        // 월요일이 시작일이기 때문에 일요일을 가장 뒤로 보냄
        if result == 1 {
            return 7
        } else {
            return result - 1
        }
    }
}

// MARK: - Static 프로퍼티
extension MonthCalendarView {
    static let weekdaySymbols: [String] = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ko-KR")
        
        calendar.firstWeekday = 2 // 1 = Sunday, 2 = Monday, ...
        
        // 일, 월, 화, 수, 목, 금, 토 형식의 배열을 불러옵니다.
        let symbols = calendar.veryShortWeekdaySymbols
        
        // 월요일이 첫날이기 때문에 일요일을 맨 뒤로 보냅니다.
        let reorderedSymbols = Array(symbols[calendar.firstWeekday - 1..<symbols.count] + symbols[0..<calendar.firstWeekday - 1])
        
        return reorderedSymbols
    }()
}
