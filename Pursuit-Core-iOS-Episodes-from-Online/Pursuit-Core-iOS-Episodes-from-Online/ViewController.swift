//
//  ViewController.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Benjamin Stone on 9/5/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        ShowSearchAPI.fetchShow(for: "do") { (result) in
            switch result{
            case .failure(let error):
                print(error)
            case .success(let data):
                dump(data)
            }
        }
        // Do any additional setup after loading the view.
    }


}

