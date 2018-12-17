//
//  WebDownloader.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/12/14.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

class WebDownloader: NSObject {
    
    var downloadQueue: OperationQueue?
    private static let instance = { () -> WebDownloader in
       return WebDownloader()
    }()
    
    private override init() {
        super.init()
        downloadQueue       = OperationQueue()
        downloadQueue?.name = "com.start.webdownloader"
        downloadQueue?.maxConcurrentOperationCount = 8
    }
    
    class func shared() -> WebDownloader {
        return instance
    }
    
//    func download(url: URL, progress: @escaping , completed: @escaping , cancel: @escaping ) {
//
//        
//
//
//    }
    
    
    
    
}
