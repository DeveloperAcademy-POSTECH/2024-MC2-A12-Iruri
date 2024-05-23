//
//  TodayAdviceView.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct TodayAdviceView: View {
    let randomTexts = ["힘내세요!", "오늘도 화이팅!", "당신은 할 수 있어요!", "포기하지 마세요!", "계속 전진하세요!"]
    @State private var randomText: String = ""
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading){
                    Text("가현아!")
                        .foregroundColor(.planIODarkYellow)
                        .font(.system(size: 24))
                        .bold()
                        .padding(.bottom, 3)
                    Text(randomText)
                        .font(.system(size: 18))
                        .bold()
                    
                    Spacer()
                    
                    Button {
                        getRandomText()
                    } label: {
                        Image("PlanIOCharacter")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 207, height: 207) // 이미지 크기 지정
                    }
                    HStack{
                        Spacer()
                        Text("나를 눌러봐")
                            .font(.system(size: 12))
                        Spacer()
                    }
                }
            }
        }
        .onAppear { getRandomText() }
    }
    
    private func getRandomText() {
        var newRandomText = randomTexts.randomElement()
        
        while randomText == newRandomText {
            newRandomText = randomTexts.randomElement()
        }
        
        randomText = newRandomText ?? ""
    }
}

#Preview {
    AchieveView()
}
