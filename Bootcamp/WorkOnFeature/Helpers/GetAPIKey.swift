import Foundation

func getAPIKey() -> String? {
    guard let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
          let dict = NSDictionary(contentsOfFile: path),
          let apiKey = dict["apiKeyNews"] as? String else {
        return nil
    }
    return apiKey
}
