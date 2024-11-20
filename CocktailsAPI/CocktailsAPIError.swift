import Foundation

enum CocktailsAPIError: Error, LocalizedError {
    case unavailable
    case parsingFailed
    
    var errorDescription: String? {
        return "Unable to retrieve cocktails, API unavailable"
    }
}
