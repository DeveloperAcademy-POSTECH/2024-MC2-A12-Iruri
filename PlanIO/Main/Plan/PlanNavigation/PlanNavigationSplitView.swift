//
//  PlanNavigationSplitView.swift
//  PlanIO
//
//  Created by 대여품 on 5/23/24.
//

import SwiftData
import SwiftUI


/**
 TODO
 1. navigation 타이틀에 버튼 추가 가능한지 확인
 2. + 버튼 눌렀을때, 어떤 방식을 통해 추가 될 것인지
 - 모달창을 띄워서 받기
 3. row를 보여주는 view에서 순서를 바꿀 수 있어야 한다.
 <- 일단은 드래그 앤 드롭이랑 충돌해서 구현 할지 고민해야함.
 4.
 
 
 
 */

struct PlanNavigationSplitView: View {
//    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        VStack(){
            HStack() {
                Text("학습 계획")
                    .font(.title).bold()
                Spacer()
                Text("+")
                    .onTapGesture {
                        //TODO 모달창 만들기
                    }
            }
            //            .frame(height: 40)
            
            //TODO
            // VStack 으로 각 테스크별 창 만들기
            // Task를 통으로 받을지, type 별로 따로 받을지
            // 이건 EO의 설계를 그대로 따라가는 식으로 해야한다.
            
            // 데이터는 Task.dummy3 ㄹㄹ 가져오면 됨
            // 이거 유사한 View와 설계를 다르게 해야한다.
            // 이쪽은 스크롤뷰가 두개가 들어가버림
            // 당연히 더블 스크롤 뷰는 쓰지 않는게 좋겠지
            
//            List{
                
                //            ScrollView{
                //                VStack{
                
                // 개념
                PlanNavigationTaskListView(type: .concept)
                //
                //                // 응용
//                PlanNavigationTaskListView(type: .practice)
//                //
//                //                // 기타
//                PlanNavigationTaskListView(type: .other)
                
                
                //                }
                //            }
//            }
            Spacer()
            
            Button {
                //TODO
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
            }
            
            
            
            
            
        }
        .padding(.horizontal, 10)
        .padding(.bottom,12)
        
        // TODO
        //        .navigationTitle("Title")
        
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
