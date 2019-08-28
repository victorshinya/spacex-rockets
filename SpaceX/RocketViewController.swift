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
        if let flickr_images = rockets[indexPath.row].flickr_images, let url = URL(string: flickr_images[0]) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.backgroundImage.image = image
                        }
                    }
                }
            }
        }
        if let rocket_name = rockets[indexPath.row].rocket_name {
            cell.title.text = rocket_name
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350.0
    }
    
    // MARK: - Functions
    
    private func fetchAll() {
        let session = URLSession.shared
        let url = URL(string: Constants.base_api + Constants.api_rockets)!
        let task = session.dataTask(with: url) { data, response, error in
            if error != nil, let err = error {
                print("error: \(err.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("wrong status code")
                return
            }
            
            guard let mime = response?.mimeType, mime == "application/json" else {
                print("wrong mime type")
                return
            }
            
            do {
                if let data = data {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    if let jsonArray = json {
                        for jsonObject in jsonArray {
                            let rocket_id = jsonObject["rocket_id"] as? String
                            let rocket_name = jsonObject["rocket_name"] as? String
                            let flickr_images = jsonObject["flickr_images"] as? [String]
                            self.rockets.append(Rocket(rocket_id: rocket_id, rocket_name: rocket_name, flickr_images: flickr_images))
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch {
                print("error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

