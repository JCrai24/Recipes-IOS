//
//  RecipeListView.swift
//  Recipes
//
//  Created by Jacob Craig on 4/14/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject var viewModel = RecipeListViewModel()
    
    var body: some View {
        NavigationStack {
            GeometryReader { geomtry in
                ScrollView {
                    VStack {
                        TextField("Search...", text: $viewModel.filter)
                            .padding(15)
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color(.systemGray6))
                            )
                        
                        if (viewModel.loadingError != nil){
                            VStack {
                                Spacer()
                                Text(viewModel.loadingError ?? "Unable to Load Recipes")
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 25))
                                Spacer()
                            }
                            .frame(height: geomtry.size.height - 100)
                            
                        } else if viewModel.recipes.isEmpty {
                            VStack {
                                Spacer()
                                Text("No Recipes Are Available")
                                    .foregroundColor(.gray)
                                    .multilineTextAlignment(.center)
                                    .font(.system(size: 25))
                                Spacer()
                            }
                            .frame(height: geomtry.size.height - 100)
                        }
                        else {
                            ForEach(viewModel.filteredRecipes, id: \.uuid) { recipe in
                                NavigationLink(destination: RecipePage(recipe: recipe)) {
                                    HStack(alignment: .top) {
                                        if let url = recipe.photo_url_small {
                                            CachedImage(imageUrl: url)
                                                .frame(height: 120)
                                                .cornerRadius(20)
                                        }
                                        VStack(alignment: .leading) {
                                            Text(recipe.name)
                                                .bold()
                                            Text("\(recipe.cuisine)")
                                        }
                                        .foregroundColor(.black)
                                        .padding(10)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                    .background(
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(Color(.systemGray6))
                                            .frame(maxWidth: .infinity)
                                    )
                                    .padding(10)
                                }
                            }
                         }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                .refreshable {
                    await viewModel.loadRecipes()
                }
            }
        }
    }
}


#Preview {
    RecipeListView()
}
