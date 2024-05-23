//
//  SelectBookView.swift
//  PlanIO
//
//  Created by Anjin on 5/21/24.
//

import SwiftUI

struct SelectBookView: View {
    private let textBooks: [String] = ["비상교육", "천재교육"]
    @State private var selectedTextBook: String = "비상교육"
    
    private let workBooks: [String] = ["오투", "백신과학"]
    @State private var selectedWorkBook: String = "오투"
    
    var body: some View {
        List {
            Picker(selection: $selectedTextBook) {
                ForEach(textBooks, id: \.self) { book in
                    Text(book)
                }
            } label: {
                Text("교과서")
                    .font(.title2).bold()
                    .foregroundStyle(Color.black)
            }
            .listRowBackground(Color.planIOLightGray)
            .pickerStyle(.inline)
            
            Picker(selection: $selectedWorkBook) {
                ForEach(workBooks, id: \.self) { book in
                    Text(book)
                }
            } label: {
                Text("문제집")
                    .font(.title2).bold()
                    .foregroundStyle(Color.black)
            }
            .listRowBackground(Color.planIOLightGray)
            .pickerStyle(.inline)
        }
        .background(Color.white)
        .scrollContentBackground(.hidden)
        .frame(width: 550)
    }
}

#Preview {
    SelectBookView()
}
