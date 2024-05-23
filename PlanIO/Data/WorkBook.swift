//
//  WorkBook.swift
//  PlanIO
//
//  Created by Anjin on 5/20/24.
//

import SwiftUI

struct LargeWorkBookChapter: Identifiable {
    let id = UUID()
    let chapter: Int
    let title: String
    let midChapters: [MidWorkBookChapter]
}

struct MidWorkBookChapter: Identifiable {
    let id = UUID()
    let chapter: Int
    let title: String
}

struct WorkBook {
    static let contents: [LargeWorkBookChapter] = [
        LargeWorkBookChapter(chapter: 1, title: "화학 반응의 규칙과 에너지 변화", midChapters: [
            MidWorkBookChapter(chapter: 1, title: "물질 변화와 화학 반응식"),
            MidWorkBookChapter(chapter: 2, title: "화학 반응의 규칙"),
            MidWorkBookChapter(chapter: 3, title: "화학 반응에서의 에너지 출입"),
        ]),
        
        LargeWorkBookChapter(chapter: 2, title: "기권과 날씨", midChapters: [
            MidWorkBookChapter(chapter: 1, title: "기권과 지구 기온"),
            MidWorkBookChapter(chapter: 2, title: "구름과 강수"),
            // 교과서(3.기압과 날씨) = 문제지3-1(3.기압과 바람, 4, 날씨와 변화)
            // 각각 소단원 (1), (2,3)
            MidWorkBookChapter(chapter: 3, title: "기압과 바람"),
            // 위와 같음
            MidWorkBookChapter(chapter: 4, title: "날씨와 변화"),
        ]),
        
        LargeWorkBookChapter(chapter: 3, title: "운동과 에너지", midChapters: [
            MidWorkBookChapter(chapter: 1, title: "등속 운동과 자유 낙하 운동"),
            MidWorkBookChapter(chapter: 2, title: "일과 에너지"),
        ]),
        
        LargeWorkBookChapter(chapter: 4, title: "자극과 반응", midChapters: [
            MidWorkBookChapter(chapter: 1, title: "감각 기관"),
            MidWorkBookChapter(chapter: 2, title: "신경계와 호르몬"),
        ]),
        
        LargeWorkBookChapter(chapter: 1, title: "생식과유전", midChapters: [
            // 교과서(1.생식) = 문제지3-2(1.새포 분열, 2.사람의 발생)
            // 각각 소단원 (1,2,3), (4)
            MidWorkBookChapter(chapter: 1, title: "세포 분열"),
            // 위와 같음
            MidWorkBookChapter(chapter: 2, title: "사람의 발생"),
            
            // 교과서(2.유전) = 문제지3-2(3.멘델의 유전 원리, 4.사람의 유전)
            // 각각 소단원 (1,2), (3,4)
            MidWorkBookChapter(chapter: 3, title: "멘델의 유전 원리"),
            // 위와 같음
            MidWorkBookChapter(chapter: 4, title: "사람의 유전"),
        ]),
        
        LargeWorkBookChapter(chapter: 2, title: "에너지 전환과 보존", midChapters: [
            MidWorkBookChapter(chapter: 1, title: "역학적 에너지의 전환과 보존"),
            MidWorkBookChapter(chapter: 2, title: "전기 에너지의 발생과 전환"),
        ]),
        
        LargeWorkBookChapter(chapter: 3, title: "별과 우주", midChapters: [
            // 교과서(1.별) = 문제지3-2(1.별까지의 거리, 2.별의 성질)
            // 각각 소단원 (1), (2,3)
            MidWorkBookChapter(chapter: 1, title: "별까지의 거리"),
            // 위와 같음
            MidWorkBookChapter(chapter: 2, title: "별의 성질"),
            
            // 교과서(2.은하와 우주, 3.우주 탐사) = 문제지3-2(3.은하와 우주)
            MidWorkBookChapter(chapter: 3, title: "은하와 우주"),
        ]),
        
        LargeWorkBookChapter(chapter: 4, title: "과학기술과 인류 문명", midChapters: [
            MidWorkBookChapter(chapter: 1, title: "과학기술과 인류 문명"),
        ])
    ]
}
