//
//  MonthCalendar.swift
//  PlanIO
//
//  Created by Seol WooHyeok on 5/18/24.
//

// 1. 캘린더를 붙여서 그리는 방법
// 2. 월요일부터 캘린더를 시작하는 법
// 3. 시작날짜와 끝날짜를 정하는 방법

import SwiftUI

struct CalenderView: View {
    @State var month: Date
    @State var offset: CGSize = CGSize()
    @State var clickedDates: Set<Date> = []
    
    var body: some View {
        VStack {
            headerView
            calendarGridView
        }
    }
    
    // MARK: - 헤더 뷰
    private var headerView: some View {
        VStack {
            HStack {
                // 요일을 분배함
                // weekdaySymbols의 시작 일자를 월요일로 바꿔야 할 이유가 있음.
                ForEach(Self.weekdaySymbols, id: \.self) { symbol in
                    Text(symbol)
                        .frame(maxWidth: .infinity)
                        .font(.caption2)
                        .bold()
                        .foregroundStyle(.black)
                }
            }
            .padding(.bottom, 5)
        }
    }
    
    // MARK: - 날짜 그리드 뷰
    private var calendarGridView: some View {
        let daysInMonth: Int = numberOfDays(in: month)
        let firstWeekday: Int = firstWeekdayOfMonth(in: month) - 2
        
        return VStack {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(spacing: 0), count: 7), spacing: 0) {
                    ForEach(0 ..< daysInMonth + firstWeekday, id: \.self) { index in
                        if index < firstWeekday {
                            Rectangle()
                                .frame(maxHeight: 150)
                                .border(.gray, width: 0.5)
                                .foregroundColor(.white)
                        } else {
                            let date = getDate(for: index - firstWeekday)
                            let day = index - firstWeekday + 1
                            let clicked = clickedDates.contains(date)
                            
                            VStack {
                                CellView(day: day, clicked: clicked)
                                    .onTapGesture {
                                        if clicked {
                                            clickedDates.remove(date)
                                        } else {
                                            clickedDates.insert(date)
                                        }
                                    }
                            }
                            .frame(maxWidth: .infinity, minHeight: 150, maxHeight: 150, alignment: .center)
                            .border(.gray, width: 0.5)
                        }
                    }
                    // 나머지 빈칸을 채웁니다. border 문제가 귀찮기 때문
                    ForEach(0 ..< 7 - (daysInMonth + firstWeekday) % 7, id: \.self) { _ in
                        Rectangle()
                            .frame(maxHeight: 150)
                            .border(.gray, width: 0.5)
                            .foregroundColor(.white)
                    }
                }
                .border(Color.black.opacity(0.3), width: 1)
            }
            .scrollIndicators(.hidden)
        }
    }
}

// MARK: - 일자 셀 뷰
private struct CellView: View {
    var day: Int
    var clicked: Bool = false
    
    init(day: Int, clicked: Bool) {
        self.day = day
        self.clicked = clicked
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("\(day)")
                    .foregroundStyle(.black)
                    .padding(10)
            }
            
            Spacer()
        }
    }
}

// MARK: - 내부 메서드
private extension CalenderView {
    /// 특정 해당 날짜
    private func getDate(for day: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: day, to: startOfMonth())!
    }
    
    /// 해당 월의 시작 날짜
    func startOfMonth() -> Date {
        let components = Calendar.current.dateComponents([.year, .month], from: month)
        return Calendar.current.date(from: components)!
    }
    
    /// 해당 월에 존재하는 일자 수
    func numberOfDays(in date: Date) -> Int {
        return Calendar.current.range(of: .day, in: .month, for: date)?.count ?? 0
    }
    
    /// 해당 월의 첫 날짜가 갖는 해당 주의 몇번째 요일
    func firstWeekdayOfMonth(in date: Date) -> Int {
        let components = Calendar.current.dateComponents([.year, .month], from: date)
        let firstDayOfMonth = Calendar.current.date(from: components)!
        
        return Calendar.current.component(.weekday, from: firstDayOfMonth)
    }
    
    /// 월 변경
    func changeMonth(by value: Int) {
        let calendar = Calendar.current
        if let newMonth = calendar.date(byAdding: .month, value: value, to: month) {
            self.month = newMonth
        }
    }
}

// MARK: - Static 프로퍼티
extension CalenderView {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }()
    
    static let weekdaySymbols: [String] = {
        let calendar = Calendar(identifier: .gregorian)
        var localizedCalendar = calendar
        localizedCalendar.locale = Locale(identifier: "ko-KR")
        
        localizedCalendar.firstWeekday = 2 // 1 = Sunday, 2 = Monday, ...
        
        // Get the very short weekday symbols in the correct order
        let symbols = localizedCalendar.veryShortWeekdaySymbols
        
        // Reorder the symbols based on the firstWeekday
        let reorderedSymbols = Array(symbols[localizedCalendar.firstWeekday - 1..<symbols.count] + symbols[0..<localizedCalendar.firstWeekday - 1])
        
        return reorderedSymbols
    }()
}

#Preview {
    PlanView()
}
