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
        
        Firestore.firestore().collection("mock").whereField("city", isEqualTo: "성남").getDocuments { snapshot, err in
            
            if let err = err {
                print(err)
            }
            else
            {
                let posts = snapshot?.documents.compactMap({ snapshot in
                    let post = try? snapshot.data(as: Post.self)
                    return post
                }) as! [Post]
                
                DispatchQueue.main.async {
                    completion(posts, nil)
                }
            }
        }
    }
    
    func addPost(post: Post, completion: @escaping ((any Error)?) -> Void) {
        do
        {
            try Firestore.firestore().collection("mock").addDocument(from: post) { err in
                completion(err)
            }
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
