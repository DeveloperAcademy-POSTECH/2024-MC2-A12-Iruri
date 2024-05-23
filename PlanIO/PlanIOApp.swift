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
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                if tasks.isEmpty {
                    EmptyAchieveView()
                } else {
                    AchieveView()
                }
            }
        }
        .modelContainer(modelContainer)
    }
}
