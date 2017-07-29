//
//  ImageCache.swift
//  Enamel
//
//  Created by Prescott, Ste on 04/11/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

#if os(iOS)
    import UIKit
    public typealias ChachedImage = UIImage
#elseif os(macOS)
    import AppKit
    public typealias ChachedImage = NSImage
#endif

#if os(iOS) || os(macOS)
    
    public class ImageCache: Cache {
        
        public static var costLimit = 20 * 1000 * 1000 {
            didSet {
                cache.totalCostLimit = costLimit
            }
        }
        
        public static func add(_ image: ChachedImage, key: String? = nil) {
            let key = (key ?? image.key) as NSString
            cache.setObject(image, forKey: key, cost: image.cost)
        }
        
        public static func get(by key: String) -> ChachedImage? {
            return cache.object(forKey: key as NSString)
        }
        
        public static func clear() {
            cache.removeAllObjects()
        }
        
        private static let cache: NSCache<NSString, ChachedImage> = {
            let o = NSCache<NSString, ChachedImage>()
            o.totalCostLimit = costLimit
            o.name = "ImageCache"
            return o
        }()
    }
    
    extension ChachedImage: Cachable {
        
        public var key: String {
            return description
        }
        
        public var cost: Int {
            return Int(size.area)
        }
    }
#endif
