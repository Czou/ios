//
//  FolderProviderItem.swift
//  ownCloudExtAppFileProvider
//
//  Created by Pablo Carrascal on 14/11/2017.
//

import UIKit
import MobileCoreServices

class FolderProviderItem: NSObject, NSFileProviderItem {
    var itemIdentifier: NSFileProviderItemIdentifier
    var parentItemIdentifier: NSFileProviderItemIdentifier
    var filename: String
    var typeIdentifier: String = ""
    
    var childItemCount: NSNumber?
    
    init(directory: tableMetadata, root: Bool) {
                
        self.itemIdentifier = NSFileProviderItemIdentifier("\(directory.fileID)")
        if #available(iOSApplicationExtension 11.0, *) {
            if root {
                self.parentItemIdentifier = NSFileProviderItemIdentifier.rootContainer
            } else {
                self.parentItemIdentifier = NSFileProviderItemIdentifier(rawValue: String(directory.fileID))
            }
        } else {
            self.parentItemIdentifier = NSFileProviderItemIdentifier("\(directory.fileID)")
        }
        
        self.filename = directory.fileName
        self.typeIdentifier = kUTTypeFolder as String
        
        //TODO: We need to change this with the real number of child files the folder has.
        self.childItemCount = 10
    }
    
    deinit {
        print("\(filename) item is being deallocated")
    }
    
    var capabilities: NSFileProviderItemCapabilities {
    // Limit the capabilities, add new capabilities when we support them
    // https://developer.apple.com/documentation/fileprovider/nsfileprovideritemcapabilities
    return [ .allowsAddingSubItems, .allowsContentEnumerating, .allowsReading ]
    }

}
