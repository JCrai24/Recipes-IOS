//
//  RecipeListViewModel.swift
//  Recipes
//
//  Created by Jacob Craig on 4/12/25.
//

import Foundation

@MainActor
class RecipeListViewModel: ObservableObject{
    @Published var recipes: [Recipe] = []
    @Published var filter: String = ""
    @Published var loadingError: String?
    let client = RecipeClient()
    
    init() {
        Task {
           await loadRecipes()
        }
    }
    
    var filteredRecipes: [Recipe] {
            return recipes.filter { recipe in
                recipe.name.lowercased().hasPrefix(filter.lowercased())
            }
        }
    
    func loadRecipes() async {
        do {
            recipes = try await client.fetchRecipes(fromUrl: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
            loadingError = nil
        }catch NetworkError.malformedData{
            loadingError = "Unable to Load Recipes"
        }catch NetworkError.badResponse, NetworkError.badUrl{
            loadingError = "Unable to Connect to Network"
        }catch{
            recipes = []
        }
    }
}
