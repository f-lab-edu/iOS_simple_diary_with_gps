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
        
        Firestore.firestore().collection("mock").getDocuments { snapshot, err in
            
            if let err = err {
                DispatchQueue.main.async {
                    completion([], err)
                }
            }
            else
            {
                guard let posts = snapshot?.documents.compactMap({ snapshot in
                    let post = try? snapshot.data(as: Post.self)
                    return post
                })
                else {
                    DispatchQueue.main.async {
                        completion([], nil)
                    }
                    return
                }
                
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
            completion(error)
        }
    }
    
    func removePost(postId: String, completion: @escaping ((any Error)?) -> Void) {
 
        Firestore.firestore().collection("mock").document(postId).delete { err in
            completion(err)
        }
        
    }
    
    func reportPost(postId: String, completion: @escaping ((any Error)?) -> Void) {

    }
    
}
