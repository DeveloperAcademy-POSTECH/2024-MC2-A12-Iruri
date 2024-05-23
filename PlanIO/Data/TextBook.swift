//
//  TextBook.swift
//  PlanIO
//
//  Created by Anjin on 5/16/24.
//

import SwiftUI

struct LargeTextBookChapter {
    let id = UUID()
    let chapter: Int
    let title: String
    let midChapters: [MidTextBookChapter]
}

struct MidTextBookChapter {
    let id = UUID()
    let chapter: Int
    let title: String
    let smallChapters: [SmallTextBookChapter]
}

struct SmallTextBookChapter {
    let id = UUID()
    let chapter: Int
    let title: String
    let startPage: Int
}

struct TextBook {
    static let contents: [LargeTextBookChapter] = [
        
        LargeTextBookChapter(chapter: 1, title: "화학 반응의 규칙과 에너지 변화", midChapters: [
            MidTextBookChapter(chapter: 1, title: "물질 변화와 화학 반응식", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "주변에서 일어나는 물질 변화", startPage: 12),
                SmallTextBookChapter(chapter: 2, title: "화학 반응을 나타내는 화학 반응식", startPage: 16),
            ]),
            MidTextBookChapter(chapter: 2, title: "화학 반응의 규칙", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "화학 반응에서 변하지 않는 질량", startPage: 26),
                SmallTextBookChapter(chapter: 2, title: "일정한 질량비로 결합하는 원소", startPage: 30),
                SmallTextBookChapter(chapter: 3, title: "일정한 부피비가 성립하는 기체 반응", startPage: 34),
            ]),
            MidTextBookChapter(chapter: 3, title: "화학 반응에서의 에너지 출입", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "에너지가 출입하는 화학 반응", startPage: 40),
                SmallTextBookChapter(chapter: 2, title: "화학 반응을 활용한 장치 설계", startPage: 44),
            ]),
        ]),
        
        LargeTextBookChapter(chapter: 2, title: "기권과 날씨", midChapters: [
            MidTextBookChapter(chapter: 1, title: "기권과 지구 기온", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "층상 구조를 이루는 기권", startPage: 54),
                SmallTextBookChapter(chapter: 2, title: "복사 평형을 이루는 지구", startPage: 56),
                SmallTextBookChapter(chapter: 3, title: "점점 더워지는 지구", startPage: 60),
            ]),
            MidTextBookChapter(chapter: 2, title: "구름과 강수", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "공기 속에 숨은 수증기", startPage: 66),
                SmallTextBookChapter(chapter: 2, title: "물방울로 이루어진 구름", startPage: 70),
                SmallTextBookChapter(chapter: 3, title: "지표에 내리는 강수", startPage: 74),
            ]),
            // 교과서(3.기압과 날씨) = 문제지3-1(3.기압과 바람, 4, 날씨와 변화)
            // 각각 소단원 (1), (2,3)
            MidTextBookChapter(chapter: 3, title: "기압과 날씨", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "기압 차이로 부는 바람", startPage: 80),
                SmallTextBookChapter(chapter: 2, title: "성질이 다른 공기 덩어리", startPage: 84),
                SmallTextBookChapter(chapter: 3, title: "매일 변하는 날씨", startPage: 88),
            ]),
        ]),
        
        LargeTextBookChapter(chapter: 3, title: "운동과 에너지", midChapters: [
            MidTextBookChapter(chapter: 1, title: "등속 운동과 자유 낙하 운동", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "운동을 기록하는 방법", startPage: 100),
                SmallTextBookChapter(chapter: 2, title: "속력이 일정한 운동", startPage: 102),
                SmallTextBookChapter(chapter: 3, title: "자유 낙하 하는 물체의 운동", startPage: 106),
            ]),
            MidTextBookChapter(chapter: 2, title: "일과 에너지", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "과학에서의 일", startPage: 114),
                SmallTextBookChapter(chapter: 2, title: "일을 하여 생긴 에너지", startPage: 116),
                SmallTextBookChapter(chapter: 3, title: "일상생활에서의 위치 에너지와 운동 에너지", startPage: 120),
            ]),
        ]),
        
        LargeTextBookChapter(chapter: 4, title: "자극과 반응", midChapters: [
            MidTextBookChapter(chapter: 1, title: "감각 기관", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "시각을 담당하는 감각 기관", startPage: 130),
                SmallTextBookChapter(chapter: 2, title: "청각과 피부 감각을 담당하는 감각 기관", startPage: 134),
                SmallTextBookChapter(chapter: 3, title: "미각과 후각을 담당하는 감각 기관", startPage: 136),
            ]),
            MidTextBookChapter(chapter: 2, title: "신경계와 호르몬", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "자극을 전달하는 신경계", startPage: 142),
                SmallTextBookChapter(chapter: 2, title: "신경계를 통해 일어나는 반응", startPage: 146),
                SmallTextBookChapter(chapter: 3, title: "몸의 기능을 조절하는 호르몬", startPage: 150),
            ]),
        ]),
        
        LargeTextBookChapter(chapter: 5, title: "생식과 유전", midChapters: [
            // 교과서(1.생식) = 문제지3-2(1.새포 분열, 2.사람의 발생)
            // 각각 소단원 (1,2,3), (4)
            MidTextBookChapter(chapter: 1, title: "생식", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "세포 분열이 필요한 까닭", startPage: 162),
                SmallTextBookChapter(chapter: 2, title: "염색체 수가 유지되는 세포 분열", startPage: 164),
                SmallTextBookChapter(chapter: 3, title: "생식세포가 만들어지는 과정", startPage: 168),
                SmallTextBookChapter(chapter: 4, title: "수정란이 개체가 되는 과정", startPage: 170),
            ]),
            // 교과서(2.유전) = 문제지3-2(3.멘델의 유전 원리, 4.사람의 유전)
            // 각각 소단원 (1,2), (3,4)
            MidTextBookChapter(chapter: 2, title: "유전", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "멘델이 밝힌 유전 원리(1)", startPage: 176),
                SmallTextBookChapter(chapter: 2, title: "멘델이 밝힌 유전 원리(2)", startPage: 180),
                SmallTextBookChapter(chapter: 3, title: "사람의 유전을 연구하는 방법", startPage: 182),
                SmallTextBookChapter(chapter: 4, title: "모의 활동으로 알아보는 유전 현상", startPage: 188),
            ]),
        ]),
        
        LargeTextBookChapter(chapter: 6, title: "에너지 전환과 보존", midChapters: [
            MidTextBookChapter(chapter: 1, title: "역학적 에너지 전환과 보존", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "전환되는 역학적 에너지", startPage: 198),
                SmallTextBookChapter(chapter: 2, title: "보존되는 역학적 에너지", startPage: 200),
            ]),
            MidTextBookChapter(chapter: 2, title: "전기 에너지의 발생과 전환", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "자석의 운동으로 만든 전기 에너지", startPage: 208),
                SmallTextBookChapter(chapter: 2, title: "전환되는 전기 에너지", startPage: 212),
                SmallTextBookChapter(chapter: 3, title: "가전제품이 사용하는 전기 에너지의 양", startPage: 216),
            ]),
        ]),
        
        LargeTextBookChapter(chapter: 7, title: "별과 우주", midChapters: [
            // 교과서(1.별) = 문제지3-2(1.별까지의 거리, 2.별의 성질)
            // 각각 소단원 (1), (2,3)
            MidTextBookChapter(chapter: 1, title: "별", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "연주 시차로 구하는 별까지의 거리", startPage: 226),
                SmallTextBookChapter(chapter: 2, title: "밝기로 구하는 별까지의 거리", startPage: 230),
                SmallTextBookChapter(chapter: 3, title: "색으로 비교하는 별의 표면 온도", startPage: 232),
            ]),
            // 교과서(2.은하와 우주, 3.우주 탐사) = 문제지3-2(3.은하와 우주)
            MidTextBookChapter(chapter: 2, title: "은하와 우주", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "태양계를 포함한 우리은하", startPage: 238),
                SmallTextBookChapter(chapter: 2, title: "우리은하를 이루는 천체들", startPage: 240),
                SmallTextBookChapter(chapter: 3, title: "팽창하는 우주", startPage: 244),
            ]),
            // 위 주석과 같음
            MidTextBookChapter(chapter: 3, title: "우주 탐사", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "우주 이해를 위한 우주 탐사", startPage: 252),
                SmallTextBookChapter(chapter: 2, title: "21 세기에 이룬 우주 탐사 성과", startPage: 256),
            ]),
        ]),
        
        LargeTextBookChapter(chapter: 8, title: "과학기술과 인류 문명", midChapters: [
            MidTextBookChapter(chapter: 1, title: "과학기술과 인류 문명", smallChapters: [
                SmallTextBookChapter(chapter: 1, title: "인류 문명에 영향을 준 과학기술", startPage: 266),
                SmallTextBookChapter(chapter: 2, title: "과학 원리를 활용한 창의적 설계", startPage: 270),
            ]),
        ])
    ]
}
