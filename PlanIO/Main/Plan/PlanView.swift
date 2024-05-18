//
//  PlanView.swift
//  PlanIO
//
//  Created by Anjin on 5/17/24.
//

import SwiftUI

struct PlanView: View {
    @State private var date = Date()
    
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
                
                CalenderView(month: date)
                    .padding(.horizontal, 20)
            }
        }
    }
}

#Preview {
    PlanView()
}
