//
//  Post.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 7/25/24.
//

import Foundation
import CoreLocation
import FirebaseFirestore


struct Post : Codable {
    
    @DocumentID var id : String?
    
    struct Coordinate : Codable {
        var long : Double
        var lat  : Double
    }
    
    var city : String 
    var contents : String
    var createdDate : Date
    var location : Coordinate
}
