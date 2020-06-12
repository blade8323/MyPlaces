//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Владислав Соколов on 12.06.2020.
//  Copyright © 2020 Владислав Соколов. All rights reserved.
//

import Foundation

struct Place {
    var name: String
    var location: String
    var type: String
    var image: String
    
    private static var myFavouriteRestaurants = ["Длинный нос", "Чайхана", "Hound", "Sheamus", "Diesel Room"]

    static func getPlaces() -> [Place] {
        var places = [Place]()
        
        for place in myFavouriteRestaurants {
            places.append(Place(name: place, location: "Пермь", type: "Ресторан", image: place))
        }
        
        return places
    }
}
