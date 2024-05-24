//
//  InputStep.swift
//  PlanIO
//
//  Created by 신혜연 on 5/20/24.
//

import SwiftUI

enum InputStep: Int, CaseIterable {
    case schedule = 0
    case scope = 1
    case book = 2
    case time = 3
    
    var title: String {
        switch self {
        case .schedule: "시험 일정"
        case .scope: "시험 범위"
        case .book: "교재 선택"
        case .time: "시간 확인"
        }
    }
    
    var imageName: String {
        switch self {
        case .schedule: "calendar"
        case .scope: "magazine.fill"
        case .book: "list.bullet.clipboard"
        case .time: "alarm.fill"
        }
    }
    var speechBubbleText: String {
        switch self {
        case .schedule:
            "가현아! 시험 보는 날짜를 모두 알려줄래?\n그리고 과학 시험 보는 날만 옆에 체크해줘!"
        case .scope:
            "이번에는 시험 범위를 알아보자!\n시험 범위에 해당하는 단원을 선택해줘!"
        case .book:
            "교과서랑 문제집은\n어떤 교재로 공부할 예정이야?"
        case .time:
            "이제 마지막이야 🎉\n과학 공부를 할 수 있는 시간을 알려줘!"
        }
    }
    
    func previousStep() -> InputStep? {
            switch self {
            case .schedule:
                return nil // 첫 번째 단계이므로 이전 단계 없음
            case .scope:
                return .schedule
            case .book:
                return .scope
            case .time:
                return .book
            }
        }
    
    func nextStep() -> InputStep? {
        switch self {
        case .schedule:
            return .scope
        case .scope:
            return .book
        case .book:
            return .time
        case .time:
            return nil // 마지막 단계이므로 nil 반환
        }
    }
}
