//
//  RocketAPI.swift
//  SpaceX
//
//  Created by Barış Uyar on 1.06.2020.
//  Copyright © 2020 Victor Shinya. All rights reserved.
//

import Foundation

protocol RocketAPIContract {
    func retrieveRocketList(_ completion: @escaping (Result<[Rocket], Error>) -> ())
}

final class RocketAPI: RocketAPIContract {
    
    func retrieveRocketList(_ completion: @escaping (Result<[Rocket], Error>) -> ()) {
        let session = URLSession.shared
        let url = URL(string: Constants.base_api + Constants.api_rockets)!
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            do {
                if let data = data {
                    let rockets = try JSONDecoder().decode([Rocket].self, from: data)
                    completion(.success(rockets))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
