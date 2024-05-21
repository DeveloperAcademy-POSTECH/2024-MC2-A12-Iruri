//
//  InputView.swift
//  PlanIO
//
//  Created by Anjin on 5/17/24.
//

import SwiftUI

struct InputView: View {
    @State private var isExamScheduleChecked = false
    @State private var isNextButtonEnabled = false
    
    @State private var inputData: InputData = InputData()
    
    var body: some View {
        VStack(spacing: 60) {
            InputStepView()
            
            // 펭귄이오
            HStack {
                Image("PlanIOCharacter")
                    .resizable()
                    .frame(width: 125, height: 125)
                ZStack {
                    Image("SpeechBubble")
                        .resizable()
                        .frame(width: 454, height: 80)
                    Text(inputData.seletedStep.speechBubbleText)
                        .bold()
                }
            }
            
            VStack {
                // 달력
                TestDateView(isChecked: $isExamScheduleChecked, isNextButtonEnabled: $isNextButtonEnabled)
            }
            
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 266, height: 60)
                            .foregroundColor(.planIOGray)
                            .shadow(color: .planIOGray, radius: 3, y: 2 )
                        Text("이전으로")
                            .foregroundColor(.planIODarkGray)
                            .bold()
                    }
                })
                Button(action: {}, label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 266, height: 60)
                            .foregroundColor(isExamScheduleChecked ? .planIOYellow : .planIOGray)
                            .shadow(color: .planIOGray, radius: 3, y: 2 )
                        Text("다음으로")
                            .foregroundColor(isExamScheduleChecked ? .black : .planIODarkGray)
                            .bold()
                    }
                })
                .disabled(!isExamScheduleChecked)
            }
        }
        .padding(.vertical, 60)
        Spacer()
    }
}

struct TestDateView: View {
    @Binding var isChecked: Bool
    @Binding var isNextButtonEnabled: Bool
    
    @State private var selectedDate = Date()
    @State private var isDatePickerShowing = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    HStack(spacing: 16) {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "minus.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 30, height: 30)
                        })
                        HStack(spacing: 0) {
                            // 날짜
                            Text("\(formattedDate(selectedDate))")
                                .bold()
                                .font(.system(size: 20))
                                .foregroundColor(.planIODarkGray)
                            
                            Spacer()
                            
                            // 캘린더 버튼
                            Button {
                                isDatePickerShowing.toggle()
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
                            isChecked.toggle()
                            isNextButtonEnabled = isChecked
                        }, label: {
                            Image(systemName: isChecked ? "checkmark.square" : "square")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(isChecked ? .black : .planIOGray)
                        })
                        .frame(width: 80, height: 80)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                    }
                    .padding(.bottom, 10)
                    .zIndex(2.0)
                }
                .padding(3)
            }
            .frame(width: 480, height: 175)
            .overlay {
                // 달력 - DatePicker
                if isDatePickerShowing {
                    GeometryReader { geo in
                        DatePicker("", selection: $selectedDate, displayedComponents: .date)
                            .datePickerStyle(.graphical)
                            .padding()
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2)
                            .position(x: geo.size.width * 1.08, y: 100)
                            .onChange(of: selectedDate) { _, _ in
                                isDatePickerShowing = false
                            }
                    }
                }
            }
            .zIndex(3.0)
            
            // 날짜 추가
            Button {
                
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
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일 EEEE"
        return formatter.string(from: date)
    }
}

#Preview {
    InputView()
}
