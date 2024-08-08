//
//  Post.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 7/25/24.
//

import Foundation
import CoreLocation

struct Post {
    var postId : Int
    var contents : String
    var createdDate : Date
    var location : CLLocationCoordinate2D
}
