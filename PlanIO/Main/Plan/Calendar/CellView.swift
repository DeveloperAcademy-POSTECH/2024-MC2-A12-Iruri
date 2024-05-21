//
//  CellView.swift
//  PlanIO
//
//  Created by Seol WooHyeok on 5/22/24.
//

import SwiftUI

// MARK: - 일자 셀 뷰
struct CellView: View {
    var date: Date
    
    @State var tasks: [Task] = []
    @Binding var currentlyDragging: Task?
    
    @Binding var tempTasks: [Temp]
    
    var body: some View {
        VStack {
            HStack {
                Spacer()

                Text("\(formattedDate(date: date))")
                    .foregroundStyle(.black)
                    .padding(10)
            }
            
            ForEach(tasks) { task in
                Text(task.title)
                    .overlay(Rectangle().opacity(0.1))
                    .draggable(task.title) {
                        Image(systemName: "tree.fill")
                            .onAppear {
                                currentlyDragging = task
                                print("여기서 옮겨집니다. 이 배열을 수색할게요! \(date)")
                            }
                    }
                    .dropDestination(for: String.self) { items, location in
                        // drop 되었을 경우의 item을 찾는 듯 한데..
                        // 지금 계속 리스트가 움직여서 자신을 뽑아버리는 듯 함
                        // print(items)
                        // print(location)
                        appendTask()
                        
                        print("여기에 드롭했습니다. 이 배열을 수색할게요!\(date)")
                        return false
                    } isTargeted: { status in
                        if status == true {
                            print("isTargeted true")
                        }
                        // isTargeted은 드래그 중인 객체가 dropDestination한 객체 위에 '겹쳐져서 유지되고 있는지'를 파악합니다. -> 이해 완료!
                        // status는 저희가 선언한 값이 아니라, bool 값입니다. 지금은 사용되지 않습니다.
                        if let currentlyDragging, status, currentlyDragging.id != task.id {
                            // 안전장치 확인하고, 드랍할 task가 현재 드래그중인 currentlyDragging task 가 아님을 확인하면,
                            // 애니메이션과 함께 Task의 소속 칸반 Status를 번경하고, 인덱스를 변경합니다.
                            withAnimation(.snappy){
                                // 현재 겹쳐지는 위치/task가 다른 칸반일때, currentlyDragging이 속해있는 view를 변경합니다.
                               
                                
//                                switch task.status {
//                                case .first:
//                                    replaceItem(tasks: &first, droppingTask: task, status: .first)
//                                case .second:
//                                    replaceItem(tasks: &second, droppingTask: task, status: .second)
//                                }
                            }
                        }
                    }
            }
            
            Spacer()
        }
        .onAppear {
            queryData(dateString: formattedDate(date: date))
        }
    }
    
    // 쿼리해오는 코드
    private func queryData(dateString: String) {
        print(tempTasks)
        print(dateString)
        if let target = tempTasks.first(where: { formattedDate(date: $0.date) == dateString }) {
            self.tasks = target.tasks
        }
    }
    
    
    // 날짜를 "6월 1일" 형식으로 포맷하는 함수
    func formattedDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "M월 d일"
        return dateFormatter.string(from: date)
    }
    
    func formattedShortDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d일"
        return dateFormatter.string(from: date)
    }
    
    // 로직이해가 이제 됨!
    func appendTask() {
        // currentlyDragging 존재시
        if let currentlyDragging {
            var updatedTask = currentlyDragging
            tasks.append(updatedTask)
        }
    }
    
//    // 로직이해가 잘 안됨!
//    func replaceItem(tasks: inout [Task], droppingTask: Task, status: Status) {
//        
//        // curDragging 있는지 확인
//        if let currentlyDragging {
//            // 지금 돌아다니는 친구를 찾는다.
//            if let sourceIndex = tasks.firstIndex(where: {$0.id == currentlyDragging.id }),
//               let destinationIndex = tasks.firstIndex(where: { $0.id == droppingTask.id}) {
//                /// Swapping Item's on the List
//                var sourceItem = tasks.remove(at: sourceIndex)
//                sourceItem.status = status
//                tasks.insert(sourceItem, at: destinationIndex)
//            }
//        }
//    }
}
