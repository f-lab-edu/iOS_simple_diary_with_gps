//
//  MockPostRepository.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 7/25/24.
//

import Foundation
import CoreLocation

struct MockPostRepository : PostRepository {

    
    func loadPosts(completion: @escaping ([Post] , (any Error)?) -> Void) {
        let post1 = Post(postId: 0, contents: "hello", createdDate: Date(), location: CLLocationCoordinate2D(latitude: 0, longitude: 0 ))
        let post2 = Post(postId: 1, contents: "good\nnight", createdDate: Date(), location: CLLocationCoordinate2D(latitude: 0, longitude: 0 ))
        let post3 = Post(postId: 2, contents: "longer\npost\nlonger\npost\n", createdDate: Date(), location: CLLocationCoordinate2D(latitude: 0, longitude: 0 ))
        
        DispatchQueue.main.async {
            completion([post1, post2, post3], nil)
        }
    }
    
    func addPost(post: Post, completion: @escaping ((any Error)?) -> Void) {
        DispatchQueue.main.async {
            completion(nil)
        }
    }
    
    func removePost(postId: Int, completion: @escaping ((any Error)?) -> Void) {
        DispatchQueue.main.async {
            completion(nil)
        }
    }
    
    func reportPost(postdId: Int, completion: @escaping ((any Error)?) -> Void) {
        DispatchQueue.main.async {
            completion(nil)
        }
    }
    
}
