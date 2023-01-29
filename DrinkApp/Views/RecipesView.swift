

import SwiftUI

struct RecipesView: View {
    @State var selectedTab = "mug"
    @StateObject var viewModel = RecipeViewModel()
    var body: some View {
        VStack{
            
                List {
                    ForEach(viewModel.recipes, id: \.self) { recipe in
                        
                        HStack{
//                            Image("StrawberryLimeade")
                            UrlImgView(urlString: recipe.imageLink)
                            VStack(alignment: .leading) {
                                Text(recipe.name)
                                    .font(.system(size: 30, weight: .bold))
                                
                                Button {
                                    print("btn tapped")
                                } label: {
                                    Image(systemName: "heart")
                                        .font(.system(size: 30, weight: .bold))
//                                        .foregroundColor(Color.red)
                                }
                                .buttonStyle(.bordered)
                                .tint(Color.appBlue)
                                

                                
                                
                            }
                            .padding(.leading, 50.0)
                            Spacer()
                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            print(recipe.recipeId)
                        }
                        .padding(3)
                        
                    }
                }
                .background(Color.white)
                .navigationTitle("Recipes")
                .onAppear {
                    viewModel.fetch()
                }

        }.background(Color.white)
    }
}

struct RecipesView_Previews: PreviewProvider {
    static var previews: some View {
        RecipesView()
    }
}
