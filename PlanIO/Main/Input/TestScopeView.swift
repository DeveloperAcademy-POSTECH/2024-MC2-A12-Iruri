//
//  TestScopeView.swift
//  PlanIO
//
//  Created by 신혜연 on 5/21/24.
//

import SwiftUI

struct TestScopeView: View {
    @State private var isSectionExpanded: Bool = true
    @State private var isSection2Expanded: Bool = true
    @State private var isCheckedScope: Bool = false
    private let contents = TextBook.contents
    
    var body: some View {
        List {
            ForEach(contents, id: \.id) { large in
                
                Section(isExpanded: $isSectionExpanded) {
                    ForEach(large.midChapters, id: \.id) { mid in
                        
                        Section(isExpanded: $isSection2Expanded) {
                            ForEach(mid.smallChapters, id: \.id) { small in
                                
                                Button {
                                    isCheckedScope.toggle()
                                } label: {
                                    HStack {
                                        Text("(\(small.chapter)) \(small.title) - p.\(small.startPage)")
                                        
                                        Spacer()
                                        Image(systemName: isCheckedScope ? "checkmark.square" : "square")
                                    }
                                }
                                .padding(.leading, 20)
                            }
                        } header: {
                            Text("\(mid.chapter)) \(mid.title)")
                                .listRowBackground(Color.planIODarkYellow)
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                        }
                    }
                } header: {
                    Text("\(large.chapter). \(large.title)")
                        .font(.system(size: 18))
                        .bold()
                        .foregroundColor(.black)
                }
            }
        }
        .tint(Color.black)
        .listStyle(SidebarListStyle())
        .frame(width: 550)
    }
}

#Preview {
    TestScopeView()
}
