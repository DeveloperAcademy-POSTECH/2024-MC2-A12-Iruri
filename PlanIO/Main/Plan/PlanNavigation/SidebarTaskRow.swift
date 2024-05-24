//
//  PlanNavigationTaskRow.swift
//  PlanIO
//
//  Created by 대여품 on 5/23/24.
//

import SwiftData
import SwiftUI

struct SidebarTaskRow: View {
    @Environment(\.modelContext) var modelContext
    
    let task: Task
    
    @Binding var draggingTarget: Task?
    @Binding var draggingTargetDate: Date
    
    @State private var isEnteringText: Bool = false
    @State var textValue: String = ""
    
    private let valueListRowInsets: [CGFloat] = [3, -5, 3, -5]
    
    var body: some View {
        HStack {
            if isEnteringText {
                TextField(task.title, text: $textValue)
                
                Button {
                    isEnteringText.toggle()
                    
                    let datas: [Task] = queryData(id: task.id)
                    
                    if !datas.isEmpty {
                        datas[0].title = textValue
                    }
                    
                    modelContext.insert(datas[0])
                } label: {
                    // 수정완료 버튼 디자인 변경
                    Image(systemName: "checkmark")
                }
                
            } else {
                Text(task.title)
                    .draggable(task.id.uuidString) {
                        SidebarTaskRow(task: task, draggingTarget: $draggingTarget, draggingTargetDate: $draggingTargetDate)
                            .onAppear {
                                // 사이드바에서 드래그 된 목록은 Date가 0년 0월 0일
                                draggingTarget = task
                                draggingTargetDate = Date(year: 0, month: 0, day: 0)
                            }
                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            // 삭제
                            deleteData(target: task)
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                        
                        Button {
                            // 수정
                            isEnteringText.toggle()
                        } label: {
                            Label("Edit", systemImage: "applepencil")
                        }
                    }
            }
            Spacer()
        }
        .font(.footnote).bold()
        .foregroundStyle(Color.black)
        .multilineTextAlignment(.leading)
        
        .padding(10)
        .padding(.leading, 6)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 6))
        .shadow(color: .black.opacity(0.3), radius: 1.5, x: 0, y: 1)
        .listRowInsets(EdgeInsets(top: valueListRowInsets[0], leading: valueListRowInsets[1], bottom: valueListRowInsets[2], trailing: valueListRowInsets[3]))
    }
    
    private func queryData(id: UUID) -> [Task] {
        let predicate = #Predicate<Task> { $0.id == id }
        let desciptor = FetchDescriptor<Task>(predicate: predicate)
        
        do {
            let tasks = try modelContext.fetch(desciptor)
            if !tasks.isEmpty {
                return tasks
            }
        } catch {
            print("query failed")
        }
        
        return []
    }
    
    private func deleteData(target: Task) {
        modelContext.delete(target)
    }
}
