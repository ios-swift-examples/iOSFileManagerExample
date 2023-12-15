//
//  FileListViewModel.swift
//  iOSFileManagerExample
//
//  Created by 영준 이 on 2023/12/14.
//

import Foundation

let fileManager = FileManager.default

class FileListViewModel : ObservableObject {
    @Published var directory: URL
    
    @Published var contents: [URL] = []
    
    init(directory: URL? = FileManager.default.urls(for: .documentDirectory,
                                                   in: .userDomainMask).first) {
        self.directory = directory!
    }
    
    func loadChildren() throws {
        
        self.contents = try fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            .sorted(by: { ($0.isDirectory && !$1.isDirectory)
                || ($0.isDirectory == $1.isDirectory && $0.lastPathComponent < $1.lastPathComponent)
            })
        
        debugPrint("loadChildren \(directory.lastPathComponent) - \(self.contents.count)")
    }
    
    func createDirectory(_ name: String) throws{
        let newUrl = directory.appending(path: name)
        
        try fileManager.createDirectory(at: newUrl, withIntermediateDirectories: false)
        
        try self.loadChildren()
    }
    
    func createFile(_ name: String) throws{
        let newUrl = directory.appending(path: name).appendingPathExtension("file")
        
        let data = name.data(using: .utf8)
        guard fileManager.createFile(atPath: newUrl.path, contents: data) else {
            return
        }
        
        try data?.write(to: newUrl)
        
        try self.loadChildren()
    }
}
