//
//  UInt64+.swift
//  iOSFileManagerExample
//
//  Created by 영준 이 on 2023/12/14.
//

import Foundation

extension Int64 {
    var fileSize: String {
        return ByteCountFormatter.string(fromByteCount: Int64(self), countStyle: .file);
    }
}
