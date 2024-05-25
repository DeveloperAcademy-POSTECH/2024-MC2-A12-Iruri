//
//  PlanIOApp.swift
//  PlanIO
//
//  Created by Seol WooHyeok on 5/14/24.
//

import SwiftData
import SwiftUI

@main
struct PlanIOApp: App {
    var modelContainer: ModelContainer {
        let schema = Schema([Task.self, Plan.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            let container = try ModelContainer(for: schema, configurations: [configuration])
            return container
        } catch {
            fatalError("Model Create Fail")
        }
    }
    
    @Query var tasks: [Task]
    @State private var showAchieve: Bool = false
    
    var body: some Scene {
        WindowGroup {
//            NavigationStack {
//                VStack {
////                    if tasks.isEmpty {
//                    if showAchieve == false {
//                        EmptyAchieveView()
//                    } else {
//                        AchieveView()
//                    }
//                    
//                    Button {
//                        showAchieve.toggle()
//                    } label: {
//                        Text(showAchieve ? "계획 세우기 화면으로" : "실천화면으로")
//                    }
//                }
//            }
            
            PlanView()
        }
        .modelContainer(modelContainer)
    }
}
