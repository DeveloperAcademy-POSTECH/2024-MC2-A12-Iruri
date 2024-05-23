//
//  InputData.swift
//  PlanIO
//
//  Created by 신혜연 on 5/21/24.
//

import SwiftUI

@Observable
class InputData {
    var selectedStep: InputStep = .schedule
    
    var testDates: [Date] = []
    
    var scopes: [SmallTextBookChapter] = []
}
