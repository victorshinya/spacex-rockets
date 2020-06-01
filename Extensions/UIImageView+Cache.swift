//
//  UIImageView+Cache.swift
//  SpaceX
//
//  Created by Barış Uyar on 1.06.2020.
//  Copyright © 2020 Victor Shinya. All rights reserved.
//

import UIKit
let imageCache = NSCache<NSString, UIImage>()

public extension UIImageView {
    
    func loadImageWithUrl(urlString: String) {
        
        DispatchQueue.main.async {
            self.image = nil
        }
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                self.image = cachedImage
            }
            return
        }
        
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { (data, response, error) in
                if let unwrappedError = error {
                    print(unwrappedError)
                    return
                }
                
                if let unwrappedData = data, let downloadedImage = UIImage(data: unwrappedData) {
                    DispatchQueue.main.async(execute: {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        self.image = downloadedImage
                    })
                }
                
            }
            dataTask.resume()
        }
    }
}
