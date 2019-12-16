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
                          completion: @escaping (Result<[Show], AppError>) -> ()) {
        
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
                    
                    let shows = searchResults.map{$0.show}
 
                    completion(.success(shows))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            }
        }
    }
}
