//
//  Task.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

enum TaskType {
    case concept, practice, other
    
    var title: String {
        switch self {
        case .concept: "개념"
        case .practice: "응용"
        case .other: "기타"
        }
    }
}

enum TaskStatus: CaseIterable {
    case complete, inProgress, incomplete, none
    
    var title: String {
        switch self {
        case .complete: "완료"
        case .inProgress: "진행중"
        case .incomplete: "미실천"
        case .none: "아직"
        }
    }
    
    var color: Color {
        switch self {
        case .complete: Color.planIODarkBlue
        case .inProgress: Color.planIODarkYellow
        case .incomplete: Color.red
        case .none: Color.planIODarkGray
        }
    }
}

struct Task: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var type: TaskType
    var status: TaskStatus
}

extension Task {
    static let dummy3: [Task] = [
        Task(title: "1-1-1. 자극을 전달하는 신경계", type: .concept, status: .complete),
        Task(title: "1-1-2. 신경계를 통해 일어나는 반응", type: .concept, status: .inProgress),
        Task(title: "1-1-3. 신경계를 통해 일어나는 반응을 뭘까용구링", type: .concept, status: .incomplete)
    ]
}
