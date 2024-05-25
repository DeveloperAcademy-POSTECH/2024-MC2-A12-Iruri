//
//  PlanNavigationTaskListView.swift
//  PlanIO
//
//  Created by 대여품 on 5/23/24.
//

import SwiftData
import SwiftUI

struct SidebarTaskListView: View {
    @Query var tasks: [Task]
    
    @State private var isConceptSectionExpanded: Bool = true
    @State private var isPracticeSectionExpanded: Bool = true
    @State private var isOtherSectionExpanded: Bool = true
    
    @Binding var draggingTarget: Task?
    @Binding var draggingTargetDate: Date
    
    private let valueListRowInsets: [CGFloat] = [3, -5, 3, -5]
  
    let toggleup = Image(systemName: "chevron.up")
    let toggledown = Image(systemName: "chevron.down")
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            List {
                // 개념
                HStack {
                    Text(TaskType.concept.title)
                        .font(.footnote).bold()
                        .foregroundStyle(Color.planIODarkGray)
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    Button {
                        isConceptSectionExpanded.toggle()
                    }label: {
                        isConceptSectionExpanded ? toggleup.foregroundStyle(.planIODarkYellow).bold() : toggledown.foregroundStyle(.planIODarkYellow).bold()
                    }
                }
                .listRowInsets(EdgeInsets(top: valueListRowInsets[0], leading: valueListRowInsets[1], bottom: valueListRowInsets[2], trailing: valueListRowInsets[3]))
                
                ForEach(tasks) { item in
                    if item.type == .concept, isConceptSectionExpanded, item.date == Date(year: 0, month: 0, day: 0) {
                        SidebarTaskRow(task: item, draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
                    }
                }
                
                // 응용
                HStack {
                    Text(TaskType.practice.title)
                        .font(.footnote).bold()
                        .foregroundStyle(Color.planIODarkGray)
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    Button {
                        isPracticeSectionExpanded.toggle()
                    }label: {
                        isPracticeSectionExpanded ? toggleup.foregroundStyle(.planIODarkYellow).bold() : toggledown.foregroundStyle(.planIODarkYellow).bold()
                    }
                }
                .listRowInsets(EdgeInsets(top: valueListRowInsets[0], leading: valueListRowInsets[1], bottom: valueListRowInsets[2], trailing: valueListRowInsets[3]))
                
                ForEach(tasks) { item in
                    if item.type == .practice, isPracticeSectionExpanded, item.date == Date(year: 0, month: 0, day: 0) {
                        SidebarTaskRow(task: item, draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
                    }
                }
                
                // 기타
                HStack {
                    Text(TaskType.other.title)
                        .font(.footnote).bold()
                        .foregroundStyle(Color.planIODarkGray)
                        .padding(.leading, 10)
                    
                    Spacer()
                    
                    Button {
                        isOtherSectionExpanded.toggle()
                    }label: {
                        isOtherSectionExpanded ? toggleup.foregroundStyle(.planIODarkYellow).bold() : toggledown.foregroundStyle(.planIODarkYellow).bold()
                    }
                }
                .listRowInsets(EdgeInsets(top: valueListRowInsets[0], leading: valueListRowInsets[1], bottom: valueListRowInsets[2], trailing: valueListRowInsets[3]))
                
                ForEach(tasks) { item in
                    if item.type == .other, isOtherSectionExpanded, item.date == Date(year: 0, month: 0, day: 0) {
                        SidebarTaskRow(task: item, draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}
