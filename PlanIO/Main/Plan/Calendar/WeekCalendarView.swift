//
//  WeekCalendarView.swift
//  PlanIO
//
//  Created by Seol WooHyeok on 5/24/24.
//

import SwiftUI

struct WeekCalendarView: View {
    @State var startDate: Date
    @State var endDate: Date
    
    @Binding var draggingTarget: Task?
    @Binding var draggingTargetDate: Date
    
    @State var dayList: [String] = []
    @State var calendarDateList: [Date] = []
    @State var currentDateList: [Date] = []
    
    @State var currentWeekIdx: Int = 0
    @Binding var savedWeekIdx: Int
    
    var maxWeek: Int {
        calendarDateList.count / 7
    }
    
    var body: some View {
        VStack {
            headerView
            HStack {
                calendarHorizontalView
            }
        }
        .padding(.bottom, 20)
        .onAppear {
            var firstDayOfWeek: Int {
                getDayOfWeek(for: startDate)
            }
            
            var lastDayOfWeek: Int {
                getDayOfWeek(for: endDate)
            }
            
            for idx in 0 ..< getDaysBetween(startDate, endDate) + firstDayOfWeek {
                if idx < firstDayOfWeek - 1 {
                    calendarDateList.append(Date(year: 0, month: 0, day: 0))
                } else {
                    calendarDateList.append(startDate + TimeInterval((idx - firstDayOfWeek + 1) * 86400))
                }
            }
            
            // 나머지 빈칸을 채웁니다.
            for idx in 0 ..< 7 - lastDayOfWeek {
                calendarDateList.append(Date(year: 0, month: 0, day: 0))
            }
            
            currentDateList = Array(calendarDateList[0..<7])
            
            dayList = Self.weekdaySymbols
            
            // savedWeekIdx가 있다면 그걸 받습니다.
            currentWeekIdx = savedWeekIdx
            currentDateList = Array(calendarDateList[currentWeekIdx * 7 ..< currentWeekIdx * 7 + 7])
        }
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        toPrevWeek()
                    } label: {
                        Image(systemName: "chevron.left")
                            .bold()
                    }
                    
                    Spacer()
                    
                    Button {
                        toNextWeek()
                    } label: {
                        Image(systemName: "chevron.right")
                            .bold()
                    }
                }
                HStack {
                    // 캘린더의 요일은 월요일부터 시작입니다.
                    ForEach(dayList.indices, id: \.self) { idx in
                        HStack(spacing: 0) {
                            if currentDateList[idx] == Date(year: 0, month: 0, day: 0) {
                                Text("\(dayList[idx])")
                            } else {
                                Text(cleanDate(date: currentDateList[idx]))
                                Text("(\(dayList[idx]))")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .font(.body)
                        .bold()
                        .foregroundStyle(.black)
                    }
                }
            }
            .padding(.bottom, 10)
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarHorizontalView: some View {
        var firstDayOfWeek: Int {
            getDayOfWeek(for: startDate)
        }
        
        var lastDayOfWeek: Int {
            getDayOfWeek(for: endDate)
        }
        
        return HStack(spacing: 0) {
            // indices 쓰기 싫었는데, Date 000 id 값이 겹친다고 통 난리를 쳐서 사용합니다..
            ForEach(currentDateList.indices, id: \.self) { idx in
                if currentDateList[idx] == Date(year: 0, month: 0, day: 0) {
                    Rectangle()
                        .foregroundStyle(.white)
                        .border(.gray, width: 0.5)
                } else {
                    CellView(date: currentDateList[idx], draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate, isMonthCalendar: false)
                        .border(.gray, width: 0.5)
                }
            }
        }
        .border(Color.black.opacity(0.3), width: 1)
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
    
    // formatted date 반환
    private func cleanDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd일"
        let dateString = dateFormatter.string(from: date)
        
        return dateString
    }
    
    private func toNextWeek() {
        if !(currentWeekIdx + 1 == maxWeek) {
            currentWeekIdx += 1
            savedWeekIdx = currentWeekIdx
            currentDateList = Array(calendarDateList[currentWeekIdx * 7 ..< currentWeekIdx * 7 + 7])
        }
    }
    
    private func toPrevWeek() {
        if !(currentWeekIdx - 1 < 0) {
            currentWeekIdx -= 1
            savedWeekIdx = currentWeekIdx
            currentDateList = Array(calendarDateList[currentWeekIdx * 7 ..< currentWeekIdx * 7 + 7])
        }
    }
}

// MARK: - Static 프로퍼티
extension WeekCalendarView {
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
