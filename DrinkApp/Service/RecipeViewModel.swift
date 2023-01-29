

import Foundation
class RecipeViewModel: ObservableObject {
    @Published var recipes: [RecipeModel] = []
    func fetch() {
        guard let url = URL(string: "https://da-recipes.azurewebsites.net/api/v1/recipes") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, _,
            error in
            guard let data = data, error == nil else {
                return
            }
            
            // convert to json
            do{
                let recipes = try JSONDecoder().decode([RecipeModel].self, from: data)
                DispatchQueue.main.async {
                    self?.recipes = recipes
                }
            }
            catch{
                print(error)
            }
        }
        task.resume()
    }
}

struct RecipeModel: Hashable, Codable {
    let recipeId: UUID
    let name: String
    let ingredients: [String: String]
    let instructions: String
    let visible: Bool
    let imageLink: String?
}
