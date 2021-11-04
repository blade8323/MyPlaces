//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Владислав Соколов on 18.10.2021.
//

import Foundation
import UIKit

protocol PlaceProtocol {
    var name: String {get set}
    var location: String? {get set}
    var type: String? {get set}
    var image: UIImage? {get set}
    var restaurantImage: String? {get set}
}

struct Place: PlaceProtocol {
    var name: String
    var location: String?
    var type: String?
    var image: UIImage?
    var restaurantImage: String?
    
    static let restaurantNames = [
        "Burger Heroes", "Kitchen", "Bonsai", "Дастархан",
        "Индокитай", "X.O", "Балкан Гриль", "Sherlock Holmes",
        "Speak Easy", "Morris Pub", "Вкусные истории",
        "Классик", "Love&Life", "Шок", "Бочка"
    ]

    static func getPlaces() -> [PlaceProtocol] {
        var places = [PlaceProtocol]()
        for place in restaurantNames {
            places.append(Place(name: place, location: "Уфа", type: "Ресторан", image: nil, restaurantImage: place))
        }
        
        return places
    }
    
}
