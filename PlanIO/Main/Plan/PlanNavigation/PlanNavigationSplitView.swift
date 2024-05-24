//
//  PlanNavigationSplitView.swift
//  PlanIO
//
//  Created by 대여품 on 5/23/24.
//

import SwiftData
import SwiftUI


struct PlanNavigationSplitView: View {
    
    var body: some View {
        VStack(){
            HStack() {
                Text("학습 계획")
                    .font(.title).bold()
                Spacer()
                Text("+")
                    .onTapGesture {
                        //TODO: Task 추가 기능 구현
                    }
            }
            .padding(.horizontal, 10)
            
            PlanNavigationTaskListView()
            
            Spacer()
            
            Button {
                // TODO: 자동배치 기능
            } label: {
                HStack {
                    Spacer()
                    Text("자동배치")
                        .font(.footnote).bold()
                        .foregroundStyle(Color.black)
                        .multilineTextAlignment(.leading)
                    Spacer()
                }
                .padding(10)
                .background(Color.planIOYellow)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .shadow(color: .black.opacity(0.3), radius: 1.5, x: 0, y: 1)
                .padding(.horizontal, 10)
                .padding(.bottom,12)
            }
        }
    }
}



#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Task.self, configurations: config)
    
    for i in TaskManager.dummy3 {
        container.mainContext.insert(i)
    }
    
    return PlanView().modelContainer(container)
    
    
    //    PlanView()
}
