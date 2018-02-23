//
//  FileProviderItem.swift
//  ownCloudExtAppFileProvider
//
//  Created by Pablo Carrascal on 06/11/2017.
//

import Foundation
import MobileCoreServices

public enum ItemType {
    case directory
    case file
}


class FileProviderItem: NSObject, NSFileProviderItem {
    
    var itemIdentifier: NSFileProviderItemIdentifier
    var parentItemIdentifier: NSFileProviderItemIdentifier
    var filename: String
    var typeIdentifier: String
    var isShared: Bool
    var childItemCount: NSNumber?
    var isDownloaded: Bool
    
    // MARK: Properties
    var type: ItemType
    var size: Int
    var lastModified: Date
    
    init(ocFile: tableMetadata) {
        //print("LOG ---> item's name = \(ocFile.fileName!.removingPercentEncoding!) & id = \(ocFile.idFile)")
        self.itemIdentifier = NSFileProviderItemIdentifier("\(ocFile.fileID)")
        if #available(iOSApplicationExtension 11.0, *) {
            self.parentItemIdentifier = NSFileProviderItemIdentifier.init("\(ocFile.fileID)")
        } else {
            self.parentItemIdentifier = NSFileProviderItemIdentifier("test")
        }
        self.filename = ocFile.fileName
        self.typeIdentifier = kUTTypePNG as String
        
        if ocFile.directory {
            self.type = .directory
        } else {
            self.type = .file
        }
        
        self.size = Int(ocFile.size)
        // TODO: need to get the last modified.
        self.lastModified = Date()
        
        // EXTRAz
        self.isShared = false
        self.childItemCount = 10
        self.isDownloaded = false
    }
    
    init(root: Bool, ocFile: tableMetadata){
        //print("LOG ---> item's name = \(ocFile.fileName!.removingPercentEncoding!) & id = \(ocFile.idFile)")
        self.itemIdentifier = NSFileProviderItemIdentifier("\(ocFile.fileID)")
        if #available(iOSApplicationExtension 11.0, *) {
            self.parentItemIdentifier = NSFileProviderItemIdentifier.rootContainer
        } else {
            self.parentItemIdentifier = NSFileProviderItemIdentifier("test")
        }
        self.filename = ocFile.fileName.removingPercentEncoding!
        self.typeIdentifier = kUTTypePNG as String
        
        if ocFile.directory {
            self.type = .directory
        } else {
            self.type = .file
        }
        
        self.size = Int(ocFile.size)
        // TODO: need to get the last modified.
        self.lastModified = Date()
        
        // EXTRA
        self.isShared = false
        self.childItemCount = 10
        self.isDownloaded = false
    }
    
    init(dummy: String) {
        self.itemIdentifier = NSFileProviderItemIdentifier("dummy"
        )
        if #available(iOSApplicationExtension 11.0, *) {
            self.parentItemIdentifier = NSFileProviderItemIdentifier.rootContainer
        } else {
            self.parentItemIdentifier = NSFileProviderItemIdentifier(dummy)
        }

        
        self.filename = dummy
        self.typeIdentifier = kUTTypePDF as String
        self.type = .directory
        self.size = 40
        self.lastModified = Date()
        
        // EXTRA
        self.isShared = true
        self.childItemCount = 10
        self.isDownloaded = false
    }
    
    deinit {
        print("\(filename) item is being deallocated")
    }
    
    var capabilities: NSFileProviderItemCapabilities {
        // Limit the capabilities, add new capabilities when we support them
        // https://developer.apple.com/documentation/fileprovider/nsfileprovideritemcapabilities
        return [ .allowsAddingSubItems, .allowsContentEnumerating, .allowsReading ]

//        return .allowsAll

//        switch self.type {
//        case .directory:
//            // TODO: .allowsDeleting (only if dir is empty), .allowTrashing(?), .allowsWriting
//            return [ .allowsAddingSubItems, .allowsContentEnumerating, .allowsReading ]
//        case .file:
//            // TODO: figure out what to do here. This could either be a folder or a file.
//            return [.allowsDeleting, .allowsRenaming, .allowsReparenting, .allowsTrashing, .allowsWriting, .allowsReading]
//        }
    }
}
