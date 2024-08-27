//
//  FirebaseRepository.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 8/20/24.
//

import Foundation
import CoreLocation
import FirebaseFirestore
import FirebaseCore


struct FirebasePostRepository : PostRepository {

    
    func loadPosts(completion: @escaping ([Post] , (any Error)?) -> Void) {
        
        let docRef = Firestore.firestore().collection("mock").getDocuments { snapshot, err in
            
            if let err = err {
                print(err)
            }
            else
            {
                if let snapshot = snapshot {
                    let posts = snapshot.documents.map { document in
                        let data = document.data()
                        let createdDate = data["createdDate"] as! Timestamp
                        let location = data["location"] as! [String : Double]
                        
                        return Post.init(postId: document.documentID, contents: data["contents"] as! String, createdDate: createdDate.dateValue(), location: Post.Coordinate(long:location["long"]! , lat: location["lat"]!))
                    } as! [Post]
                    
                    DispatchQueue.main.async {
                    completion(posts, nil)
                    }
                }
            }
            
        }
    
                
//        let post1 = Post(postId: 0, contents: "hello", createdDate: Date(), location: Post.Coordinate.init(long: 0, lat: 0))
//                let post2 = Post(postId: 1, contents: "good\nnight", createdDate: Date(), location: Post.Coordinate.init(long: 0, lat: 0))
//                let post3 = Post(postId: 2, contents: "longer\npost\nlonger\npost\n", createdDate: Date(), location: Post.Coordinate.init(long: 0, lat: 0))
//        
//                DispatchQueue.main.async {
//                    completion([post1, post2, post3], nil)
//                }
    }
    
    func addPost(post: Post, completion: @escaping ((any Error)?) -> Void) {
        
        do
        {
            try Firestore.firestore().collection("mock").addDocument(from: post)
        }
        catch
        {
            NSLog("\(error) \(#function)")
        }
    }
    
    func removePost(postId: String, completion: @escaping ((any Error)?) -> Void) {
 
    }
    
    func reportPost(postId: String, completion: @escaping ((any Error)?) -> Void) {

    }
    
}
