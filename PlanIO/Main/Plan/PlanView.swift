//
//  PlanView.swift
//  PlanIO
//
//  Created by Anjin on 5/17/24.
//

import SwiftUI

struct PlanView: View {
    var body: some View {
        NavigationSplitView {
            VStack {
                List {
                    Text("first")
                    Text("second")
                    Text("third")
                    Text("fourth")
                }
            }
            .navigationTitle("Title")
        } detail: {
            VStack {
                HStack {
                    Text("hello")
                    Spacer()
                    Text("hello")
                }
                
                Spacer()
                Text("calendarView")
                Spacer()
            }
        }
    }
}

#Preview {
    PlanView()
}
