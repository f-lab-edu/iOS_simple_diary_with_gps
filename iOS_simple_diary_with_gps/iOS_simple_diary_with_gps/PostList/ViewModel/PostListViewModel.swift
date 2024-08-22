//
//  PostListViewModel.swift
//  iOS_simple_diary_with_gps
//
//  Created by 김보라 on 8/8/24.
//

import Foundation
import Combine


class PostListViewModel {
    
    enum Event {
        case postUpdated
        case postAdded(Error?)
        case postRemoved(Error?)
        case postReported(Error?)
    }
    
    private var service : PostService
    private var cancellable : Set<AnyCancellable> = []
    private var subject : PassthroughSubject<Event, Never> = PassthroughSubject<Event, Never>()
    
    var onEvent : AnyPublisher<Event, Never> {
        subject.receive(on: DispatchQueue.main).eraseToAnyPublisher() //두번 인큐되지 않게 확인. 최소한 적게 사용하게
    }
    
    var posts : [Post] {
        service.posts
    }
    
    init(service: PostService) {
        self.service = service
        self.service.onPostEvent.sink { event in
            switch event {
            case .postUpdate :
                self.subject.send(.postUpdated)
            }
            
        }.store(in: &cancellable)
    }
    
    func loadPostList() {
        let currentDate = Date()
        service.loadPost(date: currentDate, page: 0)
        
    }
    
    func addPost(contents : String) {
        service.addPost(contents: "test") { [weak self] error in
            self?.subject.send(.postAdded(error))
        }
    }
    
    func removePost(post: Post) {
        service.removePost(postId: post.postId) { [weak self] error in
            self?.subject.send(.postRemoved(error))
        }
    }
    
    func reportPost(post: Post) {
        service.reportPost(postId: post.postId) { [weak self] error in
            self?.subject.send(.postReported(error))
        }
    }
}
