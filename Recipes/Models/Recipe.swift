//
//  Recipe.swift
//  Recipes
//
//  Created by Jacob Craig on 4/12/25.
//

import Foundation

struct Recipe: Decodable, Hashable {
    let uuid: String
    let name: String
    let cuisine: String
    let photo_url_large: String?
    let photo_url_small: String?
    let source_url: String?
    let youtube_url: String?
}
