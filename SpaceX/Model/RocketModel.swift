//
//  Rocket.swift
//  SpaceX
//
//  Created by Victor Shinya on 27/08/19.
//  Copyright © 2019 Victor Shinya. All rights reserved.
//

import Foundation

struct RocketModel: Codable {
    
    // MARK: - Properties
    
    var rocket_id: String
    var rocket_name: String
    var flickr_images: [String]
}
