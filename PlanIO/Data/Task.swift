//
//  Task.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftData
import SwiftUI

enum TaskType: String, Codable {
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

/*
 @Transient var type: SomeType {
         get { SomeType(rawValue: _type)! }
         set { _type = newValue.rawValue }
     }
     
     @Attribute var _type: SomeType.RawValue
 */

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

struct TaskManager {
    static let dummy3: [Task] = [
        Task(title: "1-1-1. 자극을 전달하는 신경계", type: .concept, status: .complete),
        Task(title: "1-1-2. 신경계를 통해 일어나는 반응", type: .concept, status: .inProgress),
        Task(title: "1-1-3. 신경계를 통해 일어나는 반응을 뭘까용구링", type: .concept, status: .incomplete)
    ]
    
    static let dummy1 = Task(title: "1-1-1. 자극을 전달하는 신경계", type: .concept, status: .complete)
    static let dummy2 = Task(title: "1-1-2. 신경계를 통해 일어나는 반응", type: .concept, status: .inProgress)
    
    static func makeTask(scopes: [LargeTextBookChapter]) {
        for large in scopes {
            for mid in large.midChapters {
                for small in mid.smallChapters {
                    let task = Task(title: "\(large)-\(mid)-\(small). \(small.title)", type: .concept, status: .none)
                    print(task)
                }
            }
        }
    }
}
