//
//  PostService.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 7/30/24.
//

import Foundation
import Combine
import CoreLocation

enum PostEvent {
    case postLoaded
    case postAdded(Post, Error?)
    case postRemoved(Post, Error?)
    case postReported(Post, Error?)
}

protocol PostService {
    
    var onPostEvent : AnyPublisher<PostEvent, Never> { get }
    var posts : [Post] { get }
    
    func loadPost(date : Date?, page : Int) // Date, page 파라미터 추가, //유저가 선택하는 정보
    func addPost(contents: String) // contents
    func removePost(postId : Int) // postId
    func reportPost(postId: Int) // postId
}

class PostServiceImp : PostService {
    
    
    var onPostEvent: AnyPublisher<PostEvent, Never> {
        subject.eraseToAnyPublisher()
    }
    
    var posts: [Post] = []
    let userId : String = "mockdata" // 모듈화시키기
    var currentLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0) //모듈화시키기. 계속 업데이트
    
    let repository : PostRepository = MockPostRepository()
    let subject : PassthroughSubject<PostEvent, Never> = PassthroughSubject<PostEvent, Never>()
    
    func loadPost(date : Date? = Date(), page : Int) {
        
        repository.loadPosts(){ [weak self] posts, error in
            if error == nil {
                self?.posts = posts
                self?.subject.send(.postLoaded)
            }
        }
        
        // date, gps, page

    }
    
    func addPost(contents: String) {
        
        //postId를 앱에서 생성해야하는지? 어떻게 생성해야할지가 고민입니다.
        var postId = 0
        let currentDate = Date()
        let newPost = Post(postId: postId, contents: contents, createdDate: currentDate, location: self.currentLocation)
        
        repository.addPost(post: newPost) { error in
            }
    }
    
    func removePost(postId: Int) {
        repository.removePost(postId: postId) { error in
            
        }
    }
    
    func reportPost(postId: Int) {
        repository.reportPost(postdId: postId) { error in
            
        }
    }
    
    
}
