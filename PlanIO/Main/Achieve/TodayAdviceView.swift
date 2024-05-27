//
//  TodayAdviceView.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct TodayAdviceView: View {
    let randomTexts = ["성적 때문에 우울해하는 친구가 있는데 어떻게 조언해주면 좋을까?", "다시 보니 좋네!", "사람들은 소중한 친구를 대하듯이 자신을 대하지 못하는 것 같아 스스로가 가장 소중한 친구인데도!", "스트레스가 아주 높으면 자기 통제력이 낮아진대! 그러니 꼭 주기적으로 휴식해 줘!!", "자기 연민은 중요해! 너무 자책하지 말고 스스로를 아껴줘!", "가끔은 쉬어가도 돼. 너 자신에게 너그러워지자.", "단권화는 좋은 전략인 것 같아! 사실 구슬쥬 유튜브에서 보고왔어!", "1시간마다 학습 과목을 바꿔주면 더 쉽게 기억에 남는다고 하네!", "짧고 자주 복습하면 장기 기억에 좋아! 포모도로 기법을 써봐!", "어려운 과목은 아침에! 신선한 두뇌가 더 잘 받아들인대.", "계획을 직접 짜다보면 스스로를 더 잘 알게되서 효율적으로 학습할 수 있대!", "지난 시험 대비가 실제로 어떻게 됐는지 떠올리면 더 정확한 계획을 짤 수 있을거야!", "의지력은 혈당과 관련이 있어! 아침과 식사 후에는 어려운 것도 잘할 수 있을거야!", "계획은 구체적일수록 좋아. 시간대와 목표를 명확히 정해봐!", "주간 계획을 세울 때는 휴식 시간도 꼭 포함시켜줘!", "계획은 무리하게 짜지 말고 네가 해낼 수 있는지 생각해봐!", "지금 한 페이지라도 시작해두면 나중에 실천하기가 더 쉬워진대! 한 발자국만 더!", "학습할 과제를 세밀하게 쪼개면 심리적으로 실천이 더 편해진대!", "휴식의 요령은 학습 요령만큼 중요해! 명상과 산책 낮잠을 추천해!!", "시작이 여렵다면 정말 작아도 좋아 딱 한줄만 소리내어 읽어보자!", "너무 완벽함에 집착하는 것은 일을 미루게 만들 수 있대 완벽하지 않더라도 지금 실행해보자!", "작은 성공을 쌓아가면 자신감이 커진대. 지금 당장 시작해보자!", "실패해도 괜찮아. 중요한 건 계속 시도하는 거야!", "한 번에 하나씩,작은 목표를 세워 차근차근 진행해보자.", "잠시 멈추고 심호흡 해봐. 마음이 가라앉으면 더 잘 할 수 있어!"]
    
    @State private var randomText: String = ""
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("가현아!")
                        .foregroundColor(.planIODarkYellow)
                        .font(.system(size: 24))
                        .bold()
                        .padding(.bottom, 3)
                    Text(randomText)
                        .font(.system(size: 18))
                        .bold()
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button {
                            getRandomText()
                        } label: {
                            Image("PlanIOCharacter")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 150, height: 150) // 이미지 크기 지정
                        }
                        
                        Spacer()
                    }
                    
                    HStack {
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
