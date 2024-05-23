//
//  EmptyAchieveView.swift
//  PlanIO
//
//  Created by 강다혜 on 5/21/24.
//
import SwiftUI

struct EmptyAchieveView: View {
    var body: some View {
        VStack(spacing: 0) {
            // 말풍선
            HStack(spacing: 0) {
                Text("아직 시험 계획을 세우지 않았네?\n우리 같이 시험을 준비해보자!")
                    .fontWeight(.semibold)
                    .font(.system(size: 32))
                    .padding(80)
                    .multilineTextAlignment(.center)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 3)
            }
            
            Triangle()
                .frame(width: 48, height: 15)
                .rotationEffect(Angle(degrees: 180))
                .foregroundColor(.white)
                .shadow(color: .black.opacity(0.25), radius: 3, x: 0, y: 3)
                
                // f.offset(x: 20, y: 90)
            // 사과
            Image("apple")
                .resizable()
                .frame(width: 200, height: 200)
            
            Button {
                
            } label: {
                Text("계획하기")
                    .font(.title2)
                    .bold()
                    .foregroundColor(.black)
                    .frame(width: 553, height: 60, alignment: .center) // 크기 조정
                    .background(Color.yellow) // 배경 색상 추가
                    .cornerRadius(10) // 모서리 둥글림
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 2) // 그림자 추가
            }
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

#Preview {
    EmptyAchieveView()
}
