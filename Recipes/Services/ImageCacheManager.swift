//
//  ImageCache.swift
//  Recipes
//
//  Created by Jacob Craig on 4/13/25.
//

import Foundation
import SwiftUI

class ImageCacheManager {
    
    static let shared = ImageCacheManager()
    private let memoryCache = NSCache<NSString, UIImage>()
    
    func getImage(imageUrl: String) async throws -> UIImage? {
        let fileName = imageUrl.replacingOccurrences(of: "/", with: "_")
        
        //Skip loading from disk and use memory cache immediately
        if let cachedImage = memoryCache.object(forKey: fileName as NSString) {
            return cachedImage
        }
        
        //Pull image from disk
        let images = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imageURL = images.appendingPathComponent(fileName)
        
        // Return image from disk while caching it in memory
        if let image = UIImage(contentsOfFile: imageURL.path) {
            memoryCache.setObject(image, forKey: fileName as NSString)
            return image
        }
        return nil
    }
    
    func setImage(imageUrl: String) async throws -> UIImage? {
        //Fetch Image from url
        let fileName = imageUrl.replacingOccurrences(of: "/", with: "_")
        guard let url = URL(string: imageUrl) else { return nil}
        let (data, _) = try await URLSession.shared.data(from: url)
        
        //Convert data from url to UIImage
        guard let image = UIImage(data: data) else {
            return nil
        }
        //Cache to memory immediately
        memoryCache.setObject(image, forKey: fileName as NSString)
        
        //Asychronously download image to disk while loading image in UI
        Task.detached{
            try await self.downloadToDisk(fileName, data)
        }
        return image
        
    }
    
    
    func downloadToDisk(_ fileName: String,_ data: Data) async throws {
        let fileManager = FileManager.default
        let imagesDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let imageFileUrl = imagesDirectory.appendingPathComponent(fileName)
        try data.write(to: imageFileUrl)
    }
}
