//
//  SearchCell.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Yuliia Engman on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {
    
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var showNameLabel: UILabel!
    @IBOutlet weak var showRatingLabel: UILabel!
    
    func configureCell(for show: Show) {
        showNameLabel.text = show.name
        
        guard let imageURLString = show.image?.original else {
            // TODO set a default image
            return
        }
        
        showImage.getImage(with: imageURLString) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.showImage.image =
                        UIImage(systemName: "play.rectangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.showImage.image = image
                }
            }
        }
    }
}
