//
//  TaskAddView.swift
//  PlanIO
//
//  Created by Seol WooHyeok on 5/24/24.
//

import SwiftUI

struct TaskAddView: View {
    @Binding var showPopover: Bool
    @State var title: String = ""
    @State var type: TaskType = .concept
    
    var addDataFunc: (Task) -> Void
    
    var body: some View {
        Form {
            Section {
                TextField("제목을 입력하세요", text: $title)
            } header: {
                Text("할 일 제목")
            }
            
            Section {
                Picker("type", selection: $type) {
                    ForEach(TaskType.allCases, id: \.self.rawValue) {
                        Text($0.rawValue).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            } header: {
                Text("할 일 타입")
            }
            
            Button {
                let task = Task(title: title, type: type, status: .none, date: Date(year: 0, month: 0, day: 0))
                addDataFunc(task)
                self.showPopover = false
            } label: {
                HStack {
                    Spacer()
                    Text("저장")
                    Spacer()
                }
            }
            .disabled(!textValidate(text: title))
        }
        .frame(width: 300, height: 300)
        .onAppear {
            title = ""
            type = .concept
        }
    }
    
    private func textValidate(text: String) -> Bool {
        if text.trimmingCharacters(in: .whitespaces) == "" {
            return false
        } else {
            return true
        }
    }
}
