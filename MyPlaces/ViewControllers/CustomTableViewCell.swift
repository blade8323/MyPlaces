//
//  CustomTableViewCell.swift
//  MyPlaces
//
//  Created by Владислав Соколов on 12.06.2020.
//  Copyright © 2020 Владислав Соколов. All rights reserved.
//

import UIKit
import Cosmos

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var imageOfPlace: UIImageView! {
        didSet {
            imageOfPlace?.layer.cornerRadius = imageOfPlace.frame.size.height / 2
            imageOfPlace?.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var LocationLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet var cosmosRaiting: CosmosView! {
        didSet {
            cosmosRaiting.settings.updateOnTouch = false
        }
    }
    
}
