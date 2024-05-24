//
//  TodayAchieveView.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import Charts
import SwiftUI

// 1. TmpInput을 실제 값을 받아오는 것으로 변경해야합니다.
// 2. 레이아웃 변경 이후에 다음의 값을 다시 조정해야합니다.
// 2-1. 패딩 크기
// 2-2. 폰트 크기

struct TmpInput: Identifiable {
    var name: String
    var count: Double
    var id = UUID()
}

struct TodayAchieveView: View {
    var body: some View {
        VStack {
            HStack {
                Text("오늘의 성취").font(.callout).bold()
                Spacer()
            }
            PieGraph().padding(10)
            Spacer()
        }
    }
}

struct PieGraph: View {
    let data = [
        TmpInput(name: "아직안함", count: 35),
        TmpInput(name: "완료", count: 65)
    ]
    
    @State var ratio: [Double] = [1, 0] // 처음에 가지는 표기 비율 값이라, 별 상관이 없음.
    var body: some View {
        Chart {
            ForEach(ratio.indices, id: \.self) { index in
                SectorMark(angle: .value("이거 항상 궁금했는데 아무 영향도 없는 거 같은데 뭔지 모르겠음", ratio[index]),
                           innerRadius: .inset(30),
                           angularInset: 0.8
                )
                .cornerRadius(5)
                .foregroundStyle(
                    // 인덱스가 0이면 not_yet, 1이면 완료
                    index == 0 ? Color.planIOLightYellow : Color.planIODarkYellow
                )
            }
        }
        .chartBackground(content: { _ in
            HStack {
                Text(String(Int(data[1].count)))
                    .foregroundColor(.planIODarkYellow)
                    .font(.system(size: 60*0.9, weight: .heavy)) // .black .heavy .bold
                + Text("%") // + 통해 글자를 밑으로 내렸습니다.
                    .foregroundColor(.planIODarkGray)
                    .font(.system(size: 16*0.9, weight: .heavy))
            }
        }
        )
        .onAppear {
            withAnimation(.easeIn(duration: 0.7).delay(0.1)) {
                ratio = data.map { $0.count }
            }
        }
        
    }
}

#Preview {
    AchieveView()
}
