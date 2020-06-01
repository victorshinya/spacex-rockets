//
//  ViewController.swift
//  SpaceX
//
//  Created by Victor Shinya on 27/08/19.
//  Copyright © 2019 Victor Shinya. All rights reserved.
//

import UIKit

class RocketViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Global variables
    
    lazy var rockets = [Rocket]()
    private let api: RocketAPIContract = RocketAPI()
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle events
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchAll()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rockets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rocketCell", for: indexPath) as! RocketTableViewCell
        cell.backgroundImage.loadImageWithUrl(urlString: rockets[indexPath.row].flickr_images[0])
        cell.title.text = rockets[indexPath.row].rocket_name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350.0
    }
    
    // MARK: - Functions
    
    private func fetchAll() {
        api.retrieveRocketList { (result) in
            switch result {
            case .success(let rocketList):
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.rockets = rocketList
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

