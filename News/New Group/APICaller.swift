//
//  APICaller.swift
//  News
//
//  Created by Никита Коголенок on 21.03.22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    struct Constants {
        static let topHeadlinesURL = URL(string: "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=ff72583d2c5c42369276f56a88f91362")
    }
    
    private init () {}
    
    public func getTopStories(completion: @escaping (Result<[String], Error>) -> Void) {
        guard let url = Constants.topHeadlinesURL else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    print("Articles: \(result.articles.count)")
                }
                catch {
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}
