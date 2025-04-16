//
//  NetworkManager.swift
//  Recipes
//
//  Created by Jacob Craig on 4/12/25.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case malformedData
    case badResponse
}

struct RecipesResponse: Decodable {
    let recipes: [Recipe]
}

class RecipeClient{
    func fetchRecipes(fromUrl: String) async throws -> [Recipe] {
        var recipes: [Recipe]
        guard let url = URL(string: fromUrl) else { throw NetworkError.badUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        //Format JSOn response in an array of Recipe objects
        do {
            let decoder = JSONDecoder()
            let recipeResponse = try decoder.decode(RecipesResponse.self, from: data)
            recipes = recipeResponse.recipes
        } catch {
            throw NetworkError.malformedData
        }
        return recipes
    }
}



