//
//  RecipePage.swift
//  Recipes
//
//  Created by Jacob Craig on 4/14/25.
//

import SwiftUI

struct RecipePage: View {
    let recipe: Recipe
    
    var body: some View {
        VStack {
            if let url = recipe.photo_url_large {
                CachedImage(imageUrl: url)
                    .frame(height: 300)
                    .cornerRadius(20)
            }
            Text(recipe.name)
                .bold()
                .font(.system(size: 25))
            
        }
    }
}

#Preview {
    RecipePage(
        recipe: Recipe(
            uuid: "1",
            name: "Some Kind of Pie",
            cuisine:"British",
            photo_url_large: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
            photo_url_small: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
            source_url: "",
            youtube_url: ""
        ))
}
