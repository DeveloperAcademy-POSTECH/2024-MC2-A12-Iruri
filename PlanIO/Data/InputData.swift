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
    var availableTimePerDay: [Int] = [] /// [월 ~ 일] ex: [0, 3, 4, 0, 0, 7, 5]
    
    func resetData() {
        self.selectedStep = .schedule
        self.testDates = [Date()]
        self.scienceTestDate = nil
        self.scopes = []
        self.availableTimePerDay = []
    }
}
