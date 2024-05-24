//
//  TestScopeView.swift
//  PlanIO
//
//  Created by 신혜연 on 5/21/24.
//

import SwiftUI

struct TestScopeView: View {
    @Bindable var inputData: InputData
    @State private var contents = TextBook.contents
    
    var body: some View {
        List {
            // 대단원
            ForEach(contents, id: \.id) { large in
                let largeIndex = large.chapter - 1
                Section(isExpanded: $contents[largeIndex].isExpanded) {
                    // 중단원
                    ForEach(large.midChapters, id: \.id) { mid in
                        let midIndex = mid.chapter - 1
                        Section(isExpanded: $contents[largeIndex].midChapters[midIndex].isExpanded) {
                            // 소단원 반복
                            ForEach(mid.smallChapters, id: \.id) { small in
                                let smallIndex = small.chapter - 1
                                Button {
                                    contents[largeIndex].midChapters[midIndex].smallChapters[smallIndex].isChecked.toggle()
                                    inputData.scopes = filteredChapters(from: contents)
                                } label: {
                                    HStack {
                                        Text("(\(small.chapter)) \(small.title) - p.\(small.startPage)")
                                        
                                        Spacer()
                                        Image(systemName: contents[largeIndex].midChapters[midIndex].smallChapters[smallIndex].isChecked ? "checkmark.square" : "square")
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
                    Text("\(large.chapter). \(large.title) - p.12")
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
    
    private func filteredChapters(from chapters: [LargeTextBookChapter]) -> [LargeTextBookChapter] {
        let data = chapters.compactMap { chapter in
            let filteredMidChapters = chapter.midChapters.compactMap { midChapter in
                let filteredSmallChapters = midChapter.smallChapters.filter { $0.isChecked }
                
                let mid = MidTextBookChapter(chapter: midChapter.chapter,
                                             title: midChapter.title,
                                             smallChapters: filteredSmallChapters,
                                             isExpanded: midChapter.isExpanded)
                
                return filteredSmallChapters.isEmpty ? nil : mid
            }
            
            let large = LargeTextBookChapter(chapter: chapter.chapter,
                                             title: chapter.title,
                                             midChapters: filteredMidChapters,
                                             isExpanded: chapter.isExpanded)
            
            return filteredMidChapters.isEmpty ? nil : large
        }
        
        return(data)
    }
}

#Preview {
    TestScopeView(inputData: InputData())
}
