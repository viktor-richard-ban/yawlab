//
//  ContentView.swift
//  YawLab
//
//  Created by Viktor Bán on 2025. 12. 21..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            ContextSelector()
        } detail: {
            Text("Selected")
        }
    }
}

#Preview {
    ContentView()
}
