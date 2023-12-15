//
//  URL+.swift
//  iOSFileManagerExample
//
//  Created by 영준 이 on 2023/12/14.
//

import Foundation

extension URL {
    var isDirectory: Bool{
        var is_dir : ObjCBool = ObjCBool.init(false);
        FileManager.default.fileExists(atPath: self.path, isDirectory: &is_dir);
        
        return is_dir.boolValue;
    }
    
    var attributes: [FileAttributeKey : Any]? {
        try? FileManager.default.attributesOfItem(atPath: self.path)
    }
    
    var size: Int64? {
        guard self.isFileURL else {
            return nil
        }
        
        return attributes?[.size] as? Int64 ?? 0
    }
}
