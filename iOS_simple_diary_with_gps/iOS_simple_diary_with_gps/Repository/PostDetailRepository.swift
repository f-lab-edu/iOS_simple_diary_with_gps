//
//  PostDetailRepository.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 8/18/24.
//

import Foundation


protocol PostDetailRepository {
    func loadPostDetail(postId: Int, completion: @escaping (PostDetail, Error?) -> Void)
    func addPost(post : Post, completion: @escaping (Error?) -> Void)
    func removePost(postId : Int, completion: @escaping (Error?) -> Void)
    func reportPost(postId: Int, completion: @escaping (Error?) -> Void)
}
