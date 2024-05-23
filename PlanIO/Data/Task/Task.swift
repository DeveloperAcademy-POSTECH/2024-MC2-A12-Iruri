//
//  Task.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftData
import SwiftUI

@Model
class Task: Identifiable, Equatable {
    let id = UUID()
    var title: String
    var type: TaskType
    var status: TaskStatus
    
    init(title: String, type: TaskType, status: TaskStatus) {
        self.title = title
        self.type = type
        self.status = status
    }
}

enum TaskType: String, Codable, CaseIterable {
    case concept = "개념"
    case practice = "응용"
    case other = "기타"
    
    var title: String {
        self.rawValue
    }
}

enum TaskStatus: String, Codable, CaseIterable {
    case complete = "완료"
    case inProgress = "진행중"
    case incomplete = "미실천"
    case none = "아직"
    
    var title: String {
        self.rawValue
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
