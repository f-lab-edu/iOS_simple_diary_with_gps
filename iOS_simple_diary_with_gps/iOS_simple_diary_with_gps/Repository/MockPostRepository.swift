//
//  MockPostRepository.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 7/25/24.
//

import Foundation

struct MockPostRepository : PostRepository {
    func loadPosts() -> [Post] {
        let post1 = Post(contents: "hello")
        let post2 = Post(contents: "good\nnight")
        let post3 = Post(contents: "longer\npost\nlonger\npost\n")
        
        return [post1, post2, post3]
    }
    
    func addPost(post: Post) -> Bool {
        return true
    }
    
    func removePost(post: Post) -> Bool {
        return true
    }
    
    
}
