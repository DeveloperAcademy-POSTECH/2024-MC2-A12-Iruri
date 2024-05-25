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
    
    @State private var inputData: InputData = InputData()
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(inputData)
        }
        .modelContainer(modelContainer)
    }
}

struct MainView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var tasks: [Task]
    
    var body: some View {
        NavigationStack {
            VStack {
                if tasks.isEmpty {
                    // Task가 없다면 계획 세우러 가는 화면으로
                    EmptyAchieveView()
                } else {
                    // Task가 있다면 실천화면으로
                    AchieveView()
                }
            }
        }
    }
}
