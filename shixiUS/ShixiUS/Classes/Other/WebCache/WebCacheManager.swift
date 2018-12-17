//
//  WebCacheManager.swift
//  ShixiUS
//
//  Created by Michael 柏 on 2018/12/14.
//  Copyright © 2018 Shixi (Beijing)  Tchnology  Limited. All rights reserved.
//

import UIKit

// 缓存清除完毕的回掉block
typealias WebCacheClearCompletedBlock = (_ cacheSize: String) -> Void

// 缓存查询完毕后的回调Block, data返回类型包括NSString缓存文件路径, NSData格式缓存数据
typealias WebCacheQueryCompletedBlock = (_ data: Any?, _ hasCache: Bool) -> Void

// 网络资源下载进度的回调Block
typealias WebDownloaderProgressBlock  = (_ receivedSize: Int64, _ expectedSize: Int64) -> Void

// 网络资源下载完毕后的回调Block
typealias WebDownloaderCompletedBlock = (_ data: NSData?, _ error: Error?, _ finished: Bool) -> Void

// 网络资源下载取消后的回调Block
typealias WebDownloaderCancelBlock    = () -> Void

class WebCacheManager: NSObject {
    
    var memCache: NSCache<NSString, AnyObject>?
    var fileManager: FileManager = FileManager.default
    var diskCacheDirectoryURL: URL?
    var ioQueue: DispatchQueue?
    
    private static let instance = { () ->
        WebCacheManager in
        return WebCacheManager()
    }()
    
    private override init() {
        super.init()
        self.memCache       = NSCache()
        self.memCache?.name = "webCache"
        
        let paths           = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory,FileManager.SearchPathDomainMask.userDomainMask, true)
        let path            = paths.last
        let diskCachePath   = path! + "/webCache"
        
        var isDirectory:ObjCBool = false
        let isExisted       = fileManager.fileExists(atPath: diskCachePath, isDirectory: &isDirectory)
        
        if (!isDirectory.boolValue || !isExisted) {
            do{
                try  fileManager.createDirectory(atPath: diskCachePath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                SXLog("disk cache file error:" + error.localizedDescription)
            }
        }
        diskCacheDirectoryURL = URL(fileURLWithPath: diskCachePath)
        ioQueue               = DispatchQueue(label: "com.start.webcache")
    }
    
    class func shared() -> WebCacheManager {
        return instance
    }
    
    // 根据key值从内存和本地硬盘中查询缓存数据
//    func queryDataFromMemory(key: String, cacheQueryCompletedBlock: WebCacheQueryCompletedBlock) -> Operation {
//
//    }
    
    // 根据key值从内存和本地硬盘中查询缓存数据, 所查询缓存数据包含指定文件类型
//    func queryDataFormMemory(key: String, cacheQueryCompletedBlock: WebCacheQueryCompletedBlock, exten: String?) -> Operation {
//
//    }
//
//    func queryURLFormDiskMemory(key:String, cacheQueryCompletedBlock: WebCacheQueryCompletedBlock, exten: String) -> Operation {
//
//    }
    
    // 根据key值从内存中查询缓存数据
//    func dataFormMemoryCache(key: String) -> Data? {
//
//    }

    // 根据key值从本地磁盘中查询缓存数据
//    func dataFormDiskCache(key: String) -> Data? {
//
//    }
    
    // 根据key值从本地磁盘中查询缓存数据
//    func dataFormDiskCache(key: String, exten: String) -> Data? {
//
//    }
    
    // 存储缓存数据到内存和本地磁盘, 所查询缓存数据包含指定文件类型
//    func storeDataCache(data: Data?, key: String) {
//
//    }
    
    // 存储花村数据到内存
//    func storeDataToMemory(data: Data?, key: String) {
//
//    }

    
    
    
    
    
    
}









