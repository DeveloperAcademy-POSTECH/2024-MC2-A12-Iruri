//
//  CheckTimeView.swift
//  PlanIO
//
//  Created by 신혜연 on 5/22/24.
//

import SwiftUI

struct CheckTimeView: View {
    @Binding var cellColors: [[Color]]
    @State private var week: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    @State private var times: [String] = ["15:00", "16:00", "17:00", "18:00", "19:00", "20:00", "21:00", "22:00", "23:00", "24:00", "01:00", "02:00"]
    
    @Binding var isAnyCellFilled: Bool
    @State private var isPressed: Bool = false
    @State private var firstColor: Color = Color.white
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach(week.indices, id: \.self) { index in
                    Text(week[index])
                        .frame(width: 65, height: 20)
                        .font(.system(size: 18))
                        .fontWeight(.semibold)
                        .foregroundColor(index >= 5 ? .planIODarkYellow : .planIODarkGray)
                }
            }
            .padding(.bottom, 10)
            .padding(.leading, 60)
            
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    ForEach(times, id: \.self) { time in
                        Text(time)
                            .frame(width: 65, height: 23)
                            .font(.system(size: 12))
                            .foregroundColor(.planIODarkGray)
                    }
                }
                VStack(spacing: 0) {
                    ForEach(0 ..< 12, id: \.self) { row in
                        HStack(spacing: 0) {
                            ForEach(0 ..< 7, id: \.self) { column in
                                Rectangle()
                                    .fill(cellColors[row][column])
                                    .frame(width: 65, height: 23)
                                    .border(Color.planIODarkGray, width: 0.5)
                                    .gesture(
                                        LongPressGesture(minimumDuration: 0.01)
                                        // LongPressGesture와 동시에 인식하는 제스처 -> DragGesture
                                        // minimumDistance 이상 인식되었을 때 반응
                                            .sequenced(before: DragGesture(minimumDistance: 0))
                                            .onChanged { value in
                                                // value 동시에 인식되는 LongPressGesture와 DragGesture에서 변경되는 값
                                                switch value {
                                                    // 그 중에서 두 번째인 DragGestrue의 변경에 대한 action
                                                    // true: DragGesture가 인식중인지? drag: 변경되는 값
                                                case .second(true, let drag):
                                                    // 처음 눌러졌을 때 색상 저장
                                                    // 처음 white라면 다음 모두 눌러지는 것이 초록색이 될 것이고,
                                                    // green이라면 다음 모두 눌러지는 것이 하얀색일 것!
                                                    if isPressed == false {
                                                        firstColor = cellColors[row][column]
                                                        // 눌러졌음을 true로 변경하여, 처음 눌러진 이후에는 색상 값을 변경하지 못하도록
                                                        isPressed = true
                                                    }
                                                    
                                                    if let drag = drag {
                                                        let dragLocation = drag.location
                                                        
                                                        // 드래그되는 칸의 이동 정보 저장
                                                        let changedX = Int(floor(dragLocation.x / 100))
                                                        let changedY = Int(floor(dragLocation.y / 30))
                                                        
                                                        // 드래그되는 칸의 이동량?에 맞춰 처음 + 변경값으로
                                                        // 드래그되는 칸의 column, row 저장
                                                        let newColumn = column + changedX
                                                        let newRow = row + changedY
                                                        
                                                        // 처음눌러진 칸의 색상과 반대되는 색상으로 변경
                                                        if (newRow < 12 && newRow >= 0) && (newColumn < 7 && newColumn >= 0) {
                                                            if firstColor == .white {
                                                                cellColors[newRow][newColumn] = .planIOYellow
                                                            } else {
                                                                cellColors[newRow][newColumn] = .white
                                                            }
                                                            
                                                            updateIsAnyCellFilled()
                                                        }
                                                    }
                                                default:
                                                    break
                                                }
                                            }
                                        // Press가 끝났을 때, 다시 false로 변경
                                            .onEnded { _ in isPressed = false }
                                    )
                                    .simultaneousGesture(
                                        TapGesture()
                                            .onEnded {
                                                if cellColors[row][column] == .white {
                                                    cellColors[row][column] = .planIOYellow
                                                } else {
                                                    cellColors[row][column] = .white
                                                }
                                                
                                                updateIsAnyCellFilled()
                                            }
                                    )
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            // 초기에는 아무 셀도 색칠되지 않았음을 설정
            isAnyCellFilled = false
        }
    }
    
    private func updateIsAnyCellFilled() {
        isAnyCellFilled = cellColors.contains { $0.contains(.planIOYellow) }
    }
}
