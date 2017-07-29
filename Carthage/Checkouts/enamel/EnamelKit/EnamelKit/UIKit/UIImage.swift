//
//  UIImage.swift
//  SwiftSkyUI
//
//  Created by Rankovic, Milos (Developer) on 09/08/2016.
//  Copyright © 2016 Sky. All rights reserved.
//

public extension CGImage {
    public var ui: UIImage { return UIImage(cgImage: self) }
}

extension UIImage {
    
    public convenience init?(named name: String, in bundle: Bundle) {
        self.init(named: name, in: bundle, compatibleWith: nil)
    }

    
    open static func with(width: UInt, height: UInt, color: UIColor) -> UIImage {
        return CGImage.with(width: width, height: height, color: color.cgColor).ui
    }
}

public extension UIImageView {
    
    public func load(_ url: URL, completion: @escaping (UIImage?, Error?) -> ()) {
        
        if let image = ImageCache.get(by: url.absoluteString) {
            completion(image, nil)
            return
        }
        URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            async {
                guard let data = data
                    else { completion(nil, error); return }
                
                guard let image = UIImage(data: data)
                    else { return }
                
                ImageCache.add(image, key: url.absoluteString)
                
                completion(image, error)
            }
        }.resume()
    }
}

extension UIImage {
    
    // FIXME: refactor using enamel layout apis
    public static func stitchImages(images: [UIImage], stackVertically: Bool = false) -> UIImage? {
        guard images.isNotEmpty
            else { return nil }
        
        var stitchedImages : UIImage!
        
        var maxWidth: CGFloat = 0
        var maxHeight: CGFloat = 0
        
        images.forEach {
            maxWidth = max($0.size.width, maxWidth)
            maxHeight = max($0.size.height, maxHeight)
        }

        var totalSize : CGSize, maxSize = CGSize(width: maxWidth, height: maxHeight)
        
        if stackVertically {
            totalSize = CGSize(width: maxSize.width, height: maxSize.height * (CGFloat)(images.count))
        } else {
            totalSize = CGSize(width: maxSize.width  * (CGFloat)(images.count), height: maxSize.height)
        }
        
        UIGraphicsBeginImageContext(totalSize)
        
        images.forEach { image in
            var rect: CGRect = .zero
            let offset = images.index{ $0 === image }!.cg
            
            if stackVertically {
                rect = CGRect(x: 0, y: maxSize.height * offset, width: maxSize.width, height: maxSize.height)
            } else {
                rect = CGRect(x: maxSize.width * offset, y: 0 , width: maxSize.width, height: maxSize.height)
            }
            
            image.draw(in: rect)
        }
        
        stitchedImages = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return stitchedImages
    }
}
