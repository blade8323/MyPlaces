//
//  PlaceModel.swift
//  MyPlaces
//
//  Created by Владислав Соколов on 18.10.2021.
//

import Foundation
import RealmSwift

protocol PlaceProtocol {
    var name: String {get set}
    var location: String? {get set}
    var type: String? {get set}
    var imageData: Data? {get set}
}

class Place: Object {
    @objc dynamic var name = ""
    @objc dynamic var location: String?
    @objc dynamic var type: String?
    @objc dynamic var imageData: Data?
    @objc dynamic var date = Date()
    
    convenience init(name: String, location: String?, type: String?, imageData: Data?) {
        self.init()
        self.name = name
        self.location = location
        self.type = type
        self.imageData = imageData
    }
}
