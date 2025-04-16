//
//  ImageLoader.swift
//  Recipes
//
//  Created by Jacob Craig on 4/14/25.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage? = nil
    
    
    func loadImage(imageUrl: String) async {
        
        do {
            // Try to pull from memory or disk (whatever is immediately available)
            if let image = try await ImageCacheManager.shared.getImage(imageUrl: imageUrl) {
                DispatchQueue.main.async {
                    self.image = image
                }
                
                return
            }
            //If no image in cache, add to cache and pull image immediately
            if let image = try await ImageCacheManager.shared.setImage(imageUrl: imageUrl){
                DispatchQueue.main.async {
                    self.image = image
                }
                return
            }
            
        } catch {
            image = nil
        }
       
    }
}
