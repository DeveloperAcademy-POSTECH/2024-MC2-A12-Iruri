//
//  TaskManager.swift
//  PlanIO
//
//  Created by Anjin on 5/23/24.
//

import SwiftData
import SwiftUI

struct TaskManager {
    static func makeTask(modelContext: ModelContext, scopes: [LargeTextBookChapter]) {
        let workbooks: [LargeWorkBookChapter] = WorkBook.contents
        
        for large in scopes {
            for mid in large.midChapters {
                for small in mid.smallChapters {
                    // 개념 Task 추가
                    let conceptTask = Task(title: "\(large.chapter)-\(mid.chapter)-\(small.chapter). \(small.title)", type: .concept, status: .none)
                    modelContext.insert(conceptTask)
                }
                
                // 응용 Task 추가
                let largeWorkBook = workbooks[large.chapter - 1]
                let midWorkBook = largeWorkBook.midChapters[mid.chapter - 1]
                
                let practiceTask = Task(title: "오투 \(largeWorkBook.chapter)-\(midWorkBook.chapter). \(midWorkBook.title)", type: .practice, status: .none)
                modelContext.insert(practiceTask)
            }
        }
    }
}

extension TaskManager {
    static let dummy3: [Task] = [
        Task(title: "1-1-1.concept 자극을 전달하는 신경계", type: .concept, status: .complete),
        Task(title: "1-1-2.concept 신경계를 통해 일어나는 반응", type: .concept, status: .inProgress),
        Task(title: "1-1-3.concept 신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반응을반응을 뭘까용구링", type: .concept, status: .incomplete),
        Task(title: "1-2-1.concept 자극을 전달하는 신경계", type: .concept, status: .complete),
        Task(title: "1-2-2.practice 신경계를 통해 일어나는 반응", type: .practice, status: .inProgress),
        Task(title: "1-2-3.concept 신경계를 통해 일어나는 반응을 뭘까용구링", type: .concept, status: .incomplete),
        Task(title: "1-3-1.other 자극을 전달하는 신경계", type: .other, status: .complete),
        Task(title: "1-3-2.concept 신경계를 통해 일어나는 반응", type: .concept, status: .inProgress),
        Task(title: "1-1-1.concept 자극을 전달하는 신경계", type: .concept, status: .complete),
        Task(title: "1-1-2.concept 신경계를 통해 일어나는 반응", type: .concept, status: .inProgress),
        Task(title: "1-1-3.concept 신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반응을신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반응을 뭘까용구링", type: .concept, status: .incomplete),
        Task(title: "1-2-1.concept 자극을 전달하는 신경계", type: .concept, status: .complete),
        Task(title: "1-2-2.practice 신경계를 통해 일어나는 반응", type: .practice, status: .inProgress),
        Task(title: "1-2-3.concept 신경계를 통해 일어나는 반응을 뭘까용구링", type: .concept, status: .incomplete),
        Task(title: "1-3-1.other 자극을 전달하는 신경계", type: .other, status: .complete),
        Task(title: "1-3-2.concept 신경계를 통해 일어나는 반응", type: .concept, status: .inProgress),
        Task(title: "1-1-1.concept 자극을 전달하는 신경계", type: .concept, status: .complete),
        Task(title: "1-1-2.concept 신경계를 통해 일어나는 반응", type: .concept, status: .inProgress),
        Task(title: "1-1-3.concept 신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반응을신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반응을 뭘까용구링신경계를 통해 일어나는 반응을응을 뭘까용구링", type: .concept, status: .incomplete),
        Task(title: "1-2-1.concept 자극을 전달하는 신경계", type: .concept, status: .complete),
        Task(title: "1-2-2.practice 신경계를 통해 일어나는 반응", type: .practice, status: .inProgress),
        Task(title: "1-2-3.concept 신경계를 통해 일어나는 반응을 뭘까용구링", type: .concept, status: .incomplete),
        Task(title: "1-3-1.other 자극을 전달하는 신경계", type: .other, status: .complete),
        Task(title: "1-3-2.concept 신경계를 통해 일어나는 반응", type: .concept, status: .inProgress),
        Task(title: "1-3-3.practice 신경계를 통해 일어나는 반응을 뭘까용구링", type: .practice, status: .incomplete)
        
    ]
    
    static let dummy1 = Task(title: "1-1-1. 자극을 전달하는 신경계", type: .concept, status: .complete)
    static let dummy2 = Task(title: "1-1-2. 신경계를 통해 일어나는 반응", type: .concept, status: .inProgress)
}
