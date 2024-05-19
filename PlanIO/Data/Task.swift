//
//  Task.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

enum TaskType { case concept, practice, other }

enum TaskStatus { case complete, inProgress, incomplete, none }

struct Task {
    let id = UUID()
    let title: String
    let type: TaskType
    let status: TaskStatus
}
