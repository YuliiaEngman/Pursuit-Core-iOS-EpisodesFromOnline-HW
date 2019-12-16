//
//  UIImageView+Extensions.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Yuliia Engman on 12/16/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

// here we crate an extension on UIImageView to hand off getting a UIImage using
// our URLSession wrapper class (NetworkHelper)

extension UIImageView {
  func getImage(with urlString: String,
                completion: @escaping (Result<UIImage, AppError>) -> ()) {
    
    guard let url = URL(string: urlString) else {
      completion(.failure(.badURL(urlString)))
      return
    }
    
    let request = URLRequest(url: url)
    
    NetworkHelper.shared.performDataTask(with: request) { (result) in
      switch result {
      case .failure(let appError):
        completion(.failure(.networkClientError(appError)))
      case .success(let data):
        if let image = UIImage(data: data) {
          completion(.success(image))
        }
      }
    }
  }
}

