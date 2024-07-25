//
//  PostRepository.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 7/25/24.
//

import Foundation

protocol PostRepository {
    func loadPosts() -> [Post]
    func addPost(post : Post) -> Bool
    func removePost(post : Post) -> Bool
}
