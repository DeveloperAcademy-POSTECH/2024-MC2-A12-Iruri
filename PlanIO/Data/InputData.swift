//
//  InputData.swift
//  PlanIO
//
//  Created by 신혜연 on 5/21/24.
//

import SwiftUI

@Observable
class InputData {
    // 현재 화면 step
    var selectedStep: InputStep = .schedule
    
    // 시험 날짜
    var testDates: [Date] = [Date()]
    var scienceTestDate: Date?
    
    // 시험 범위
    var scopes: [LargeTextBookChapter] = []
    
    // 교재 선택
    
    // 가능 시간
}
