//
//  RemainTimeView.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct RemainTimeView: View {
    private let testDay: Date = Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 17))!
    @State private var now: Date = Date()
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("남은 기간")
                .font(.callout).bold()
            
            // FIXME: 좀 더 잘 묶을 수 있지 않을까..?
            HStack(alignment: .top, spacing: 6) {
                let difference = getDifference()
                
                timeWithDescriptionBox(difference.days, description: "일")
                colonView
                timeWithDescriptionBox(difference.hours, description: "시간")
                colonView
                timeWithDescriptionBox(difference.minutes, description: "분")
            }
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                self.now = Date()
            }
        }
    }
    
    @ViewBuilder
    private func timeWithDescriptionBox(_ time: String, description: String) -> some View {
        VStack {
            HStack(spacing: 6) {
                ForEach(Array(time), id: \.self) { character in
                    HStack {
                        Spacer()
                        Text(String(character))
                        Spacer()
                    }
                    .font(.callout).bold()
                    .frame(height: 38)
                    .background(Color.planIOLightYellow)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                }
            }
            
            Text(description)
                .font(.caption).bold()
                .foregroundStyle(Color.planIOSemiLightGray)
        }
    }
    
    // : 을 나타내는 View
    private var colonView: some View {
        Text(":")
            .font(.callout).bold()
            .padding(.top, 10)
    }
    
    // 시험 날짜와 지금 시간과의 차이
    private func getDifference() -> (days: String, hours: String, minutes: String) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute], from: now, to: testDay)
        
        if let days = components.day, let hours = components.hour, let minutes = components.minute {
            let dayString = String(format: "%02d", days)
            let hourString = String(format: "%02d", hours)
            let minuteString = String(format: "%02d", minutes)
            
            return (dayString, hourString, minuteString)
        } else {
            return ("99", "99", "99")
        }
    }
}

#Preview {
    AchieveView()
}
