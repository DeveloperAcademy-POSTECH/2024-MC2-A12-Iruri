//
//  TodayAchieveView.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import Charts
import SwiftData
import SwiftUI

struct TmpInput: Identifiable {
    var name: String
    var count: Double
    var id = UUID()
}

struct TodayAchieveView: View {
    @Query private var tasks: [Task]
    
    var completeRatio: Double {
        let todayTasks = tasks.filter { $0.date.isToday() }
        
        if todayTasks.isEmpty {
            return 100
        } else {
            // 오늘 달성률 = (완료 + (진행중 * 0.5)) / 오늘 전체 * 100
            let completeCount = todayTasks.filter { $0.status == .complete }.count
            let inprogressCount = todayTasks.filter { $0.status == .inProgress }.count
            let ratio = (Double(completeCount) + (Double(inprogressCount) / 2)) / Double(todayTasks.count) * 100
            return Double(ratio)
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("오늘의 성취").font(.callout).bold()
                Spacer()
            }
            
            Spacer()
            
            ZStack {
                // 배경 원
                Circle()
                    .trim(from: 0.0, to: 1.0)
                    .stroke(Color.planIOLightYellow, lineWidth: 28)
                    .frame(width: 134, height: 134)

                // 도넛 차트의 앞쪽 부분
                Circle()
                    .trim(from: 1.0 - (completeRatio / 100), to: 1.0)
                    .stroke(Color.planIODarkYellow, style: StrokeStyle(lineWidth: 28, lineCap: .round))
                    .rotationEffect(Angle(degrees: -90))
                    .frame(width: 134, height: 134)
                
                HStack {
                    Text("\(Int(completeRatio))")
                        .foregroundColor(.planIODarkYellow)
                        .font(.system(size: 44, weight: .heavy)) // .black .heavy .bold
                    + Text("%") // + 통해 글자를 밑으로 내렸습니다.
                        .foregroundColor(.planIODarkGray)
                        .font(.system(size: 14, weight: .heavy))
                }
            }
            
//            PieGraph(completeRatio: completeRatio)
            
            Spacer()
        }
    }
}

struct PieGraph: View {
    let completeRatio: Double
    var inCompleteRatio: Double { 100 - completeRatio }
    
    @State var ratio: [Double] = [1, 0] // 처음에 가지는 표기 비율 값이라, 별 상관이 없음.
    var body: some View {
        Chart {
            ForEach(ratio.indices, id: \.self) { index in
                SectorMark(angle: .value("", ratio[index]),
                           innerRadius: .inset(24),
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
                Text("\(Int(completeRatio))")
                    .foregroundColor(.planIODarkYellow)
                    .font(.system(size: 44, weight: .heavy)) // .black .heavy .bold
                + Text("%") // + 통해 글자를 밑으로 내렸습니다.
                    .foregroundColor(.planIODarkGray)
                    .font(.system(size: 14, weight: .heavy))
            }
        }
        )
        .onAppear {
            withAnimation(.easeIn(duration: 0.7).delay(0.1)) {
                ratio = [self.inCompleteRatio, self.completeRatio]
            }
        }
    }
}

#Preview {
    AchieveView()
}
