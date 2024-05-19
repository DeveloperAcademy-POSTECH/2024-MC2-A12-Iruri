//
//  PlanView.swift
//  PlanIO
//
//  Created by Anjin on 5/17/24.
//

import SwiftUI

struct PlanView: View {
    @State private var date = Date()
    
    var body: some View {
        NavigationSplitView {
            VStack {
                List {
                    Text("first")
                    Text("second")
                    Text("third")
                    Text("fourth")
                }
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
                    
                    CalenderView(month: setMonth(month: 5))
                        .padding(.horizontal, 20)
                }
            }
        }
    }
    
    private func setMonth(month: Int) -> Date {
        let calendar = Calendar.current
        let currentDate = Date()
        
        var components = calendar.dateComponents([.year, .day], from: currentDate)
        components.month = month
        
        return calendar.date(from: components) ?? currentDate
    }
    
    private func calculateDaysInMonth(year: Int, month: Int) -> Int {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        
        let calendar = Calendar.current
        
        guard let date = calendar.date(from: dateComponents),
              let range = calendar.range(of: .day, in: .month, for: date) else {
            return 0 // Invalid date or range
        }
        
        return range.count
    }
}

#Preview {
    PlanView()
}
