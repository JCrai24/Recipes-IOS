//
//  CachedImage.swift
//  Recipes
//
//  Created by Jacob Craig on 4/14/25.
//

import SwiftUI

struct CachedImage: View {
    var imageUrl: String
    @StateObject var imageLoader = ImageLoader()
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
            }
        }
        .onAppear {
            Task {
                await imageLoader.loadImage(imageUrl: imageUrl)
            }
        }
    }
}

#Preview {
    CachedImage(imageUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/large.jpg")
}
