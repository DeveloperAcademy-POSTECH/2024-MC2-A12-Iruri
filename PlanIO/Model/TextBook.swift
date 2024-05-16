//
//  TextBook.swift
//  PlanIO
//
//  Created by Anjin on 5/16/24.
//

import SwiftUI

struct LargeTextBookChapter {
    let id: Int
    let title: String
    let midChapters: [MidTextBookChapter]
}

struct MidTextBookChapter {
    let id: Int
    let title: String
    let smallChapters: [SmallTextBookChapter]
}

struct SmallTextBookChapter {
    let id: Int
    let title: String
    let startPage: Int
}

struct TextBook {
    let contents: [LargeTextBookChapter] = [
        LargeTextBookChapter(id: 1, title: "화학 반응의 규칙과 에너지 변화", midChapters: [
            MidTextBookChapter(id: 1, title: "물질 변화와 화학 반응식", smallChapters: [
                SmallTextBookChapter(id: 1, title: "주변에서 일어나는 물질 변화", startPage: 12),
                SmallTextBookChapter(id: 2, title: "화학 반응을 나타내는 화학 반응식", startPage: 16)
            ])
        ])
    ]
}
