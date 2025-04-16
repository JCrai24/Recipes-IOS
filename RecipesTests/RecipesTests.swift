//
//  RecipesTests.swift
//  RecipesTests
//
//  Created by Jacob Craig on 4/15/25.
//
import XCTest
@testable import Recipes

final class RecipesTests: XCTestCase {
    var recipeClient: RecipeClient!
    var imageCacheManager: ImageCacheManager!
    
    override func setUpWithError() throws {
        recipeClient = RecipeClient()
        imageCacheManager = ImageCacheManager()
        
    }
    
    func testMalformedData() async {
        let malformedDataUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json"

        do {
            _ = try await recipeClient.fetchRecipes(fromUrl: malformedDataUrl)
            XCTFail("No malformedData error was given")
        } catch let error as NetworkError {
            XCTAssertEqual(error, .malformedData, "Expected malformedData error but got\(error)")
        } catch {
            XCTFail("Unexpected error:\(error)")
        }
    }
    
    func testEmptyList() async throws {
        let emptyDataUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json"
        let recipes = try await recipeClient.fetchRecipes(fromUrl: emptyDataUrl)
        XCTAssertTrue(recipes.isEmpty, "Recipes is not an empty list")
    }
    
    
    func testImageSave() async throws {
        let imageUrls = [
        "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
        "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
        "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/large.jpg"
        ]
        for imageUrl in imageUrls{
            let cachedImage = try await ImageCacheManager.shared.setImage(imageUrl: imageUrl)
            XCTAssertNotNil(cachedImage, "Image should be pulled from disk")
        }
    }
    
    func testImageGetAfterSave() async throws {
        let imageUrl = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/dd936646-8100-4a1c-b5ce-5f97adf30a42/large.jpg"
        _ = try await ImageCacheManager.shared.setImage(imageUrl: imageUrl)
        let image = try await ImageCacheManager.shared.getImage(imageUrl: imageUrl)
        XCTAssertNotNil(image, "Image should be retrieved.")
    }
    
    
}
