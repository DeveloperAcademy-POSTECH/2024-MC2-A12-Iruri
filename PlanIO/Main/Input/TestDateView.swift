//
//  TestDateView.swift
//  PlanIO
//
//  Created by 신혜연 on 5/21/24.
//

import SwiftUI

struct TestDateView: View {
    @Binding var isNextButtonEnabled: Bool
    
    @State private var selectedDate: [Date] = [Date()]
    @State private var isDatePickerShowing: [Bool] = [false]
    
    @State private var selectedIndex: Int = 0
    
    @Binding var testDate: Date?
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    ForEach($selectedDate.indices, id: \.self) { index in
                        let isTestDate: Bool = testDate == selectedDate[index]
                        
                        // 시험 보는 날
                        HStack(spacing: 16) {
                            // 날짜 제거 버튼
                            Button(action: {
                                if selectedDate.indices.contains(index) {
                                    selectedDate.remove(at: index)
                                    isDatePickerShowing.remove(at: index)
                                }
                            }, label: {
                                Image(systemName: "minus.circle")
                                    .resizable()
                                    .foregroundColor(selectedDate.count > 1 ? .red : .gray)
                                    .frame(width: 30, height: 30)
                            })
                            .disabled(selectedDate.count <= 1)
                            
                            HStack(spacing: 0) {
                                // 날짜
                                Text("\(formattedDate(selectedDate[index]))")
                                    .bold()
                                    .font(.system(size: 20))
                                    .foregroundColor(.planIODarkGray)
                                
                                Spacer()
                                
                                // 캘린더 버튼
                                Button {
                                    selectedIndex = index
                                    isDatePickerShowing[index].toggle()
                                } label: {
                                    Image(systemName: "calendar")
                                        .resizable()
                                        .frame(width: 25, height: 22)
                                        .foregroundColor(.primary)
                                }
                            }
                            .padding(.vertical, 30)
                            .padding(.horizontal, 40)
                            .frame(height: 80)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                            
                            // 체크박스
                            Button(action: {
                                if let testDate = testDate, testDate == selectedDate[index] {
                                    self.testDate = nil
                                } else {
                                    testDate = selectedDate[index]
                                }
                            }, label: {
                                Image(systemName: isTestDate ? "checkmark.square" : "square")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.planIOGray)
                            })
                            .frame(width: 80, height: 80)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                        }
                        .padding(.bottom, 10)
                        .zIndex(2.0)
                    }
                }
                .padding(3)
            }
            .frame(width: 480)
            .zIndex(3.0)
            .overlay {
                // 달력 - DatePicker
                datePicker(at: selectedIndex)
            }
            
            // 날짜 추가
            Button {
                selectedDate.append(Date())
                isDatePickerShowing.append(false)
            } label: {
                HStack {
                    Spacer()
                    
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.planIOYellow)
                    
                    Text("시험 보는 날 추가하기")
                        .bold()
                        .font(.system(size: 17))
                        .foregroundColor(.black)
                    
                    Spacer()
                }
                .padding(.vertical, 18)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
            }
        }
        .frame(width: 460)
    }
    
    @ViewBuilder
    private func datePicker(at index: Int) -> some View {
        if isDatePickerShowing[index] {
                                GeometryReader { geo in
                DatePicker("", selection: $selectedDate[index], displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .padding()
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                    .position(x: geo.size.width * 1.29, y: 70)
                    .scaleEffect(0.8)
                    .onChange(of: selectedDate[index]) { _, _ in
                        isDatePickerShowing[index] = false
                    }
                                }
        }
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일 EEEE"
        return formatter.string(from: date)
    }
}

#Preview {
    @State var isNextButtonEnabled = false
    @State var testDate: Date?
    
    return TestDateView(isNextButtonEnabled: $isNextButtonEnabled, testDate: $testDate)
}
