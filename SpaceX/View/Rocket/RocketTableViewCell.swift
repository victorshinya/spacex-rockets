//
//  TableViewCell.swift
//  SpaceX
//
//  Created by Victor Shinya on 27/08/19.
//  Copyright © 2019 Victor Shinya. All rights reserved.
//

import UIKit

class RocketTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    // MARK: - UITableViewCell events
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        baseView.layer.cornerRadius = 12.0
        baseView.clipsToBounds = true
    }
}
