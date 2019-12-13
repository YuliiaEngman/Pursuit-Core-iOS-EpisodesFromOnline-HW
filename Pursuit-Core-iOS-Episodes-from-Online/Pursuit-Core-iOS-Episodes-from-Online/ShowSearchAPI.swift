//
//  ShowSearchAPI.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Yuliia Engman on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowSearchAPI {
    static func fetchShow(for searchQuery: String,
                          completion: @escaping (Result<[ShowSearch], AppError>) -> ()) {
        
        let searchQuery = searchQuery.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "girls"
        
        // using string interpolation to buld endpoint url
        let showEndpointURL = "https://api.tvmaze.com/search/shows?q=\(searchQuery)"
        
        // Later we will look at URLComponents and URLQueryItems
        guard let url = URL(string: showEndpointURL) else {
            completion(.failure(.badURL(showEndpointURL)))
            return
        }
        let request = URLRequest(url: url)
        
        NetworkHelper.shared.performDataTask(with: request) {(result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):
                do {
                    let searchResults = try JSONDecoder().decode([ShowSearch].self, from: data)
                    
                    // 1. TODO: use searchResults to create an array of recipes
                    //let shows = searchResults.shows.map {$0.shows}
                    let shows = searchResults.map{$0.self}
                    // 2. TODO: capture the array of recipes in the completion handler
                    completion(.success(shows))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
