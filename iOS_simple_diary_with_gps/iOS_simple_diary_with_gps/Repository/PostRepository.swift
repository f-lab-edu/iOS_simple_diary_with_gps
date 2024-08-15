//
//  PostRepository.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 7/25/24.
//

import Foundation

protocol PostRepository {
    func loadPosts( completion: @escaping ([Post], Error?) -> Void)
    func addPost(post : Post, completion: @escaping (Error?) -> Void)// 구현체에서 date 추가
    func removePost(postId : Int, completion: @escaping (Error?) -> Void)
    func reportPost(postdId: Int, completion: @escaping (Error?) -> Void)
}
