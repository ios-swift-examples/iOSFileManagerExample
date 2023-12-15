//
//  FileListScreen.swift
//  iOSFileManagerExample
//
//  Created by 영준 이 on 2023/12/14.
//

import SwiftUI

struct FileListScreen: View {
    @ObservedObject var viewModel: FileListViewModel = .init()
    @State var isPresentingCreateAlert: Bool = false
    @State var createType: ChildType = .directory
    @State var newName: String = ""
    
    enum ChildType {
        case directory
        case file
    }
    
    init(directory: URL? = nil) {
        guard let directory else {
            return
        }
       
        viewModel.directory = directory
    }
    
    var body: some View {
        VStack {
            List(viewModel.contents, id: \.lastPathComponent) { content in
                NavigationLink{
                    FileListScreen(directory: content)
                } label: {
                    HStack {
                        Text(content.lastPathComponent)
                        Spacer()

                        Text(content.isDirectory ? "" : content.size?.fileSize ?? "")
                    }
                }
                
//                NavigationLink(value: content) {
//                    //
//                }
//                .overlay{
//                    HStack {
//                        Text(content.lastPathComponent)
//                        Spacer()
//                        
//                        Text(content.isDirectory ? "" : content.size?.fileSize ?? "")
//                    }
//                }
//                .disabled(!content.isDirectory)
//                .navigationDestination(for: URL.self) { url in
//                    FileListScreen(directory: url)
//                    
//                }
            }
            HStack(spacing: 16) {
                Button {
                    createType = .directory
                    isPresentingCreateAlert = true
                } label: {
                    Text("Create Directory")
                }
                Button {
                    createType = .file
                    isPresentingCreateAlert = true
                } label: {
                    Text("Create File")
                }
            }
            
        }
        .navigationTitle(viewModel.directory.lastPathComponent)
        .onAppear(perform: {
            do {
                try viewModel.loadChildren()
            }catch let error {
                fatalError()
            }
        })
        .alert("Create \(createType == .directory ? "Directory" : "file")", isPresented: $isPresentingCreateAlert) {
            TextField("Name", text: $newName)
            Button("Create") {
                do {
                    switch createType {
                    case .directory:
                        try viewModel.createDirectory(newName)
                    case .file:
                        try viewModel.createFile(newName)
                    }
                    
                    newName = ""
                    isPresentingCreateAlert = false
                }catch {
                    
                }
                
            }
            Button("Cancel") {
                isPresentingCreateAlert = false
            }
        } message: {
            Text("Input new \(createType == .directory ? "directory" : "file" ) name")
        }
    }
}

#Preview {
    NavigationStack {
        FileListScreen()
    }
    
}
