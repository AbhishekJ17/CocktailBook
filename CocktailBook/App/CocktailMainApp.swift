import SwiftUI

@main
struct CocktailMainApp: App {
    var body: some Scene {
        WindowGroup {
            CocktailListScreenBuilder.makeCocktailListView()
        }
    }
}

