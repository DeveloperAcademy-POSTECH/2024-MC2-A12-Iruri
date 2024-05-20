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
            MidWorkBookChapter(chapter: 1, title: "물질 변화와 화학 반응식")
        ])
    ]
}
