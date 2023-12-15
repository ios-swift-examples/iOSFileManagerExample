//
//  ContentView.swift
//  iOSFileManagerExample
//
//  Created by 영준 이 on 2023/12/14.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            FileListScreen()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
